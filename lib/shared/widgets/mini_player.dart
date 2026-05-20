import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../services/audio_player_service.dart';
import '../services/audio_player_service_provider.dart';
import '../theme/app_theme.dart';
import '../theme/app_tokens.dart';
import 'glow_text.dart';
import 'beatforge_loader.dart';

/// Mini-player persistente posizionato in fondo allo schermo.
/// Ascolta lo stato del player globale e mostra i controlli di riproduzione.
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  String _formatDuration(Duration? duration) {
    if (duration == null) return '--:--';
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final AudioPlayerService playerService = AudioPlayerServiceProvider.of(
      context,
    );

    return ValueListenableBuilder(
      valueListenable: playerService.currentTrackNotifier,
      builder: (context, currentTrack, child) {
        if (currentTrack == null) {
          return const SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceElevated,
            border: const Border(
              top: BorderSide(color: AppTheme.primaryCyan, width: 1.5),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryCyan.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.spacingMd,
            vertical: AppTokens.spacingSm,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Riga Superiore: Info Brano e Controlli Principali
              Row(
                children: [
                  // Icona Musicale con Bagliore
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.background.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.primaryCyan, width: 1),
                    ),
                    child: StreamBuilder<PlayerState>(
                      stream: playerService.playerStateStream,
                      builder: (context, snapshot) {
                        final isPlaying = snapshot.data?.playing ?? false;
                        return Icon(
                          isPlaying
                              ? Icons.music_note_rounded
                              : Icons.music_off_rounded,
                          color: AppTheme.primaryCyan,
                          size: 20,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppTokens.spacingMd),

                  // Info Brano (Titolo ed Estensione)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlowText(
                          currentTrack.displayName,
                          glowColor: AppTheme.primaryCyan,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          currentTrack.fileName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Controlli Audio
                  StreamBuilder<PlayerState>(
                    stream: playerService.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final playing = playerState?.playing ?? false;

                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: SizedBox(
                            width: 32,
                            height: 24,
                            child: BeatForgeLoader(
                              height: 16,
                              width: 32,
                              barWidth: 2,
                            ),
                          ),
                        );
                      }

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              playing
                                  ? Icons.pause_circle_filled_rounded
                                  : Icons.play_circle_filled_rounded,
                              color: AppTheme.primaryCyan,
                              size: 36,
                            ),
                            onPressed: () {
                              if (playing) {
                                playerService.pause();
                              } else {
                                playerService.resume();
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.stop_rounded,
                              color: AppTheme.secondaryMagenta,
                              size: 28,
                            ),
                            onPressed: () => playerService.stop(),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              // Slider del Progresso e Tempi
              StreamBuilder<Duration?>(
                stream: playerService.durationStream,
                builder: (context, durationSnapshot) {
                  final duration = durationSnapshot.data ?? Duration.zero;

                  return StreamBuilder<Duration>(
                    stream: playerService.positionStream,
                    builder: (context, positionSnapshot) {
                      var position = positionSnapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 2.0,
                              activeTrackColor: AppTheme.primaryCyan,
                              inactiveTrackColor: AppTheme.borderSubtle,
                              thumbColor: AppTheme.primaryCyan,
                              overlayColor: AppTheme.primaryCyan.withValues(
                                alpha: 0.12,
                              ),
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6.0,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 12.0,
                              ),
                            ),
                            child: Slider(
                              value: duration.inMilliseconds > 0
                                  ? position.inMilliseconds.toDouble()
                                  : 0.0,
                              max: duration.inMilliseconds > 0
                                  ? duration.inMilliseconds.toDouble()
                                  : 1.0,
                              onChanged: (value) {
                                playerService.seek(
                                  Duration(milliseconds: value.toInt()),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTokens.spacingSm,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(position),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                                Text(
                                  _formatDuration(duration),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
