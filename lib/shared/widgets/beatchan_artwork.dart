import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_tokens.dart';
import '../theme/app_assets.dart';

/// Tipi di pose disponibili per la mascotte Beat-chan.
enum BeatChanPose {
  /// Posa standard (alta definizione)
  standard,

  /// Posa musicale (ottimizzata)
  music,
}

/// Widget riutilizzabile per visualizzare la mascotte Beat-chan.
///
/// Include un'animazione opzionale di oscillazione verticale ("floating"),
/// una cornice cyber-neon personalizzabile ed una gestione responsive del fit.
class BeatChanArtwork extends StatefulWidget {
  /// Posa da utilizzare
  final BeatChanPose pose;

  /// Altezza massima dell'immagine
  final double? height;

  /// Larghezza massima dell'immagine
  final double? width;

  /// Abilita l'animazione di oscillazione verticale (floating)
  final bool isFloating;

  /// Abilita lo sfondo a scheda neon (vetro sfumato + ombra)
  final bool hasFrame;

  /// Colore del bagliore neon per la cornice/sfondo
  final Color glowColor;

  const BeatChanArtwork({
    super.key,
    this.pose = BeatChanPose.music,
    this.height,
    this.width,
    this.isFloating = true,
    this.hasFrame = false,
    this.glowColor = AppTheme.primaryCyan,
  });

  @override
  State<BeatChanArtwork> createState() => _BeatChanArtworkState();
}

class _BeatChanArtworkState extends State<BeatChanArtwork>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad),
    );

    if (widget.isFloating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant BeatChanArtwork oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFloating != oldWidget.isFloating) {
      if (widget.isFloating) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String assetPath = widget.pose == BeatChanPose.music
        ? AppAssets.beatchanMusic
        : AppAssets.beatchanDefault;

    Widget imageWidget = Image.asset(
      assetPath,
      height: widget.height,
      width: widget.width,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: widget.height ?? 120,
          width: widget.width ?? 120,
          decoration: BoxDecoration(
            color: AppTheme.surfaceElevated,
            borderRadius: BorderRadius.circular(AppTokens.radiusMd),
            border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
          ),
          child: const Center(
            child: Icon(
              Icons.broken_image_rounded,
              color: Colors.redAccent,
              size: 32,
            ),
          ),
        );
      },
    );

    // Se ha una cornice (es. per empty states o card dedicate)
    if (widget.hasFrame) {
      imageWidget = Container(
        padding: const EdgeInsets.all(AppTokens.spacingMd),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.surface,
              widget.glowColor.withValues(alpha: 0.08),
              AppTheme.surfaceElevated,
            ],
          ),
          borderRadius: BorderRadius.circular(AppTokens.radiusXl),
          border: Border.all(
            color: widget.glowColor.withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.glowColor.withValues(alpha: 0.12),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: imageWidget,
      );
    }

    if (widget.isFloating) {
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: child,
          );
        },
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
