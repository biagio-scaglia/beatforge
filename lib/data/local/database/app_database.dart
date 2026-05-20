import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// La tabella per memorizzare i metadati delle tracce audio importate.
class AudioTracks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get displayName => text()();
  TextColumn get fileName => text()();
  TextColumn get extension => text()();
  TextColumn get mimeType => text().nullable()();
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
  IntColumn get colorValue => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
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

/// La tabella per memorizzare le beatmap associate a una traccia audio.
class Beatmaps extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get trackId =>
      integer().references(AudioTracks, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get difficultyName => text()();
  IntColumn get difficultyLevel => integer().nullable()();
  IntColumn get audioOffsetMs => integer().withDefault(const Constant(0))();
  RealColumn get baseBpm => real().withDefault(const Constant(120.0))();
  RealColumn get scrollSpeed => real().withDefault(const Constant(1.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// La tabella per memorizzare i punti di sincronizzazione del tempo (BPM/meter).
class TimingPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get beatmapId =>
      integer().references(Beatmaps, #id, onDelete: KeyAction.cascade)();
  IntColumn get timeMs => integer()();
  RealColumn get bpm => real()();
  IntColumn get meter => integer().withDefault(const Constant(4))();
  BoolColumn get inherited => boolean().withDefault(const Constant(false))();
}

/// La tabella per memorizzare le note (cerchi, hold, ecc.) all'interno di una beatmap.
class BeatmapNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get beatmapId =>
      integer().references(Beatmaps, #id, onDelete: KeyAction.cascade)();
  IntColumn get timeMs => integer()();
  IntColumn get lane => integer()();
  TextColumn get type => text()(); // 'tap', 'hold', 'flick', ecc.
  IntColumn get durationMs => integer().nullable()(); // Durata per hold note
  TextColumn get direction =>
      text().nullable()(); // Direzione per flick note ('up', 'down', ecc.)
  RealColumn get positionX => real().nullable()();
  RealColumn get positionY => real().nullable()();
}

@DriftDatabase(
  tables: [
    AudioTracks,
    TrackCategories,
    TrackCategoryLinks,
    AudioTrackData,
    Beatmaps,
    TimingPoints,
    BeatmapNotes,
  ],
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
  int get schemaVersion => 2;

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
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          // Aggiungi nuove colonne
          await m.addColumn(audioTracks, audioTracks.mimeType);
          await m.addColumn(trackCategories, trackCategories.colorValue);
          await m.addColumn(trackCategories, trackCategories.createdAt);
          // Crea le nuove tabelle
          await m.createTable(beatmaps);
          await m.createTable(timingPoints);
          await m.createTable(beatmapNotes);
        }
      },
    );
  }
}
