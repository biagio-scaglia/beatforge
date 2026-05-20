import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../data/local/database/app_database.dart';
import '../../../data/repositories/audio_repository.dart';
import '../../../data/repositories/beatmap_repository.dart';
import '../../../shared/services/audio_player_service.dart';
import '../models/gameplay_state.dart';
import '../models/gameplay_config.dart';
import '../services/audio_sync_service.dart';

/// Evento generato quando una nota viene colpita con successo.
class NoteHitEvent {
  final NoteRuntimeModel note;
  final Judgment judgment;
  final int offsetMs;

  NoteHitEvent({
    required this.note,
    required this.judgment,
    required this.offsetMs,
  });
}

/// Controller principale del modulo Gameplay.
///
/// Gestisce il ciclo di vita della partita (ready, countdown, playing, completed),
/// coordina il caricamento dei dati della beatmap dal database Drift, elabora l'input
/// dell'utente confrontando i millisecondi dei tap con l'orario effettivo del brano
/// estrapolato dall'orologio di [AudioSyncService], e aggiorna score/combo.
class GameplayController extends ChangeNotifier {
  final int beatmapId;
  final BeatmapRepository beatmapRepository;
  final AudioRepository audioRepository;
  final AudioPlayerService playerService;

  bool _isLoading = true;
  GameplayStatus _status = GameplayStatus.ready;

  Beatmap? _beatmap;
  AudioTrack? _track;
  List<NoteRuntimeModel> _notes = [];

  AudioSyncService? _syncService;
  final ScoringState _scoringState = ScoringState();
  final HealthState _healthState = HealthState();

  // Streams per comunicare eventi a Flame (es. trigger di animazioni grafiche)
  final StreamController<NoteHitEvent> _onNoteHitController =
      StreamController<NoteHitEvent>.broadcast();
  final StreamController<NoteRuntimeModel> _onNoteMissedController =
      StreamController<NoteRuntimeModel>.broadcast();
  final StreamController<void> _onSongCompletedController =
      StreamController<void>.broadcast();

  // Timer per il countdown iniziale
  Timer? _countdownTimer;
  int _countdownSeconds = 3;

  // Listener per monitorare il completamento del brano
  StreamSubscription? _playerStateSubscription;

  GameplayController({
    required this.beatmapId,
    required this.beatmapRepository,
    required this.audioRepository,
    required this.playerService,
  });

  bool get isLoading => _isLoading;
  GameplayStatus get status => _status;
  Beatmap? get beatmap => _beatmap;
  AudioTrack? get track => _track;
  List<NoteRuntimeModel> get notes => _notes;
  ScoringState get scoringState => _scoringState;
  HealthState get healthState => _healthState;
  int get countdownSeconds => _countdownSeconds;

  /// Profilo di difficoltà corrente basato sul nome della beatmap
  DifficultyProfile get difficultyProfile =>
      DifficultyProfile.fromDifficultyName(
        _beatmap?.difficultyName ?? 'Normal',
      );

  Stream<NoteHitEvent> get onNoteHit => _onNoteHitController.stream;
  Stream<NoteRuntimeModel> get onNoteMissed => _onNoteMissedController.stream;
  Stream<void> get onSongCompleted => _onSongCompletedController.stream;

  /// Ritorna il tempo audio corrente fluidificato ed estrapolato in millisecondi.
  int get currentSongTimeMs {
    if (_syncService == null) return 0;
    return _syncService!.getAdjustedTimeMs(_beatmap?.audioOffsetMs ?? 0);
  }

