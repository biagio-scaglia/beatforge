import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_tokens.dart';
import '../../../../shared/widgets/neon_button.dart';
import '../beatmap_editor_controller.dart';

/// Barra di controllo audio integrata all'interno dell'editor.
///
/// Permette di controllare play/pause/stop, visualizzare il timer preciso in formato mm:ss.SSS,
/// regolare la velocità di riproduzione per mappare a tempo e inserire note al volo.
class EditorControls extends StatelessWidget {
  const EditorControls({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BeatmapEditorController>(context);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.spacingMd,
        vertical: 8.0,
      ),
      child: StreamBuilder<Duration>(
        stream: controller.playerService.positionStream,
        initialData: Duration.zero,
        builder: (context, snapshot) {
          final currentPos = snapshot.data ?? Duration.zero;

          return StreamBuilder<Duration?>(
            stream: controller.playerService.durationStream,
            builder: (context, durationSnapshot) {
              final totalDuration = durationSnapshot.data ?? Duration.zero;

              // Calcola il progresso dello slider
              double progress = 0.0;
              if (totalDuration.inMilliseconds > 0) {
                progress =
                    (currentPos.inMilliseconds / totalDuration.inMilliseconds)
                        .clamp(0.0, 1.0);
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Slider di riproduzione audio principale dell'editor
                  Row(
                    children: [
                      Text(
                        _formatDuration(currentPos),
                        style: const TextStyle(
                          color: AppTheme.primaryCyan,
                          fontFamily: 'Consolas',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: progress,
                          activeColor: AppTheme.primaryCyan,
                          inactiveColor: AppTheme.borderSubtle,
                          onChanged: (val) {
                            final int targetMs =
                                (val * totalDuration.inMilliseconds).round();
                            controller.playerService.seek(
                              Duration(milliseconds: targetMs),
                            );
                          },
                        ),
                      ),
                      Text(
                        _formatDuration(totalDuration),
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontFamily: 'Consolas',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Riga dei bottoni di controllo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Controlli Player
                      Row(
                        children: [
                          StreamBuilder<bool>(
                            stream:
                                controller.playerService.player.playingStream,
                            initialData: false,
                            builder: (context, playingSnapshot) {
                              final isPlaying = playingSnapshot.data ?? false;
                              return IconButton(
                                icon: Icon(
                                  isPlaying
                                      ? Icons.pause_circle_filled_rounded
                                      : Icons.play_circle_filled_rounded,
                                  size: 36,
                                  color: AppTheme.primaryCyan,
                                ),
                                onPressed: () {
                                  if (isPlaying) {
                                    controller.playerService.pause();
                                  } else {
                                    controller.playerService.resume();
                                  }
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.stop_circle_rounded,
                              size: 30,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => controller.playerService.stop(),
                          ),
                        ],
                      ),

                      // Bottone rapido inserisci nota al tempo corrente
                      NeonButton(
                        text: 'INSERISCI NOTA AL VOLO',
                        glowColor: AppTheme.secondaryMagenta,
                        onTap: () {
                          controller.addNote();
                        },
                      ),

                      // Regolazione velocità di riproduzione (Speed slider / dropdown)
                      Row(
                        children: [
                          const Icon(
                            Icons.speed_rounded,
                            size: 16,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          DropdownButton<double>(
                            value: controller.speed,
                            dropdownColor: AppTheme.surfaceElevated,
                            underline: const SizedBox(),
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 12,
                              fontFamily: 'Consolas',
                            ),
                            items: const [
                              DropdownMenuItem<double>(
                                value: 0.5,
                                child: Text('0.50x'),
                              ),
                              DropdownMenuItem<double>(
                                value: 0.75,
                                child: Text('0.75x'),
                              ),
                              DropdownMenuItem<double>(
                                value: 1.0,
                                child: Text('1.00x (Std)'),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                controller.setPlaybackSpeed(val);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  /// Formatta una durata in mm:ss.SSS
  String _formatDuration(Duration duration) {
    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds % 60;
    final int milliseconds = duration.inMilliseconds % 1000;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(3, '0')}';
  }
}
