import 'package:just_audio/just_audio.dart';
import '../../../data/local/database/app_database.dart';
import '../../../data/repositories/audio_repository.dart';

Future<AudioSource> createAudioSource(
  AudioTrack track,
  AudioRepository repository,
) async {
  throw UnsupportedError("Piattaforma non supportata per l'audio source");
}
