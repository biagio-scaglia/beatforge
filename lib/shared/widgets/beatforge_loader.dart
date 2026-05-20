import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Un indicatore di caricamento personalizzato a tema rhythm-game.
///
/// Visualizza un set di barre equalizzatrici verticali neon (cyan/magenta) che
/// oscillano in modo sfasato per simulare una traccia audio in esecuzione.
class BeatForgeLoader extends StatefulWidget {
  /// Altezza massima dell'animazione
  final double height;

  /// Larghezza complessiva del widget
  final double width;

  /// Spessore delle singole barre equalizzatrici
  final double barWidth;

  const BeatForgeLoader({
    super.key,
    this.height = 40.0,
    this.width = 60.0,
    this.barWidth = 4.0,
  });

  @override
  State<BeatForgeLoader> createState() => _BeatForgeLoaderState();
}

class _BeatForgeLoaderState extends State<BeatForgeLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int barCount = 5;
    // Assegniamo colori alternati cyan/magenta/purple per un effetto cyber pop
    final List<Color> barColors = [
      AppTheme.primaryCyan,
      AppTheme.primaryCyan.blend(AppTheme.secondaryMagenta, 0.4),
      AppTheme.secondaryMagenta,
      AppTheme.secondaryMagenta.blend(AppTheme.primaryCyan, 0.4),
      AppTheme.primaryCyan,
    ];

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(barCount, (index) {
              // Calcolo dell'altezza tramite onda sinusoidale sfasata per ciascuna barra
              final double phase = (index / barCount) * math.pi * 1.5;
              final double t = _controller.value * 2 * math.pi;
              final double scale = 0.2 + 0.8 * (math.sin(t + phase).abs());
              final double currentHeight = widget.height * scale;

              return Container(
                width: widget.barWidth,
                height: currentHeight,
                decoration: BoxDecoration(
                  color: barColors[index],
                  borderRadius: BorderRadius.circular(widget.barWidth / 2),
                  boxShadow: [
                    BoxShadow(
                      color: barColors[index].withValues(alpha: 0.5),
                      blurRadius: 6,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

extension on Color {
  /// Semplice utilità per mescolare due colori nel tema scuro
  Color blend(Color other, double t) {
    return Color.lerp(this, other, t) ?? this;
  }
}
