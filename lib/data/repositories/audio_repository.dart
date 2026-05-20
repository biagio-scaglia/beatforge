import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import '../local/database/app_database.dart';

/// Modello combinato per rappresentare una traccia e le sue categorie associate.
class TrackWithCategories {
  final AudioTrack track;
  final List<TrackCategory> categories;

  TrackWithCategories({required this.track, required this.categories});
}

/// Repository per gestire le operazioni sui file audio e l'interazione con Drift.
class AudioRepository {
  final AppDatabase _db;

  AudioRepository(this._db);

  /// Stream reattivo che emette la lista di tutte le tracce con le loro categorie associate.
  Stream<List<TrackWithCategories>> watchTracksWithCategories() {
    final query = _db.select(_db.audioTracks).join([
      leftOuterJoin(
        _db.trackCategoryLinks,
        _db.trackCategoryLinks.trackId.equalsExp(_db.audioTracks.id),
      ),
      leftOuterJoin(
        _db.trackCategories,
        _db.trackCategories.id.equalsExp(_db.trackCategoryLinks.categoryId),
      ),
    ]);

    return query.watch().map((rows) {
      final Map<int, TrackWithCategories> trackMap = {};

      for (final row in rows) {
        final track = row.readTable(_db.audioTracks);
        final category = row.readTableOrNull(_db.trackCategories);

        final entry = trackMap.putIfAbsent(
          track.id,
          () => TrackWithCategories(track: track, categories: []),
        );

        if (category != null) {
          entry.categories.add(category);
        }
      }

      return trackMap.values.toList();
    });
  }

  /// Recupera tutte le tracce disponibili nel database.
  Future<List<AudioTrack>> getTracks() {
    return _db.select(_db.audioTracks).get();
  }

  /// Recupera tutte le categorie disponibili nel database.
  Future<List<TrackCategory>> getCategories() {
    return _db.select(_db.trackCategories).get();
  }

  /// Stream reattivo che emette la lista di tutte le categorie disponibili.
  Stream<List<TrackCategory>> watchCategories() {
    return _db.select(_db.trackCategories).watch();
  }

  /// Importa un file audio salvando i metadati nel database.
  /// Su Web, i byte vengono inseriti nella tabella [AudioTrackData].
  /// Su Native, il file viene copiato nella cartella Documenti dell'applicazione.
  Future<void> importAudioTrack({
    required String displayName,
    required String fileName,
    required String extension,
    required int sizeBytes,
    Uint8List? bytes,
    String? localPath,
  }) async {
    String? savedPath;

    if (!kIsWeb) {
      if (localPath != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final tracksDir = Directory('${appDir.path}/tracks');
        if (!await tracksDir.exists()) {
          await tracksDir.create(recursive: true);
        }
        // Evita collisioni usando un timestamp
        final uniqueFileName =
            '${DateTime.now().millisecondsSinceEpoch}_$fileName';
        final newFile = File('${tracksDir.path}/$uniqueFileName');
        final sourceFile = File(localPath);
        await sourceFile.copy(newFile.path);
        savedPath = newFile.path;
      }
    }

    await _db.transaction(() async {
      final trackId = await _db
          .into(_db.audioTracks)
          .insert(
            AudioTracksCompanion.insert(
              displayName: displayName,
              fileName: fileName,
              extension: extension,
              sizeBytes: sizeBytes,
              localPath: Value(savedPath),
              webStorageKey: Value(kIsWeb ? 'db' : null),
            ),
          );

      if (kIsWeb && bytes != null) {
        await _db
            .into(_db.audioTrackData)
            .insert(
              AudioTrackDataCompanion.insert(trackId: trackId, bytes: bytes),
            );
      }
    });
  }

  /// Recupera i byte audio associati a una traccia (utilizzato principalmente su Web).
  Future<Uint8List?> getAudioTrackBytes(int trackId) async {
    final data = await (_db.select(
      _db.audioTrackData,
    )..where((d) => d.trackId.equals(trackId))).getSingleOrNull();
    return data?.bytes;
  }

  /// Elimina una traccia audio dal database.
  /// Rimuove anche il file locale associato su piattaforme native.
  Future<void> deleteAudioTrack(int trackId) async {
    final track = await (_db.select(
      _db.audioTracks,
    )..where((t) => t.id.equals(trackId))).getSingleOrNull();
    if (track == null) return;

    if (!kIsWeb && track.localPath != null) {
      final file = File(track.localPath!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    // L'eliminazione a cascata rimuove i record in trackCategoryLinks e audioTrackData.
    await (_db.delete(
      _db.audioTracks,
    )..where((t) => t.id.equals(trackId))).go();
  }

  /// Assegna una categoria a una traccia.
  Future<void> assignCategoryToTrack(int trackId, int categoryId) async {
    await _db
        .into(_db.trackCategoryLinks)
        .insert(
          TrackCategoryLinksCompanion.insert(
            trackId: trackId,
            categoryId: categoryId,
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  /// Rimuove una categoria da una traccia.
  Future<void> removeCategoryFromTrack(int trackId, int categoryId) async {
    await (_db.delete(_db.trackCategoryLinks)..where(
          (l) => l.trackId.equals(trackId) & l.categoryId.equals(categoryId),
        ))
        .go();
  }
}

/// Provider basato su [InheritedWidget] per propagare [AudioRepository] nell'albero dei widget.
class AudioRepositoryProvider extends InheritedWidget {
  final AudioRepository repository;

  const AudioRepositoryProvider({
    super.key,
    required this.repository,
    required super.child,
  });

  static AudioRepository of(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<AudioRepositoryProvider>()
        : context.getInheritedWidgetOfExactType<AudioRepositoryProvider>();
    assert(
      provider != null,
      'Nessun AudioRepositoryProvider trovato nel context.',
    );
    return provider!.repository;
  }

  @override
  bool updateShouldNotify(AudioRepositoryProvider oldWidget) {
    return repository != oldWidget.repository;
  }
}
