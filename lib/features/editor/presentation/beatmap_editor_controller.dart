import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' as drift;
import '../../../data/local/database/app_database.dart';
import '../../../data/repositories/beatmap_repository.dart';
import '../../../data/repositories/audio_repository.dart';
import '../../../shared/services/audio_player_service.dart';

/// Controller per la gestione dello stato e della logica di business all'interno del Beatmap Editor.
///
/// Mantiene in memoria le note e i timing point, permettendo modifiche veloci senza
/// gravare sul database Drift ad ogni tap, per poi persistere tutto in transazione al salvataggio.
class BeatmapEditorController extends ChangeNotifier {
  final Beatmap beatmap;
  final AudioTrack track;
  final BeatmapRepository beatmapRepository;
  final AudioRepository audioRepository;
  final AudioPlayerService playerService;

  List<BeatmapNote> _notes = [];
  List<TimingPoint> _timingPoints = [];
  BeatmapNote? _selectedNote;

  String _activeNoteType = 'tap'; // 'tap', 'hold', 'flick'
  int _activeLane = 0; // 0, 1, 2, 3
  int _gridSnapDivisor =
      4; // 1 = 1 beat, 2 = 1/2 beat, 4 = 1/4 beat, 0 = nessun snap
  double _zoom =
      0.2; // Scala pixel/millisecondo (es. 0.2px = 1ms, quindi 1sec = 200px)
  double _speed = 1.0; // Velocità di riproduzione audio
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isDirty = false;

  BeatmapEditorController({
    required this.beatmap,
    required this.track,
    required this.beatmapRepository,
    required this.audioRepository,
    required this.playerService,
  }) {
    _speed = playerService.player.speed;
  }

  // Getters
  List<BeatmapNote> get notes => _notes;
  List<TimingPoint> get timingPoints => _timingPoints;
  BeatmapNote? get selectedNote => _selectedNote;
  String get activeNoteType => _activeNoteType;
  int get activeLane => _activeLane;
  int get gridSnapDivisor => _gridSnapDivisor;
  double get zoom => _zoom;
  double get speed => _speed;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get isDirty => _isDirty;

  // Setters
  set activeNoteType(String val) {
    if (_activeNoteType != val) {
      _activeNoteType = val;
      notifyListeners();
    }
  }

  set activeLane(int val) {
    if (_activeLane != val) {
      _activeLane = val;
      notifyListeners();
    }
  }

  set gridSnapDivisor(int val) {
    if (_gridSnapDivisor != val) {
      _gridSnapDivisor = val;
      notifyListeners();
    }
  }

  set zoom(double val) {
    final double clamped = val.clamp(0.05, 1.0);
    if (_zoom != clamped) {
      _zoom = clamped;
      notifyListeners();
    }
  }

