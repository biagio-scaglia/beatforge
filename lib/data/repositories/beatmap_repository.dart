import 'package:flutter/widgets.dart';
import 'package:drift/drift.dart';
import '../local/database/app_database.dart';

/// Modello combinato per rappresentare una beatmap completa con tutti i suoi dettagli.
class BeatmapWithDetails {
  final Beatmap beatmap;
  final List<TimingPoint> timingPoints;
  final List<BeatmapNote> notes;

  BeatmapWithDetails({
    required this.beatmap,
    required this.timingPoints,
    required this.notes,
  });
}

/// Repository per gestire le operazioni sulle beatmap, i timing points e le note ritmiche.
class BeatmapRepository {
  final AppDatabase _db;

  BeatmapRepository(this._db);

  /// Stream reattivo che osserva le beatmap associate a una specifica traccia.
  Stream<List<Beatmap>> watchBeatmapsForTrack(int trackId) {
    return (_db.select(
      _db.beatmaps,
    )..where((b) => b.trackId.equals(trackId))).watch();
  }

  /// Recupera le beatmap associate a una specifica traccia.
  Future<List<Beatmap>> getBeatmapsForTrack(int trackId) {
    return (_db.select(
      _db.beatmaps,
    )..where((b) => b.trackId.equals(trackId))).get();
  }

  /// Recupera i dettagli completi di una singola beatmap (inclusi note e timing points).
  Future<BeatmapWithDetails?> getBeatmapWithDetails(int beatmapId) async {
    final beatmap = await (_db.select(
      _db.beatmaps,
    )..where((b) => b.id.equals(beatmapId))).getSingleOrNull();
    if (beatmap == null) return null;

    final timingPoints =
        await (_db.select(_db.timingPoints)
              ..where((tp) => tp.beatmapId.equals(beatmapId))
              ..orderBy([(t) => OrderingTerm(expression: t.timeMs)]))
            .get();

    final notes =
        await (_db.select(_db.beatmapNotes)
              ..where((n) => n.beatmapId.equals(beatmapId))
              ..orderBy([(t) => OrderingTerm(expression: t.timeMs)]))
            .get();

    return BeatmapWithDetails(
      beatmap: beatmap,
      timingPoints: timingPoints,
      notes: notes,
    );
  }

  /// Crea una nuova beatmap nel database.
  Future<int> createBeatmap(BeatmapsCompanion companion) {
    return _db.into(_db.beatmaps).insert(companion);
  }

  /// Elimina una beatmap (e i relativi record a cascata).
  Future<void> deleteBeatmap(int beatmapId) async {
    await (_db.delete(_db.beatmaps)..where((b) => b.id.equals(beatmapId))).go();
  }

  /// Salva o aggiorna i timing points e le note di una beatmap all'interno di una singola transazione.
  Future<void> saveBeatmapDetails({
    required int beatmapId,
    required List<TimingPointsCompanion> timingPoints,
    required List<BeatmapNotesCompanion> notes,
  }) async {
    await _db.transaction(() async {
      // Elimina i record esistenti associati a questa beatmap
      await (_db.delete(
        _db.timingPoints,
      )..where((tp) => tp.beatmapId.equals(beatmapId))).go();
      await (_db.delete(
        _db.beatmapNotes,
      )..where((n) => n.beatmapId.equals(beatmapId))).go();

      // Inserisce i nuovi timing points
      for (final tp in timingPoints) {
        await _db.into(_db.timingPoints).insert(tp);
      }

      // Inserisce le nuove note
      for (final note in notes) {
        await _db.into(_db.beatmapNotes).insert(note);
      }

      // Aggiorna l'updatedAt della beatmap
      await (_db.update(_db.beatmaps)..where((b) => b.id.equals(beatmapId)))
          .write(BeatmapsCompanion(updatedAt: Value(DateTime.now())));
    });
  }
}

/// Provider basato su [InheritedWidget] per propagare [BeatmapRepository] nell'albero dei widget.
class BeatmapRepositoryProvider extends InheritedWidget {
  final BeatmapRepository repository;

  const BeatmapRepositoryProvider({
    super.key,
    required this.repository,
    required super.child,
  });

  static BeatmapRepository of(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<BeatmapRepositoryProvider>()
        : context.getInheritedWidgetOfExactType<BeatmapRepositoryProvider>();
    assert(
      provider != null,
      'Nessun BeatmapRepositoryProvider trovato nel context.',
    );
    return provider!.repository;
  }

  @override
  bool updateShouldNotify(BeatmapRepositoryProvider oldWidget) {
    return repository != oldWidget.repository;
  }
}
