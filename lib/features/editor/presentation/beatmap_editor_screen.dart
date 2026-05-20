import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_tokens.dart';
import '../../../../data/local/database/app_database.dart';
import '../../../../data/repositories/beatmap_repository.dart';
import '../../../../data/repositories/audio_repository.dart';
import '../../../../shared/services/audio_player_service_provider.dart';
import '../../../../shared/widgets/beatforge_loader.dart';
import 'beatmap_editor_controller.dart';
import 'widgets/editor_timeline.dart';
import 'widgets/editor_controls.dart';
import 'widgets/editor_toolbar.dart';
import 'widgets/note_details_panel.dart';

/// La schermata principale del Beatmap Editor.
///
/// Inizializza il [BeatmapEditorController] e dispone i sotto-componenti (Toolbar, Timeline,
/// Controls, DetailsPanel) in modo responsive a seconda della larghezza del dispositivo.
class BeatmapEditorScreen extends StatefulWidget {
  final Beatmap beatmap;
  final AudioTrack track;

  const BeatmapEditorScreen({
    super.key,
    required this.beatmap,
    required this.track,
  });

  @override
  State<BeatmapEditorScreen> createState() => _BeatmapEditorScreenState();
}

class _BeatmapEditorScreenState extends State<BeatmapEditorScreen> {
  late BeatmapEditorController _controller;

  @override
  void initState() {
    super.initState();

    // Inizializzazione tardiva del controller recuperando le dipendenze dal context senza registrare listener in initState
    final beatmapRepository = BeatmapRepositoryProvider.of(
      context,
      listen: false,
    );
    final audioRepository = AudioRepositoryProvider.of(context, listen: false);
    final playerService = AudioPlayerServiceProvider.of(context, listen: false);

    _controller = BeatmapEditorController(
      beatmap: widget.beatmap,
      track: widget.track,
      beatmapRepository: beatmapRepository,
      audioRepository: audioRepository,
      playerService: playerService,
    );

    // Carica i dati delle note e prepara la traccia audio in modalità pausa
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.loadDetails();

      try {
        if (playerService.currentTrack?.id != widget.track.id) {
          await playerService.play(widget.track, audioRepository);
          await playerService
              .pause(); // Mette subito in pausa dopo il caricamento sorgente
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppTheme.surfaceElevated,
              content: Text(
                'Errore nel caricamento audio: $e',
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BeatmapEditorController>.value(
      value: _controller,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: const EditorToolbar(),
        body: Consumer<BeatmapEditorController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const Center(child: BeatForgeLoader());
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                // Breakpoint per commutazione layout desktop/mobile
                final bool isDesktop = constraints.maxWidth >= 720;

                if (isDesktop) {
                  return Row(
                    children: [
                      // Area sinistra/centrale: Timeline ed i suoi controlli
                      Expanded(
                        child: Column(
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(AppTokens.spacingMd),
                                child: EditorTimeline(),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppTokens.spacingMd,
                                vertical: AppTokens.spacingSm,
                              ),
                              child: EditorControls(),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: AppTheme.borderSubtle,
                        width: 1,
                      ),
                      // Area destra: Pannello dettagli ed ispezione nota
                      const SizedBox(
                        width: 300,
                        child: Padding(
                          padding: EdgeInsets.all(AppTokens.spacingMd),
                          child: NoteDetailsPanel(),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Layout Mobile: Timeline sopra, controlli al centro, dettagli sotto scrollabili
                  return Column(
                    children: [
                      const SizedBox(
                        height: 220,
                        child: Padding(
                          padding: EdgeInsets.all(AppTokens.spacingSm),
                          child: EditorTimeline(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTokens.spacingSm,
                        ),
                        child: EditorControls(),
                      ),
                      const Divider(color: AppTheme.borderSubtle, height: 16),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTokens.spacingSm,
                          ),
                          child: NoteDetailsPanel(),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