  /// Carica i dettagli del brano e le note della beatmap.
  Future<void> loadGameplay() async {
    _isLoading = true;
    _status = GameplayStatus.ready;

    // Resetta punteggio e salute prima del caricamento della partita
    _scoringState.score = 0;
    _scoringState.combo = 0;
    _scoringState.maxCombo = 0;
    _scoringState.perfectCount = 0;
    _scoringState.greatCount = 0;
    _scoringState.goodCount = 0;
    _scoringState.missCount = 0;
    _healthState.reset();

    notifyListeners();

    try {
      final details = await beatmapRepository.getBeatmapWithDetails(beatmapId);
      if (details == null) {
        throw Exception("Beatmap non trovata.");
      }

      _beatmap = details.beatmap;

      // Recupera la traccia audio associata
      final tracks = await audioRepository.getTracks();
      _track = tracks.firstWhere((t) => t.id == _beatmap!.trackId);

      // Converte le note in modelli runtime
      _notes = details.notes.map((n) {
        return NoteRuntimeModel(
          id: n.id,
          timeMs: n.timeMs,
          lane: n.lane,
          type: n.type,
          durationMs: n.durationMs,
          direction: n.direction,
        );
      }).toList();

      // Se non ci sono note registrate (es. canzone appena importata senza note salvate),
      // generiamo un tracciato ritmico procedurale basato sul BPM per renderla subito giocabile.
      if (_notes.isEmpty) {
        final bpm = _beatmap?.baseBpm ?? 120.0;
        final double beatMs = 60000.0 / bpm;
        final int maxTimeMs =
            300000; // Genera note per max 5 minuti (la sessione si chiude alla fine dell'audio)
        int currentMs = 2000; // Inizia dopo 2 secondi
        int step = 0;

        while (currentMs < maxTimeMs) {
          final int lane = step % 4;
          final int patternIndex = (step ~/ 4) % 4;

          String type = 'tap';
          int? durationMs;
          String? direction;

          if (patternIndex == 3 && step % 4 == 0) {
            type = 'hold';
            durationMs = (beatMs * 1.5).toInt();
          } else if (patternIndex == 2 && step % 2 == 1) {
            type = 'flick';
            direction = lane % 2 == 0 ? 'up' : 'down';
          }

          _notes.add(
            NoteRuntimeModel(
              id: step,
              timeMs: currentMs,
              lane: lane,
              type: type,
              durationMs: durationMs,
              direction: direction,
            ),
          );

          // Variazione ritmica: raddoppio velocità su pattern alternati
          if (patternIndex == 1) {
            currentMs += (beatMs / 2).toInt();
          } else {
            currentMs += beatMs.toInt();
          }
          step++;
        }
      }

      // Ordina le note per tempo di esecuzione
      _notes.sort((a, b) => a.timeMs.compareTo(b.timeMs));

      debugPrint(
        "Gameplay loaded: ${_notes.length} notes loaded/generated for beatmap $beatmapId",
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("Errore nel caricamento del gameplay: $e");
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  /// Avvia il conto alla rovescia prima del play audio reale.
  void startCountdown() {
    if (_status != GameplayStatus.ready) return;

    _status = GameplayStatus.countdown;
    _countdownSeconds = 3;
    notifyListeners();

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      _countdownSeconds--;
      if (_countdownSeconds <= 0) {
        timer.cancel();
        await _startGame();
      } else {
        notifyListeners();
      }
    });
  }

  /// Avvia la riproduzione audio e aggancia il sincronizzatore.
  Future<void> _startGame() async {
    if (_track == null) return;

    try {
      _status = GameplayStatus.playing;
      notifyListeners();

      // Inizializza l'AudioSyncService prima dell'avvio reale
      _syncService = AudioSyncService(playerService);

      await playerService.play(_track!, audioRepository);
      notifyListeners();

      // Monitora lo stato per rilevare quando la riproduzione finisce spontaneamente
      _playerStateSubscription?.cancel();
      _playerStateSubscription = playerService.playerStateStream.listen((
        state,
      ) {
        if (state.processingState == ProcessingState.completed) {
          _completeSession();
        }
      });
    } catch (e) {
      debugPrint("Impossibile avviare la traccia audio: $e");
      _status = GameplayStatus.ready;
      notifyListeners();
    }
  }

  /// Sospende la traccia audio e ferma il cronometro.
  Future<void> pauseGame() async {
    if (_status != GameplayStatus.playing) return;

    _status = GameplayStatus.paused;
    await playerService.pause();
    notifyListeners();
  }

  /// Riprende la riproduzione audio.
  Future<void> resumeGame() async {
    if (_status != GameplayStatus.paused) return;

    _status = GameplayStatus.playing;
    await playerService.resume();
    notifyListeners();
  }

  /// Metodo invocato ad ogni frame del game loop per aggiornare l'accuratezza e rilevare i MISS passati.
  void updateGameplay() {
    if (_status != GameplayStatus.playing || _syncService == null) return;

    final songTime = _syncService!.getAdjustedTimeMs(
      _beatmap?.audioOffsetMs ?? 0,
    );

    // Identifica le note che sono passate oltre la finestra massima di precisione (Miss automatico)
    bool stateChanged = false;
    final int missWindow = difficultyProfile.timingWindowGoodMs;
    for (final note in _notes) {
      if (!note.isHit &&
          !note.isMissed &&
          songTime > note.timeMs + missWindow) {
        note.isMissed = true;
        _applyJudgmentEffect(Judgment.miss);
        _onNoteMissedController.add(note);
        stateChanged = true;
      }
    }

    if (stateChanged) {
      notifyListeners();
    }
  }

  /// Gestisce la pressione del tasto o del touch in una determinata lane (0-3).
  void handleInput(int lane) {
    if (_status != GameplayStatus.playing || _syncService == null) return;

    final songTime = _syncService!.getAdjustedTimeMs(
      _beatmap?.audioOffsetMs ?? 0,
    );
    final int goodWindow = difficultyProfile.timingWindowGoodMs;

    // Trova la nota non ancora colpita più vicina temporalmente in questa lane e all'interno della finestra di hits
    NoteRuntimeModel? targetNote;
    int minDiff = 999999;

    for (final note in _notes) {
      if (note.lane == lane && !note.isHit && !note.isMissed) {
        final diff = (songTime - note.timeMs).abs();
        if (diff <= goodWindow && diff < minDiff) {
          minDiff = diff;
          targetNote = note;
        }
      }
    }

    // Se troviamo una nota valida, calcoliamo il giudizio
    if (targetNote != null) {
      final diff = songTime - targetNote.timeMs;
      final judgment = _evaluateTap(diff);

      targetNote.isHit = true;
      _applyJudgmentEffect(judgment);

      _onNoteHitController.add(
        NoteHitEvent(note: targetNote, judgment: judgment, offsetMs: diff),
      );

      notifyListeners();
    }
  }

  /// Valuta la precisione del millisecondo rispetto alle finestre.
  Judgment _evaluateTap(int diffMs) {
    final absDiff = diffMs.abs();
    final profile = difficultyProfile;
    if (absDiff <= profile.timingWindowPerfectMs) return Judgment.perfect;
    if (absDiff <= profile.timingWindowGreatMs) return Judgment.great;
    if (absDiff <= profile.timingWindowGoodMs) return Judgment.good;
    return Judgment.miss;
  }

  /// Applica gli effetti di un giudizio su punteggio e barra della vita.
  void _applyJudgmentEffect(Judgment judgment) {
    _scoringState.addJudgment(judgment);

    final profile = difficultyProfile;
    if (judgment == Judgment.miss) {
      _healthState.applyPenalty(profile.healthMissPenalty);
    } else if (judgment == Judgment.perfect) {
      _healthState.applyReward(profile.healthPerfectReward);
    } else if (judgment == Judgment.great) {
      _healthState.applyReward(profile.healthGreatReward);
    } else if (judgment == Judgment.good) {
      _healthState.applyReward(profile.healthGoodReward);
    }

    // Se la salute scende a zero, interrompiamo la partita come sconfitta (fail)
    if (_healthState.isDead && _status == GameplayStatus.playing) {
      _failGame();
    }
  }

  /// Gestisce la transizione allo stato di fallimento (sconfitta).
  Future<void> _failGame() async {
    _status = GameplayStatus.failed;
    _countdownTimer?.cancel();
    _playerStateSubscription?.cancel();
    await playerService
        .pause(); // Sospende la riproduzione audio immediatamente
    notifyListeners();
  }

  /// Conclude la sessione di gioco a fine brano.
  void _completeSession() {
    _status = GameplayStatus.completed;
    _playerStateSubscription?.cancel();
    _onSongCompletedController.add(null);
    notifyListeners();
  }

  /// Ripristina lo stato del gameplay per riavviare la partita.
  Future<void> restartGame() async {
    _countdownTimer?.cancel();
    _playerStateSubscription?.cancel();
    await playerService.stop();

    _scoringState.score = 0;
    _scoringState.combo = 0;
    _scoringState.maxCombo = 0;
    _scoringState.perfectCount = 0;
    _scoringState.greatCount = 0;
    _scoringState.goodCount = 0;
    _scoringState.missCount = 0;

    await loadGameplay();
    startCountdown();
  }

  /// Interrompe del tutto il gameplay e pulisce le risorse.
  Future<void> quitGame() async {
    _countdownTimer?.cancel();
    _playerStateSubscription?.cancel();
    _syncService?.dispose();
    await playerService.stop();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _playerStateSubscription?.cancel();
    _syncService?.dispose();
    _onNoteHitController.close();
    _onNoteMissedController.close();
    _onSongCompletedController.close();
    super.dispose();
  }

  /// Ritorna la percentuale di progresso corrente del brano (0.0 a 1.0).
  double get progress {
    if (_syncService == null) return 0.0;
    final duration = playerService.player.duration?.inMilliseconds ?? 0;
    if (duration == 0) return 0.0;
    final progress = _syncService!.currentSongTimeMs / duration;
    return progress.clamp(0.0, 1.0);
  }
}
