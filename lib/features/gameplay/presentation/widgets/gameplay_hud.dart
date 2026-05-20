import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_tokens.dart';
import '../../../../shared/widgets/glow_text.dart';
import '../../controllers/gameplay_controller.dart';
import '../../models/gameplay_state.dart';

/// L'HUD grafico (Heads-Up Display) visualizzato in overlay durante la partita.
///
/// Mostra in modo reattivo il punteggio, la combo, il titolo della traccia, la barra di
/// avanzamento del brano e l'indicatore animato dei giudizi di precisione.
class GameplayHud extends StatelessWidget {
  final GameplayController controller;
  final VoidCallback onPausePressed;

  const GameplayHud({
    super.key,
    required this.controller,
    required this.onPausePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final score = controller.scoringState.score;
        final combo = controller.scoringState.combo;
        final trackName = controller.track?.displayName ?? 'Brano sconosciuto';
        final difficulty =
            controller.beatmap?.difficultyName.toUpperCase() ?? 'NORMAL';
        final progress = controller.progress;

        return Stack(
          children: [
            // 1. Barra superiore: Info brano, Score, Pausa
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 24, // Per non coprire la status bar su mobile
                  left: AppTokens.spacingLg,
                  right: AppTokens.spacingLg,
                  bottom: AppTokens.spacingSm,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tasto Pausa + Titolo Brano
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.pause_circle_outline,
                                size: 28,
                              ),
                              color: AppTheme.primaryCyan,
                              onPressed: onPausePressed,
                            ),
                            const SizedBox(width: AppTokens.spacingSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  trackName,
                                  style: const TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.secondaryMagenta.withValues(
                                      alpha: 0.2,
                                    ),
                                    border: Border.all(
                                      color: AppTheme.secondaryMagenta
                                          .withValues(alpha: 0.5),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    difficulty,
                                    style: const TextStyle(
                                      color: AppTheme.secondaryMagenta,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Punteggio corrente (Glow Neon Cyan)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'PUNTEGGIO',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 9,
                                letterSpacing: 1.5,
                              ),
                            ),
                            GlowText(
                              score.toString().padLeft(7, '0'),
                              glowColor: AppTheme.primaryCyan,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Barra della vita (Health Gauge / Life Bar)
                    _buildHealthBar(
                      controller.healthState.currentHealth,
                      controller.healthState.maxHealth,
                    ),
                  ],
                ),
              ),
            ),

            // 2. Centro: Combo e Giudizio corrente
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ), // Sposta leggermente in basso rispetto alla mezzeria
                  // Visualizzatore dei giudizi (Perfect, Great, ecc.) con animazione
                  JudgmentFeedback(controller: controller),

                  const SizedBox(height: AppTokens.spacingSm),

                  // Contatore Combo (appare solo se combo > 0)
                  if (combo > 0) ...[
                    GlowText(
                      '$combo',
                      glowColor: combo > 50
                          ? AppTheme.primaryCyan
                          : AppTheme.secondaryMagenta,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const Text(
                      'COMBO',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.0,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // 3. Barra di avanzamento brano (lungo il bordo inferiore dello schermo)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sottile barra orizzontale neon
                  Container(
                    height: 4,
                    width: double.infinity,
                    color: const Color(0xFF1E294B), // Sfondo spento
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryCyan,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryCyan,
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHealthBar(double current, double max) {
    final double percentage = (current / max).clamp(0.0, 1.0);

    // Sceglie il colore neon in base alla percentuale di energia
    Color healthColor = const Color(0xFF00FF66); // Verde neon (salute alta)
    if (percentage <= 0.25) {
      healthColor = const Color(0xFFEF4444); // Rosso neon (salute critica)
    } else if (percentage <= 0.60) {
      healthColor = const Color(0xFFFFF200); // Giallo neon (salute media)
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'LIFE GAUGE',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              '${current.toInt()}%',
              style: TextStyle(
                color: healthColor,
                fontSize: 10,
                fontFamily: 'Orbitron',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 0.5,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: percentage,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: healthColor,
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: healthColor.withValues(alpha: 0.5),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget interno per animare il testo del giudizio temporaneo quando una nota viene colpita/persa.
class JudgmentFeedback extends StatefulWidget {
  final GameplayController controller;

  const JudgmentFeedback({super.key, required this.controller});

  @override
  State<JudgmentFeedback> createState() => _JudgmentFeedbackState();
}

class _JudgmentFeedbackState extends State<JudgmentFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  String _currentLabel = '';
  Color _currentColor = Colors.white;

  StreamSubscription? _hitSubscription;
  StreamSubscription? _missSubscription;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    // Animazione di scale-up ed elastica iniziale
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.5,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.2,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 60,
      ),
    ]).animate(_animController);

    // Dissolvenza sul finale
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.0), weight: 60),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 40,
      ),
    ]).animate(_animController);

    // Si iscrive agli stream per intercettare gli eventi in tempo reale
    _hitSubscription = widget.controller.onNoteHit.listen((event) {
      _showFeedback(event.judgment.label, event.judgment.color);
    });

    _missSubscription = widget.controller.onNoteMissed.listen((note) {
      _showFeedback(Judgment.miss.label, Judgment.miss.color);
    });
  }

  void _showFeedback(String label, Color color) {
    if (!mounted) return;
    setState(() {
      _currentLabel = label;
      _currentColor = color;
    });
    _animController.reset();
    _animController.forward();
  }

  @override
  void dispose() {
    _hitSubscription?.cancel();
    _missSubscription?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentLabel.isEmpty) {
      return const SizedBox(height: 35); // Riserva lo spazio verticale
    }

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, _) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: GlowText(
              _currentLabel,
              glowColor: _currentColor,
              style: TextStyle(
                color: _currentColor,
                fontSize: 26,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
