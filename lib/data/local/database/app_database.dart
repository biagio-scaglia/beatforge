import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// La tabella per memorizzare i metadati delle tracce audio importate.
class AudioTracks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get displayName => text()();
  TextColumn get fileName => text()();
  TextColumn get extension => text()();
  IntColumn get sizeBytes => integer()();
  TextColumn get localPath => text().nullable()();
  TextColumn get webStorageKey => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// La tabella per memorizzare le categorie disponibili (es. Practice, Favorites, ecc.).
class TrackCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
}

/// La tabella di collegamento molti-a-molti tra tracce audio e categorie.
class TrackCategoryLinks extends Table {
  IntColumn get trackId =>
      integer().references(AudioTracks, #id, onDelete: KeyAction.cascade)();
  IntColumn get categoryId =>
      integer().references(TrackCategories, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {trackId, categoryId};
}

/// La tabella per memorizzare i dati binari effettivi (BLOB) per il web.
/// Questa tabella viene usata per archiviare i byte dei file audio quando si esegue su Chrome/Web,
/// dato che il web non ha accesso diretto al file system locale persistente.
class AudioTrackData extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get trackId =>
      integer().references(AudioTracks, #id, onDelete: KeyAction.cascade)();
  BlobColumn get bytes => blob()();
}

@DriftDatabase(
  tables: [AudioTracks, TrackCategories, TrackCategoryLinks, AudioTrackData],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(
        driftDatabase(
          name: 'beatforge_database',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        // Popola con le categorie iniziali richieste
        await batch((b) {
          b.insertAll(trackCategories, [
            TrackCategoriesCompanion.insert(name: 'Practice'),
            TrackCategoriesCompanion.insert(name: 'Favorites'),
            TrackCategoriesCompanion.insert(name: 'Test'),
            TrackCategoriesCompanion.insert(name: 'Custom'),
          ]);
        });
      },
    );
  }
}
