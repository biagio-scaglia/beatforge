import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../data/local/database/app_database.dart';
import '../../../data/repositories/audio_repository.dart';
import '../../../shared/services/audio_player_service_provider.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/theme/app_tokens.dart';
import '../../../shared/widgets/glow_text.dart';
import '../../../shared/widgets/neon_button.dart';
import '../../../shared/widgets/neon_list_tile.dart';
import '../../../shared/widgets/beatchan_artwork.dart';
import 'beatmap_dialog.dart';

/// La schermata per la gestione della libreria musicale dei beatmap locali.
///
/// Consente l'importazione di file audio MP3, la categorizzazione dei brani e
/// l'eliminazione persistente degli stessi utilizzando il database locale Drift.
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _activeFilter = 'TUTTI';
  bool _isImporting = false;

  /// Gestisce il picking e l'importazione di un file MP3.
  Future<void> _importTrack(AudioRepository repository) async {
    if (_isImporting) return;

    setState(() {
      _isImporting = true;
    });

    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3'],
        withData: kIsWeb, // Carica i byte in memoria per il Web
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final name = file.name.replaceAll(
          RegExp(r'\.mp3$', caseSensitive: false),
          '',
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.surfaceElevated,
            content: Text(
              'Importazione di "$name" in corso...',
              style: const TextStyle(color: AppTheme.primaryCyan),
            ),
          ),
        );

        await repository.importAudioTrack(
          displayName: name,
          fileName: file.name,
          extension: file.extension ?? 'mp3',
          sizeBytes: file.size,
          bytes: file.bytes,
          localPath: file.path,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.surfaceElevated,
            content: Text(
              'Traccia "$name" importata con successo!',
              style: const TextStyle(color: AppTheme.primaryCyan),
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.surfaceElevated,
          content: Text(
            'Errore durante l\'importazione: $e',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isImporting = false;
        });
      }
    }
  }

  /// Mostra il dialog per gestire le categorie di una traccia.
  void _showCategoryDialog(
    AudioRepository repository,
    TrackWithCategories trackWithCats,
    List<TrackCategory> allCategories,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppTheme.surfaceElevated,
              title: GlowText(
                'Gestisci Categorie',
                glowColor: AppTheme.primaryCyan,
                style: const TextStyle(fontSize: 20),
              ),
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: allCategories.map((category) {
                    final isAssigned = trackWithCats.categories.any(
                      (c) => c.id == category.id,
                    );
                    return CheckboxListTile(
                      title: Text(
                        category.name,
                        style: const TextStyle(color: AppTheme.textPrimary),
                      ),
                      value: isAssigned,
                      activeColor: AppTheme.primaryCyan,
                      checkColor: Colors.black,
                      onChanged: (bool? value) async {
                        if (value == true) {
                          await repository.assignCategoryToTrack(
                            trackWithCats.track.id,
                            category.id,
                          );
                        } else {
                          await repository.removeCategoryFromTrack(
                            trackWithCats.track.id,
                            category.id,
                          );
                        }

                        setDialogState(() {
                          if (value == true) {
                            trackWithCats.categories.add(category);
                          } else {
                            trackWithCats.categories.removeWhere(
                              (c) => c.id == category.id,
                            );
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text(
                    'Chiudi',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Mostra il dialogo di gestione delle beatmap per la traccia.
  void _showBeatmapDialog(BuildContext context, AudioTrack track) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return BeatmapDialog(track: track);
      },
    );
  }

  /// Conferma l'eliminazione di una traccia tramite un dialog.
  Future<void> _confirmDeleteDialog(
    AudioRepository repository,
    int trackId,
    String displayName,
  ) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceElevated,
          title: GlowText(
            'Conferma Eliminazione',
            glowColor: Colors.redAccent,
            style: const TextStyle(fontSize: 20),
          ),
          content: Text(
            'Sei sicuro di voler eliminare la traccia "$displayName"? Questa operazione non può essere annullata.',
            style: const TextStyle(color: AppTheme.textPrimary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
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
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text(
                'Elimina',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        await repository.deleteAudioTrack(trackId);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.surfaceElevated,
            content: Text(
              'Traccia "$displayName" eliminata con successo!',
              style: const TextStyle(color: AppTheme.primaryCyan),
            ),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.surfaceElevated,
            content: Text(
              'Errore durante l\'eliminazione: $e',
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final repository = AudioRepositoryProvider.of(context);
    final playerService = AudioPlayerServiceProvider.of(context);

    return StreamBuilder<List<TrackCategory>>(
      stream: repository.watchCategories(),
      builder: (context, categorySnapshot) {
        final categories = categorySnapshot.data ?? [];

        return StreamBuilder<List<TrackWithCategories>>(
          stream: repository.watchTracksWithCategories(),
          builder: (context, trackSnapshot) {
            if (trackSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppTokens.spacingLg),
                  child: CircularProgressIndicator(color: AppTheme.primaryCyan),
                ),
              );
            }

            final allTracks = trackSnapshot.data ?? [];

            // Filtra i brani in base alla categoria selezionata
            final filteredTracks = allTracks.where((t) {
              if (_activeFilter == 'TUTTI') return true;
              return t.categories.any((c) => c.name == _activeFilter);
            }).toList();

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppTokens.spacingLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header con il titolo e il bottone per l'importazione
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GlowText(
                                  'LIBRERIA',
                                  glowColor: AppTheme.primaryCyan,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: AppTheme.primaryCyan),
                                ),
                                const SizedBox(height: AppTokens.spacingSm),
                                Text(
                                  'Gestisci ed esporta le tue mappe beat musicali',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppTokens.spacingMd),
                          if (_isImporting)
                            const CircularProgressIndicator(
                              color: AppTheme.primaryCyan,
                            )
                          else
                            NeonButton(
                              text: 'Importa MP3',
                              glowColor: AppTheme.primaryCyan,
                              onTap: () => _importTrack(repository),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppTokens.spacingLg),

                      // Filtri Categorie Caricati Dinamicamente dal Database
                      if (categories.isNotEmpty) ...[
                        Wrap(
                          spacing: AppTokens.spacingSm,
                          runSpacing: AppTokens.spacingSm,
                          children: ['TUTTI', ...categories.map((c) => c.name)]
                              .map((filter) {
                                final bool isSelected = _activeFilter == filter;
                                return NeonButton(
                                  text: filter.toUpperCase(),
                                  isSecondary: !isSelected,
                                  glowColor: isSelected
                                      ? AppTheme.primaryCyan
                                      : AppTheme.textSecondary,
                                  onTap: () {
                                    setState(() {
                                      _activeFilter = filter;
                                    });
                                  },
                                );
                              })
                              .toList(),
                        ),
                        const SizedBox(height: AppTokens.spacingLg),
                      ],

                      // Sezione Principale: Lista dei brani o empty state
                      if (allTracks.isEmpty)
                        _EmptyLibraryState(
                          onImport: () => _importTrack(repository),
                          isImporting: _isImporting,
                        )
                      else if (filteredTracks.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Text(
                              'Nessun brano corrisponde al filtro selezionato.',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: AppTheme.textSecondary),
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredTracks.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: AppTokens.spacingMd),
                          itemBuilder: (context, index) {
                            final item = filteredTracks[index];
                            final song = item.track;

                            // Formatta la dimensione in MB
                            final sizeMb = (song.sizeBytes / (1024 * 1024))
                                .toStringAsFixed(2);

                            // Crea la stringa delle categorie associate
                            final categoriesStr = item.categories.isEmpty
                                ? 'Nessuna Categoria'
                                : item.categories.map((c) => c.name).join(', ');

                            return ValueListenableBuilder<AudioTrack?>(
                              valueListenable:
                                  playerService.currentTrackNotifier,
                              builder: (context, activeTrack, child) {
                                final bool isCurrent =
                                    activeTrack?.id == song.id;
                                final Color activeColor = isCurrent
                                    ? AppTheme.primaryCyan
                                    : (index % 2 == 0
                                          ? AppTheme.primaryCyan
                                          : AppTheme.secondaryMagenta);

                                return NeonListTile(
                                  title: song.displayName,
                                  subtitle: '$categoriesStr • $sizeMb MB',
                                  glowColor: activeColor,
                                  onTap: () {
                                    playerService.play(song, repository);
                                  },
                                  leading: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppTheme.surfaceElevated,
                                      borderRadius: BorderRadius.circular(
                                        AppTokens.radiusSm,
                                      ),
                                      border: Border.all(
                                        color: isCurrent
                                            ? AppTheme.primaryCyan
                                            : AppTheme.borderSubtle,
                                        width: isCurrent ? 1.5 : 1.0,
                                      ),
                                      boxShadow: [
                                        if (isCurrent)
                                          BoxShadow(
                                            color: AppTheme.primaryCyan
                                                .withValues(alpha: 0.3),
                                            blurRadius: 6,
                                          ),
                                      ],
                                    ),
                                    child: Icon(
                                      isCurrent
                                          ? Icons.volume_up_rounded
                                          : Icons.music_note_rounded,
                                      color: activeColor,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.layers_outlined,
                                          color: activeColor,
                                        ),
                                        tooltip: 'Gestisci Beatmap',
                                        onPressed: () =>
                                            _showBeatmapDialog(context, song),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.label_outline_rounded,
                                          color: AppTheme.textSecondary,
                                        ),
                                        tooltip: 'Gestisci categorie',
                                        onPressed: () => _showCategoryDialog(
                                          repository,
                                          item,
                                          categories,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline_rounded,
                                          color: Colors.redAccent,
                                        ),
                                        tooltip: 'Elimina traccia',
                                        onPressed: () => _confirmDeleteDialog(
                                          repository,
                                          song.id,
                                          song.displayName,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// Widget rappresentativo dello stato vuoto della libreria.
class _EmptyLibraryState extends StatelessWidget {
  final VoidCallback onImport;
  final bool isImporting;

  const _EmptyLibraryState({required this.onImport, required this.isImporting});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BeatChanArtwork(
              pose: BeatChanPose.music,
              height: 160,
              width: 160,
              isFloating: true,
              hasFrame: true,
              glowColor: AppTheme.primaryCyan,
            ),
            const SizedBox(height: AppTokens.spacingLg),
            Text(
              'Nessun brano nella libreria',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryCyan,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTokens.spacingSm),
            Text(
              'Importa i tuoi file MP3 locali per iniziare a creare beatmap!',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTokens.spacingLg),
            if (isImporting)
              const CircularProgressIndicator(color: AppTheme.primaryCyan)
            else
              NeonButton(
                text: 'Importa il primo MP3',
                glowColor: AppTheme.primaryCyan,
                onTap: onImport,
              ),
          ],
        ),
      ),
    );
  }
}
