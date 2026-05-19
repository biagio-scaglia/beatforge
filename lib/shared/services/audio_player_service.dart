import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import '../../../data/local/database/app_database.dart';
import '../../../data/repositories/audio_repository.dart';
import '../utils/audio_source_helper.dart';

/// Servizio centralizzato per gestire il player audio (just_audio).
/// Incapsula il player ed espone lo stato tramite ValueNotifier e Stream.
class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();
  final ValueNotifier<AudioTrack?> currentTrackNotifier =
      ValueNotifier<AudioTrack?>(null);

  AudioPlayerService();

  AudioTrack? get currentTrack => currentTrackNotifier.value;
  AudioPlayer get player => _player;

  /// Stream che emette lo stato di riproduzione (loading, playing, idle).
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  /// Stream che emette la posizione corrente del brano.
  Stream<Duration> get positionStream => _player.positionStream;

  /// Stream che emette la durata totale del brano corrente.
  Stream<Duration?> get durationStream => _player.durationStream;

  /// Carica ed avvia un brano musicale.
  Future<void> play(AudioTrack track, AudioRepository repository) async {
    try {
      if (currentTrack?.id == track.id) {
        if (!_player.playing) {
          await _player.play();
        }
        return;
      }

      // Ferma la riproduzione corrente prima di caricarne una nuova
      await _player.stop();
      currentTrackNotifier.value = track;

      // Crea l'AudioSource corretto (Blob URL su Web o File Path su Native)
      final source = await createAudioSource(track, repository);

      await _player.setAudioSource(source);
      await _player.play();
    } catch (e) {
      debugPrint("Errore di riproduzione audio: $e");
      currentTrackNotifier.value = null;
      rethrow;
    }
  }

  /// Mette in pausa il brano corrente.
  Future<void> pause() async {
    await _player.pause();
  }

  /// Riprende la riproduzione del brano corrente.
  Future<void> resume() async {
    if (currentTrack != null) {
      await _player.play();
    }
  }

  /// Cambia la posizione corrente del brano (seek).
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  /// Ferma la riproduzione e svuota la traccia corrente.
  Future<void> stop() async {
    await _player.stop();
    currentTrackNotifier.value = null;
  }

  /// Distrugge il player liberando le risorse di sistema.
  Future<void> dispose() async {
    await _player.dispose();
    currentTrackNotifier.dispose();
  }
}
