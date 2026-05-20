import 'dart:async';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import '../../../data/local/database/app_database.dart';
import '../../../data/repositories/beatmap_repository.dart';
import '../../../data/repositories/audio_repository.dart';
import '../../editor/presentation/beatmap_editor_screen.dart';
import '../../gameplay/presentation/gameplay_screen.dart';
import '../../../shared/services/audio_player_service.dart';
import '../../../shared/services/audio_player_service_provider.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/theme/app_tokens.dart';
import '../../../shared/widgets/glow_text.dart';
import '../../../shared/widgets/neon_button.dart';
import '../../../shared/widgets/beatforge_loader.dart';

/// Un dialogo per visualizzare e gestire le beatmap associate ad una traccia audio.
/// Permette inoltre di generare dati di test (note e timing points) e simulare la riproduzione in sincrono.
class BeatmapDialog extends StatefulWidget {
  final AudioTrack track;

  const BeatmapDialog({super.key, required this.track});

  @override
  State<BeatmapDialog> createState() => _BeatmapDialogState();
}

class _BeatmapDialogState extends State<BeatmapDialog> {
  @override
  Widget build(BuildContext context) {
    final beatmapRepository = BeatmapRepositoryProvider.of(context);
    final audioRepository = AudioRepositoryProvider.of(context);
    final playerService = AudioPlayerServiceProvider.of(context);

    return Dialog(
      backgroundColor: AppTheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusLg),
        side: const BorderSide(color: AppTheme.primaryCyan, width: 1.5),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlowText(
                          'GESTIONE BEATMAP',
                          glowColor: AppTheme.primaryCyan,
                          style: const TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryCyan,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.track.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppTheme.textSecondary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(
                color: AppTheme.borderSubtle,
                height: AppTokens.spacingLg,
              ),

              // Lista Beatmap
              Expanded(
                child: StreamBuilder<List<Beatmap>>(
                  stream: beatmapRepository.watchBeatmapsForTrack(
                    widget.track.id,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: BeatForgeLoader());
                    }

                    final beatmaps = snapshot.data ?? [];

                    if (beatmaps.isEmpty) {
                      return _buildEmptyState(context, beatmapRepository);
                    }

                    return ListView.separated(
                      itemCount: beatmaps.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppTokens.spacingMd),
                      itemBuilder: (context, index) {
                        final beatmap = beatmaps[index];
                        return _BeatmapRowItem(
                          beatmap: beatmap,
                          repository: beatmapRepository,
                          track: widget.track,
                          audioRepository: audioRepository,
                          playerService: playerService,
                        );
                      },
                    );
                  },
                ),
              ),

              const Divider(
                color: AppTheme.borderSubtle,
                height: AppTokens.spacingLg,
              ),

              // Bottom actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NeonButton(
                    text: 'Nuova Beatmap',
                    glowColor: AppTheme.secondaryMagenta,
                    onTap: () =>
                        _showCreateBeatmapForm(context, beatmapRepository),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, BeatmapRepository repository) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.layers_clear_rounded,
            size: 48,
            color: AppTheme.textSecondary,
          ),
          const SizedBox(height: AppTokens.spacingMd),
          const Text(
            'Nessuna Beatmap Associata',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Crea una nuova beatmap per impostare note e timing points.',
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTokens.spacingLg),
          NeonButton(
            text: 'Crea Beatmap di Partenza',
            glowColor: AppTheme.primaryCyan,
            onTap: () => _showCreateBeatmapForm(context, repository),
          ),
        ],
      ),
    );
  }

  void _showCreateBeatmapForm(
    BuildContext context,
    BeatmapRepository repository,
  ) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: 'Mappa Standard');
    final difficultyController = TextEditingController(text: 'Normal');
    int difficultyLevel = 10;
    double baseBpm = 120.0;
    double scrollSpeed = 1.5;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceElevated,
          title: const Text(
            'Nuova Beatmap',
            style: TextStyle(
              color: AppTheme.primaryCyan,
              fontFamily: 'Orbitron',
            ),
          ),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Titolo Beatmap',
                      labelStyle: TextStyle(color: AppTheme.textSecondary),
                    ),
                    style: const TextStyle(color: AppTheme.textPrimary),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Campo obbligatorio' : null,
                  ),
                  TextFormField(
                    controller: difficultyController,
                    decoration: const InputDecoration(
                      labelText: 'Nome Difficoltà (es. Hard)',
                      labelStyle: TextStyle(color: AppTheme.textSecondary),
                    ),
                    style: const TextStyle(color: AppTheme.textPrimary),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Campo obbligatorio' : null,
                  ),
                  TextFormField(
                    initialValue: '10',
                    decoration: const InputDecoration(
                      labelText: 'Livello Difficoltà (1-30)',
                      labelStyle: TextStyle(color: AppTheme.textSecondary),
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    onChanged: (val) =>
                        difficultyLevel = int.tryParse(val) ?? 10,
                  ),
                  TextFormField(
                    initialValue: '120.0',
                    decoration: const InputDecoration(
                      labelText: 'BPM Base',
                      labelStyle: TextStyle(color: AppTheme.textSecondary),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: const TextStyle(color: AppTheme.textPrimary),
                    onChanged: (val) => baseBpm = double.tryParse(val) ?? 120.0,
                  ),
                  TextFormField(
                    initialValue: '1.5',
                    decoration: const InputDecoration(
                      labelText: 'Velocità di Scorrimento (Scroll)',
                      labelStyle: TextStyle(color: AppTheme.textSecondary),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: const TextStyle(color: AppTheme.textPrimary),
                    onChanged: (val) =>
                        scrollSpeed = double.tryParse(val) ?? 1.5,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(
                'Annulla',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryCyan.withValues(alpha: 0.2),
                side: const BorderSide(color: AppTheme.primaryCyan),
              ),
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  await repository.createBeatmap(
                    BeatmapsCompanion.insert(
                      trackId: widget.track.id,
                      title: titleController.text,
                      difficultyName: difficultyController.text,
                      difficultyLevel: drift.Value(difficultyLevel),
                      baseBpm: drift.Value(baseBpm),
                      scrollSpeed: drift.Value(scrollSpeed),
                    ),
                  );
                  if (context.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                }
              },
              child: const Text(
                'Crea',
                style: TextStyle(color: AppTheme.primaryCyan),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Un elemento per riga che rappresenta una beatmap nel dialog e ne visualizza i dettagli con caricamento asincrono.
class _BeatmapRowItem extends StatelessWidget {
  final Beatmap beatmap;
  final BeatmapRepository repository;
  final AudioTrack track;
  final AudioRepository audioRepository;
  final AudioPlayerService playerService;

  const _BeatmapRowItem({
    required this.beatmap,
    required this.repository,
    required this.track,
    required this.audioRepository,
    required this.playerService,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      padding: const EdgeInsets.all(12),
      child: FutureBuilder<BeatmapWithDetails?>(
        future: repository.getBeatmapWithDetails(beatmap.id),
        builder: (context, snapshot) {
          final details = snapshot.data;
          final int timingCount = details?.timingPoints.length ?? 0;
          final int notesCount = details?.notes.length ?? 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info principali e cancellazione
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${beatmap.title} [${beatmap.difficultyName} - Lv.${beatmap.difficultyLevel ?? 0}]',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'BPM: ${beatmap.baseBpm.toStringAsFixed(1)} | Velocità: ${beatmap.scrollSpeed.toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.redAccent,
                      size: 20,
                    ),
                    tooltip: 'Elimina Beatmap',
                    onPressed: () => _confirmDelete(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Statistiche (Timing Points / Note)
              Row(
                children: [
                  _buildStatChip(
                    context,
                    Icons.timer_outlined,
                    '$timingCount Timing',
                  ),
                  const SizedBox(width: 8),
                  _buildStatChip(
                    context,
                    Icons.music_note_outlined,
                    '$notesCount Note',
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Pulsanti azione della beatmap
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.play_arrow_rounded, size: 18),
                      label: const Text(
                        'AVVIA PARTITA',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Orbitron',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryMagenta.withValues(
                          alpha: 0.15,
                        ),
                        foregroundColor: AppTheme.secondaryMagenta,
                        side: const BorderSide(
                          color: AppTheme.secondaryMagenta,
                          width: 1.2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        // Chiude prima il dialogo
                        Navigator.of(context).pop();
                        // Apre la schermata del gameplay
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (dialogContext) =>
                                GameplayScreen(beatmapId: beatmap.id),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit_rounded, size: 16),
                      label: const Text(
                        'APRI EDITOR BEATMAP',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Orbitron',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryCyan.withValues(
                          alpha: 0.15,
                        ),
                        foregroundColor: AppTheme.primaryCyan,
                        side: const BorderSide(
                          color: AppTheme.primaryCyan,
                          width: 1.2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        // Chiude prima il dialogo
                        Navigator.of(context).pop();
                        // Apre la schermata dell'editor
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (dialogContext) => BeatmapEditorScreen(
                              beatmap: beatmap,
                              track: track,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(
                            Icons.add_circle_outline_rounded,
                            size: 14,
                          ),
                          label: const Text(
                            'Carica Test Data',
                            style: TextStyle(fontSize: 10),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.textSecondary,
                            side: const BorderSide(
                              color: AppTheme.borderSubtle,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: () => _loadTestData(context),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(
                            Icons.play_circle_outline_rounded,
                            size: 14,
                          ),
                          label: const Text(
                            'Simula Gameplay',
                            style: TextStyle(fontSize: 10),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.secondaryMagenta,
                            side: const BorderSide(
                              color: AppTheme.secondaryMagenta,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: () => _startSimulation(context, details),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, IconData icon, String text) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated,
        borderRadius: BorderRadius.circular(AppTokens.radiusSm),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppTheme.textSecondary),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceElevated,
          title: const Text('Rimuovere Beatmap?'),
          content: Text(
            'Sei sicuro di voler eliminare la beatmap "${beatmap.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(
                'Annulla',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
                side: const BorderSide(color: Colors.redAccent),
              ),
              onPressed: () async {
                await repository.deleteBeatmap(beatmap.id);
                if (context.mounted) {
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text(
                'Elimina',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadTestData(BuildContext context) async {
    // Genera 1 timing point iniziale
    final timing = [
      TimingPointsCompanion.insert(
        beatmapId: beatmap.id,
        timeMs: 0,
        bpm: beatmap.baseBpm,
        meter: const drift.Value(4),
      ),
    ];

    // Genera 15 note ritmiche di test distribuite su 4 corsie (lane 0-3) ogni 750ms
    final notes = List.generate(15, (i) {
      final int timeMs = 1000 + (i * 750);
      final int lane = i % 4;
      final String type = i % 5 == 4 ? 'hold' : (i % 6 == 5 ? 'flick' : 'tap');
      final int? duration = type == 'hold' ? 500 : null;
      final String? direction = type == 'flick'
          ? (lane % 2 == 0 ? 'up' : 'down')
          : null;

      return BeatmapNotesCompanion.insert(
        beatmapId: beatmap.id,
        timeMs: timeMs,
        lane: lane,
        type: type,
        durationMs: drift.Value(duration),
        direction: drift.Value(direction),
        positionX: drift.Value(lane * 0.25),
        positionY: const drift.Value(0.9),
      );
    });

    await repository.saveBeatmapDetails(
      beatmapId: beatmap.id,
      timingPoints: timing,
      notes: notes,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppTheme.surfaceElevated,
          content: Text(
            'Dati di test (1 Timing Point, 15 Note) caricati con successo!',
            style: TextStyle(color: AppTheme.primaryCyan),
          ),
        ),
      );
    }
  }

  void _startSimulation(BuildContext context, BeatmapWithDetails? details) {
    if (details == null || details.notes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppTheme.surfaceElevated,
          content: Text(
            'Carica prima i test data per simulare il gameplay!',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      );
      return;
    }

    // Assicura che la traccia sia caricata ed in esecuzione
    if (playerService.currentTrack?.id != track.id) {
      playerService.play(track, audioRepository);
    } else if (!playerService.isPlaying) {
      playerService.resume();
    }

    // Mostra il pannello di simulazione del log gameplay in tempo reale
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return _GameplaySimulationDialog(
          track: track,
          details: details,
          playerService: playerService,
        );
      },
    );
  }
}

/// Un sotto-dialogo interattivo che mostra le note che passano sulla timeline in tempo reale.
class _GameplaySimulationDialog extends StatefulWidget {
  final AudioTrack track;
  final BeatmapWithDetails details;
  final AudioPlayerService playerService;

  const _GameplaySimulationDialog({
    required this.track,
    required this.details,
    required this.playerService,
  });

  @override
  State<_GameplaySimulationDialog> createState() =>
      _GameplaySimulationDialogState();
}

class _GameplaySimulationDialogState extends State<_GameplaySimulationDialog> {
  final List<String> _log = [];
  final Set<int> _triggeredNotes = {};
  StreamSubscription? _subscription;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _log.add('[SIMULATION STARTED] In attesa della riproduzione...');

    // Ascolta la posizione del brano
    _subscription = widget.playerService.positionStream.listen((position) {
      if (!mounted) return;

      final currentMs = position.inMilliseconds;
      bool addedAny = false;

      // Cerca note attivate nel raggio temporale corrente
      for (final note in widget.details.notes) {
        if (note.timeMs <= currentMs && !_triggeredNotes.contains(note.id)) {
          _triggeredNotes.add(note.id);

          final noteInfo =
              'Nota ID:${note.id} [${note.type.toUpperCase()}] al tempo ${note.timeMs}ms - Corsia: ${note.lane}';
          final detailsStr = note.type == 'hold'
              ? ' (Hold Durata: ${note.durationMs}ms)'
              : (note.type == 'flick'
                    ? ' (Flick Direzione: ${note.direction})'
                    : '');

          setState(() {
            _log.add(
              '[TAP - ${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}.${(currentMs % 1000).toString().padLeft(3, '0')}] $noteInfo$detailsStr',
            );
          });
          addedAny = true;
        }
      }

      if (addedAny) {
        // Scroll automatico in fondo alla lista dei log
        Future.delayed(const Duration(milliseconds: 50), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        side: const BorderSide(color: AppTheme.secondaryMagenta, width: 1.5),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'SIMULATORE NOTE BEATMAP',
            style: TextStyle(
              color: AppTheme.secondaryMagenta,
              fontFamily: 'Orbitron',
              fontSize: 16,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.stop_circle_outlined,
              color: Colors.redAccent,
            ),
            onPressed: () {
              widget.playerService.stop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SizedBox(
        width: 500,
        height: 350,
        child: Column(
          children: [
            // Stato riproduzione corrente
            StreamBuilder<Duration>(
              stream: widget.playerService.positionStream,
              builder: (context, snapshot) {
                final pos = snapshot.data ?? Duration.zero;
                final ms = pos.inMilliseconds;
                return Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                    border: Border.all(color: AppTheme.borderSubtle),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Posizione Audio:',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      Text(
                        '${pos.inMinutes}:${(pos.inSeconds % 60).toString().padLeft(2, '0')}.${(ms % 1000).toString().padLeft(3, '0')} (${ms}ms)',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryCyan,
                          fontFamily: 'Consolas',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppTokens.spacingMd),

            // Console dei log di gameplay
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                  border: Border.all(color: AppTheme.borderSubtle),
                ),
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _log.length,
                  itemBuilder: (context, index) {
                    final item = _log[index];
                    Color textColor = AppTheme.textPrimary;
                    if (item.contains('[SIMULATION')) {
                      textColor = AppTheme.textSecondary;
                    } else if (item.contains('TAP')) {
                      textColor = AppTheme.primaryCyan;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        item,
                        style: TextStyle(
                          fontFamily: 'Consolas',
                          fontSize: 11,
                          color: textColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.secondaryMagenta.withValues(alpha: 0.2),
            side: const BorderSide(color: AppTheme.secondaryMagenta),
          ),
          onPressed: () {
            widget.playerService.pause();
            Navigator.of(context).pop();
          },
          child: const Text(
            'Chiudi',
            style: TextStyle(color: AppTheme.secondaryMagenta),
          ),
        ),
      ],
    );
  }
}
