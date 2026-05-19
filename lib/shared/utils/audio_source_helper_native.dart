import 'dart:io';
import 'package:just_audio/just_audio.dart';
import '../../../data/local/database/app_database.dart';
import '../../../data/repositories/audio_repository.dart';

Future<AudioSource> createAudioSource(
  AudioTrack track,
  AudioRepository repository,
) async {
  if (track.localPath == null) {
    throw Exception(
      "Percorso locale non presente per la traccia: ${track.displayName}",
    );
  }
  final file = File(track.localPath!);
  if (!await file.exists()) {
    throw Exception("File locale non trovato su disco: ${track.localPath}");
  }
  return AudioSource.uri(Uri.file(track.localPath!));
}