  /// Inizializza il controller caricando le note e i timing point dal database locale.
  Future<void> loadDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      final details = await beatmapRepository.getBeatmapWithDetails(beatmap.id);
      if (details != null) {
        // Ordina le note per tempo crescente
        _notes = List.from(details.notes)
          ..sort((a, b) => a.timeMs.compareTo(b.timeMs));
        _timingPoints = List.from(details.timingPoints)
          ..sort((a, b) => a.timeMs.compareTo(b.timeMs));
      }
      _isDirty = false;
    } catch (e) {
      debugPrint("Errore nel caricamento dei dettagli della beatmap: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Seleziona o deseleziona una nota.
  void selectNote(BeatmapNote? note) {
    _selectedNote = note;
    notifyListeners();
  }

  /// Cambia la velocità di riproduzione del player audio per consentire un mapping preciso.
  Future<void> setPlaybackSpeed(double newSpeed) async {
    _speed = newSpeed;
    await playerService.player.setSpeed(newSpeed);
    notifyListeners();
  }

  /// Esegue lo snap temporale dei millisecondi in base al BPM della beatmap e alla griglia selezionata.
  int getSnappedTime(int timeMs) {
    if (_gridSnapDivisor <= 0) return timeMs;

    final double bpm = beatmap.baseBpm > 0 ? beatmap.baseBpm : 120.0;
    final double beatDurationMs = 60000.0 / bpm;
    final double snapUnitMs = beatDurationMs / _gridSnapDivisor;

    if (snapUnitMs <= 0) return timeMs;

    return (timeMs / snapUnitMs).round() * snapUnitMs.round();
  }

  /// Aggiunge una nota al tempo corrente del player audio o a un tempo specifico.
  /// Se [timeMs] è nullo, viene utilizzato il tempo corrente del player (snappato se abilitato).
  void addNote({int? timeMs, int? lane, String? type}) {
    final int finalLane = lane ?? _activeLane;
    final String finalType = type ?? _activeNoteType;

    int rawTime = timeMs ?? playerService.player.position.inMilliseconds;
    int snappedTime = getSnappedTime(rawTime);
    if (snappedTime < 0) snappedTime = 0;

    // Crea un ID fittizio negativo temporaneo per le note non ancora salvate a DB
    final int tempId = _notes.isEmpty
        ? -1
        : _notes.map((n) => n.id).reduce((min, id) => id < min ? id : min) - 1;

    final newNote = BeatmapNote(
      id: tempId,
      beatmapId: beatmap.id,
      timeMs: snappedTime,
      lane: finalLane,
      type: finalType,
      durationMs: finalType == 'hold' ? 500 : null,
      direction: finalType == 'flick' ? 'up' : null,
    );

    _notes.add(newNote);
    // Riordina la lista per tempo
    _notes.sort((a, b) => a.timeMs.compareTo(b.timeMs));

    // Seleziona automaticamente la nuova nota creata
    _selectedNote = newNote;
    _isDirty = true;

    notifyListeners();
  }

  /// Aggiorna i campi di una nota specifica in memoria.
  void updateNote(
    int noteId, {
    int? timeMs,
    int? lane,
    String? type,
    int? durationMs,
    String? direction,
  }) {
    final index = _notes.indexWhere((n) => n.id == noteId);
    if (index == -1) return;

    final existing = _notes[index];

    // Gestione condizionale dei parametri basati sul tipo nota
    String finalType = type ?? existing.type;
    int? finalDuration = finalType == 'hold'
        ? (durationMs ?? existing.durationMs ?? 500)
        : null;
    String? finalDirection = finalType == 'flick'
        ? (direction ?? existing.direction ?? 'up')
        : null;

    final updatedNote = existing.copyWith(
      timeMs: timeMs ?? existing.timeMs,
      lane: lane ?? existing.lane,
      type: finalType,
      durationMs: drift.Value(finalDuration),
      direction: drift.Value(finalDirection),
    );

    _notes[index] = updatedNote;

    // Riordina se il tempo è cambiato
    if (timeMs != null) {
      _notes.sort((a, b) => a.timeMs.compareTo(b.timeMs));
    }

    // Se era la nota selezionata, aggiorna il riferimento
    if (_selectedNote?.id == noteId) {
      _selectedNote = updatedNote;
    }
    _isDirty = true;

    notifyListeners();
  }

  /// Elimina una nota in memoria.
  void deleteNote(int noteId) {
    _notes.removeWhere((n) => n.id == noteId);
    if (_selectedNote?.id == noteId) {
      _selectedNote = null;
    }
    _isDirty = true;
    notifyListeners();
  }

  /// Salva tutte le modifiche correnti (in memoria) nel database locale SQLite via Drift.
  Future<void> save() async {
    _isSaving = true;
    notifyListeners();

    try {
      // Mappa le note in-memory a Drift Companion.
      // Gli ID negativi temporanei vengono scartati e inseriti come nuovi record.
      final noteCompanions = _notes.map((n) {
        return BeatmapNotesCompanion.insert(
          beatmapId: beatmap.id,
          timeMs: n.timeMs,
          lane: n.lane,
          type: n.type,
          durationMs: drift.Value(n.durationMs),
          direction: drift.Value(n.direction),
          positionX: drift.Value(n.lane * 0.25),
          positionY: const drift.Value(0.9),
        );
      }).toList();

      // Mappa i timing point
      final timingCompanions = _timingPoints.map((tp) {
        return TimingPointsCompanion.insert(
          beatmapId: beatmap.id,
          timeMs: tp.timeMs,
          bpm: tp.bpm,
          meter: drift.Value(tp.meter),
        );
      }).toList();

      // Se non ci sono timing points, ne creiamo uno di default al tempo 0
      if (timingCompanions.isEmpty) {
        timingCompanions.add(
          TimingPointsCompanion.insert(
            beatmapId: beatmap.id,
            timeMs: 0,
            bpm: beatmap.baseBpm > 0 ? beatmap.baseBpm : 120.0,
            meter: const drift.Value(4),
          ),
        );
      }

      await beatmapRepository.saveBeatmapDetails(
        beatmapId: beatmap.id,
        timingPoints: timingCompanions,
        notes: noteCompanions,
      );

      _isDirty = false;
      // Ricarica per allineare gli ID effettivi del DB
      await loadDetails();
    } catch (e) {
      debugPrint("Errore durante il salvataggio dei dati Drift: $e");
      rethrow;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Ripristina la velocità di riproduzione standard quando si esce dall'editor
    playerService.player.setSpeed(1.0).catchError((e) {
      debugPrint("Errore nel reset velocità player: $e");
    });
    super.dispose();
  }
}
