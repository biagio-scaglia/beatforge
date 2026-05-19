import 'dart:js_interop';
import 'package:just_audio/just_audio.dart';
import 'package:web/web.dart' as web;
import '../../../data/local/database/app_database.dart';
import '../../../data/repositories/audio_repository.dart';

String? _activeBlobUrl;

Future<AudioSource> createAudioSource(
  AudioTrack track,
  AudioRepository repository,
) async {
  // Revoca l'URL precedente per evitare memory leaks
  if (_activeBlobUrl != null) {
    try {
      web.URL.revokeObjectURL(_activeBlobUrl!);
    } catch (_) {}
    _activeBlobUrl = null;
  }

  final bytes = await repository.getAudioTrackBytes(track.id);
  if (bytes == null || bytes.isEmpty) {
    throw Exception(
      "Byte audio non trovati nel database per la traccia: ${track.displayName}",
    );
  }

  // Crea un Blob e un Object URL a partire dai byte
  final blob = web.Blob(
    [bytes.toJS].toJS,
    web.BlobPropertyBag(type: 'audio/mpeg'),
  );
  final url = web.URL.createObjectURL(blob);
  _activeBlobUrl = url;

  return AudioSource.uri(Uri.parse(url));
}
