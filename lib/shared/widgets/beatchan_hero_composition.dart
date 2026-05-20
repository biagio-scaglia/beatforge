import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'beatchan_artwork.dart';

/// Widget per comporre la mascotte Beat-chan in modo integrato e fluido nella Hero section.
///
/// Inserisce l'artwork a figura libera (senza box rettangolari) sovrapposto ad un'aura
/// radiale color neon e a cerchi audio concentrici decorativi ad altissima trasparenza.
class BeatChanHeroComposition extends StatelessWidget {
  /// Dimensione massima del widget (larghezza ed altezza)
  final double size;

  /// Posa da visualizzare
  final BeatChanPose pose;

  /// Abilita l'oscillazione floating
  final bool isFloating;

  const BeatChanHeroComposition({
    super.key,
    this.size = 320.0,
    this.pose = BeatChanPose.music,
    this.isFloating = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Aura luminosa morbida (RadialGradient)
          Container(
            width: size * 0.9,
            height: size * 0.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppTheme.secondaryMagenta.withValues(alpha: 0.18),
                  AppTheme.primaryCyan.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          ),

          // 2. Cerchi concentrici decorativi (audio rings / rhythm game target)
          // Cerchio esterno
          Container(
            width: size * 0.85,
            height: size * 0.85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.primaryCyan.withValues(alpha: 0.08),
                width: 1.0,
              ),
            ),
          ),

          // Cerchio intermedio
          Container(
            width: size * 0.65,
            height: size * 0.65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.secondaryMagenta.withValues(alpha: 0.06),
                width: 1.0,
              ),
            ),
          ),

          // Cerchio interno sfumato
          Container(
            width: size * 0.45,
            height: size * 0.45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.primaryCyan.withValues(alpha: 0.04),
                width: 0.8,
              ),
            ),
          ),

          // Elemento decorativo a croce (mirino cyberpunk super-sottile)
          Positioned(
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: size * 0.95,
                height: 0.5,
                color: AppTheme.primaryCyan.withValues(alpha: 0.03),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 0.5,
                height: size * 0.95,
                color: AppTheme.primaryCyan.withValues(alpha: 0.03),
              ),
            ),
          ),

          // 3. Mascotte in primo piano che fluttua liberamente
          BeatChanArtwork(
            pose: pose,
            height: size * 0.82,
            width: size * 0.82,
            isFloating: isFloating,
            hasFrame: false, // Disabilita la cornice rettangolare rigida
            glowColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
