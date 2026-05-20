import 'dart:async';
import '../../../shared/services/audio_player_service.dart';

/// Servizio per la sincronizzazione ultra-precisa tra l'orologio audio e la grafica.
///
/// Poiché il clock di posizione del player audio (`just_audio`) si aggiorna solitamente a intervalli discreti
/// (circa ogni 200 ms), l'uso diretto del timer provocherebbe microscatti o ritardi nello scorrimento visivo.
/// Questo servizio implementa una sincronizzazione ibrida: all'aggiornamento di posizione reale dell'audio,
/// resetta un cronometro ad alta precisione ([Stopwatch]) che stima i millisecondi trascorsi fino al frame successivo.
class AudioSyncService {
  final AudioPlayerService _audioPlayerService;

  final Stopwatch _stopwatch = Stopwatch();
  int _lastBaseTimeMs = 0;
  StreamSubscription? _positionSub;
  StreamSubscription? _stateSub;

  AudioSyncService(this._audioPlayerService) {
    _init();
  }

  void _init() {
    // Sincronizza al cambiamento di posizione effettivo inviato dal player
    _positionSub = _audioPlayerService.positionStream.listen((pos) {
      _lastBaseTimeMs = pos.inMilliseconds;
      _stopwatch.reset();
      if (_audioPlayerService.isPlaying) {
        _stopwatch.start();
      } else {
        _stopwatch.stop();
      }
    });

    // Sincronizza allo stato di play/pause
    _stateSub = _audioPlayerService.playerStateStream.listen((state) {
      if (state.playing) {
        if (!_stopwatch.isRunning) {
          _stopwatch.start();
        }
      } else {
        _stopwatch.stop();
      }
    });

    // Inizializzazione base
    _lastBaseTimeMs = _audioPlayerService.player.position.inMilliseconds;
    if (_audioPlayerService.isPlaying) {
      _stopwatch.start();
    }
  }

  /// Restituisce il tempo corrente della canzone in millisecondi in modo fluido ed estrapolato.
  int get currentSongTimeMs {
    if (!_audioPlayerService.isPlaying) {
      return _audioPlayerService.player.position.inMilliseconds;
    }
    // Tempo base + tempo trascorso dall'ultimo tick del player
    return _lastBaseTimeMs + _stopwatch.elapsedMilliseconds;
  }

  /// Consente di calibrare un offset fisso per la traccia corrente (es. offset della beatmap).
  int getAdjustedTimeMs(int offsetMs) {
    return currentSongTimeMs - offsetMs;
  }

  /// Arresta i listener per evitare perdite di memoria.
  void dispose() {
    _positionSub?.cancel();
    _stateSub?.cancel();
    _stopwatch.stop();
  }
}
