import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_tokens.dart';
import '../../../../shared/widgets/beatforge_loader.dart';
import '../../../../shared/widgets/glow_text.dart';
import '../../../../shared/widgets/beatchan_hero_composition.dart';
import '../../../../shared/widgets/beatchan_artwork.dart';
import '../../../../shared/services/audio_player_service_provider.dart';
import '../../../../data/repositories/audio_repository.dart';
import '../../../../data/repositories/beatmap_repository.dart';
import '../controllers/gameplay_controller.dart';
import '../models/gameplay_state.dart';
import '../game/beatforge_game.dart';
import 'widgets/gameplay_hud.dart';

/// La schermata principale del gameplay del rhythm game.
///
/// Inizializza il [GameplayController] e l'engine Flame [BeatForgeGame].
/// Gestisce la disposizione a schermo intero del Canvas grafico e degli overlay Flutter
/// (Countdown, Pausa, Risultati Finali, Tasti touch veloci).
class GameplayScreen extends StatefulWidget {
  final int beatmapId;

  const GameplayScreen({super.key, required this.beatmapId});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  late GameplayController _controller;
  BeatForgeGame? _game;

  @override
  void initState() {
    super.initState();

    final audioRepo = AudioRepositoryProvider.of(context, listen: false);
    final beatmapRepo = BeatmapRepositoryProvider.of(context, listen: false);
    final playerService = AudioPlayerServiceProvider.of(context, listen: false);

    _controller = GameplayController(
      beatmapId: widget.beatmapId,
      beatmapRepository: beatmapRepo,
      audioRepository: audioRepo,
      playerService: playerService,
    );

    // Carica la beatmap dal DB Drift
    _controller
        .loadGameplay()
        .then((_) {
          if (mounted) {
            setState(() {
              _game = BeatForgeGame(controller: _controller);
            });
          }
        })
        .catchError((e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppTheme.surfaceElevated,
                content: Text(
                  'Impossibile caricare il gameplay: $e',
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            );
            Navigator.of(context).pop();
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          if (_controller.isLoading || _game == null) {
            return const Center(child: BeatForgeLoader());
          }

          final status = _controller.status;

          return Stack(
            children: [
              // 1. Il Canvas di Gioco Flame (sempre renderizzato per mostrare le corsie/Judgment line)
              Positioned.fill(child: GameWidget(game: _game!)),

              // 2. Zone di input touch trasparenti in overlay (attive solo durante il playing)
              if (status == GameplayStatus.playing)
                Positioned.fill(
                  child: Row(
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTapDown: (_) {
                            // Invia l'input al Flame game per l'effetto flash visivo sulla corsia
                            // e al controller per il calcolo del timing
                            _game!.pressLane(index);
                          },
                          child: const SizedBox.expand(),
                        ),
                      );
                    }),
                  ),
                ),

              // 3. HUD principale: Punteggio, Combo, Avanzamento, Giudizio
              if (status == GameplayStatus.playing ||
                  status == GameplayStatus.paused)
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: status == GameplayStatus.paused,
                    child: GameplayHud(
                      controller: _controller,
                      onPausePressed: () => _controller.pauseGame(),
                    ),
                  ),
                ),

              // 4. Overlay: Schermata iniziale READY
              if (status == GameplayStatus.ready) _buildReadyOverlay(),

              // 5. Overlay: Countdown (3, 2, 1) prima dell'inizio
              if (status == GameplayStatus.countdown) _buildCountdownOverlay(),

              // 6. Overlay: Schermata di PAUSA
              if (status == GameplayStatus.paused) _buildPauseOverlay(),

              // 7. Overlay: Schermata dei RISULTATI (Completato)
              if (status == GameplayStatus.completed) _buildResultsOverlay(),
            ],
          );
        },
      ),
    );
  }

  /// Overlay iniziale per far avviare manualmente la traccia e prepararsi.
  Widget _buildReadyOverlay() {
    final trackName = _controller.track?.displayName ?? '';
    final notesCount = _controller.notes.length;

    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const GlowText(
                'PREPARATI',
                glowColor: AppTheme.primaryCyan,
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Orbitron',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: AppTokens.spacingLg),
              Text(
                trackName,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTokens.spacingSm),
              Text(
                'Note totali: $notesCount | Difficoltà: ${_controller.beatmap?.difficultyName ?? ""}',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryCyan.withValues(alpha: 0.15),
                  foregroundColor: AppTheme.primaryCyan,
                  side: const BorderSide(
                    color: AppTheme.primaryCyan,
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                ),
                onPressed: () {
                  _game!.resetSpawner();
                  _controller.startCountdown();
                },
                child: const Text(
                  'AVVIA PARTITA',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Overlay per visualizzare a tutto schermo il numero di countdown.
  Widget _buildCountdownOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.transparent,
        child: Center(
          key: ValueKey<int>(_controller.countdownSeconds),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 300),
            builder: (context, val, child) {
              return Transform.scale(
                scale: 1.0 + (1.0 - val) * 2.0,
                child: Opacity(
                  opacity: val,
                  child: GlowText(
                    _controller.countdownSeconds.toString(),
                    glowColor: AppTheme.secondaryMagenta,
                    style: const TextStyle(
                      fontSize: 100,
                      fontFamily: 'Orbitron',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Schermata di pausa semi-trasparente e sfocata.
  Widget _buildPauseOverlay() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.black.withValues(alpha: 0.7),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const GlowText(
                    'PARTITA IN PAUSA',
                    glowColor: AppTheme.primaryCyan,
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Orbitron',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Bottone Riprendi
                  _buildPauseButton(
                    text: 'RIPRENDI',
                    icon: Icons.play_arrow_rounded,
                    color: AppTheme.primaryCyan,
                    onPressed: () => _controller.resumeGame(),
                  ),
                  const SizedBox(height: AppTokens.spacingMd),
                  // Bottone Riavvia
                  _buildPauseButton(
                    text: 'RIAVVIA',
                    icon: Icons.replay_rounded,
                    color: AppTheme.secondaryMagenta,
                    onPressed: () {
                      _game!.resetSpawner();
                      _controller.restartGame();
                    },
                  ),
                  const SizedBox(height: AppTokens.spacingMd),
                  // Bottone Esci
                  _buildPauseButton(
                    text: 'ESCI',
                    icon: Icons.exit_to_app_rounded,
                    color: Colors.redAccent,
                    onPressed: () async {
                      await _controller.quitGame();
                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPauseButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 18),
        label: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Orbitron',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.15),
          foregroundColor: color,
          side: BorderSide(color: color, width: 1.2),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
      ),
    );
  }

  /// Schermata finale di riassunto dei risultati con la mascotte Beat-chan.
  Widget _buildResultsOverlay() {
    final state = _controller.scoringState;
    final accuracy = state.accuracy;

    // Assegna un grado basato sull'accuratezza
    String grade = 'D';
    Color gradeColor = Colors.redAccent;
    if (accuracy >= 95.0) {
      grade = 'S';
      gradeColor = AppTheme.tertiaryYellow;
    } else if (accuracy >= 90.0) {
      grade = 'A';
      gradeColor = AppTheme.primaryCyan;
    } else if (accuracy >= 80.0) {
      grade = 'B';
      gradeColor = AppTheme.secondaryMagenta;
    } else if (accuracy >= 65.0) {
      grade = 'C';
      gradeColor = Colors.orangeAccent;
    }

    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          color: Colors.black.withValues(alpha: 0.85),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    const GlowText(
                      'STAGE COMPLETATO',
                      glowColor: AppTheme.primaryCyan,
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Orbitron',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Layout responsive: Mascotte + Dettagli Punteggio
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isLarge = constraints.maxWidth >= 600;

                        final mascotWidget = BeatChanHeroComposition(
                          size: isLarge ? 280 : 200,
                          pose: BeatChanPose.music,
                        );

                        final statsWidget = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Grado e Accuratezza
                            Row(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: gradeColor,
                                      width: 3,
                                    ),
                                    color: gradeColor.withValues(alpha: 0.15),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    grade,
                                    style: TextStyle(
                                      color: gradeColor,
                                      fontSize: 32,
                                      fontFamily: 'Orbitron',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppTokens.spacingMd),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'ACCURATEZZA',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 10,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    GlowText(
                                      '${accuracy.toStringAsFixed(2)}%',
                                      glowColor: gradeColor,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: AppTokens.spacingLg),

                            // Punteggio & Combo
                            _buildResultRow(
                              'Punteggio Totale',
                              '${state.score}',
                              AppTheme.primaryCyan,
                            ),
                            _buildResultRow(
                              'Max Combo',
                              '${state.maxCombo}',
                              AppTheme.secondaryMagenta,
                            ),
                            const Divider(color: Color(0xFF1E294B), height: 24),

                            // Dettaglio Giudizi
                            _buildResultRow(
                              'PERFECT',
                              '${state.perfectCount}',
                              const Color(0xFF00F2FE),
                            ),
                            _buildResultRow(
                              'GREAT',
                              '${state.greatCount}',
                              const Color(0xFFFF007F),
                            ),
                            _buildResultRow(
                              'GOOD',
                              '${state.goodCount}',
                              const Color(0xFFFFF200),
                            ),
                            _buildResultRow(
                              'MISS',
                              '${state.missCount}',
                              const Color(0xFFEF4444),
                            ),
                          ],
                        );

                        if (isLarge) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              mascotWidget,
                              const SizedBox(width: 40),
                              Expanded(child: statsWidget),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              mascotWidget,
                              const SizedBox(height: 20),
                              statsWidget,
                            ],
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 40),

                    // Azioni di fine partita
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.replay_rounded),
                          label: const Text(
                            'RIGIOCA',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondaryMagenta
                                .withValues(alpha: 0.15),
                            foregroundColor: AppTheme.secondaryMagenta,
                            side: const BorderSide(
                              color: AppTheme.secondaryMagenta,
                              width: 1.2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                          ),
                          onPressed: () {
                            _game!.resetSpawner();
                            _controller.restartGame();
                          },
                        ),
                        const SizedBox(width: AppTokens.spacingMd),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.library_music_rounded),
                          label: const Text(
                            'LIBRERIA',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.textSecondary,
                            side: const BorderSide(
                              color: AppTheme.borderSubtle,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                          ),
                          onPressed: () async {
                            await _controller.quitGame();
                            if (mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
          ),
          GlowText(
            value,
            glowColor: color,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
