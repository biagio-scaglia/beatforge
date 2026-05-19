import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_tokens.dart';
import 'tactile_feedback.dart';

/// Una scheda in stile arcade con bordature animate ed effetti di luce neon.
///
/// Risponde agli eventi di hover del mouse (su desktop e web), focus da tastiera
/// (accessibilità) e tap (micro-animazioni e vibrazione aptica tramite [TactileFeedback]).
class NeonCard extends StatefulWidget {
  /// Il contenuto interno della scheda.
  final Widget child;

  /// Callback attivata al tocco. Se nullo, l'effetto clic e le animazioni tattili sono disattivate.
  final VoidCallback? onTap;

  /// Il colore principale del bagliore neon.
  final Color glowColor;

  /// Colore specifico del bordo. Se nullo, sfuma tra il colore di default e il glowColor.
  final Color? borderColor;

  /// Il raggio massimo di sfocatura dell'ombra del bagliore.
  final double glowRadius;

  /// Margini esterni opzionali.
  final EdgeInsetsGeometry? margin;

  /// Spaziatura interna della scheda (default: 20.0).
  final EdgeInsetsGeometry padding;

  /// Stato di attivazione forzato. Se vero, mantiene attivo l'effetto neon anche senza hover/focus.
  final bool isActive;

  const NeonCard({
    super.key,
    required this.child,
    this.onTap,
    this.glowColor = AppTheme.primaryCyan,
    this.borderColor,
    this.glowRadius = 12.0,
    this.margin,
    this.padding = const EdgeInsets.all(20.0),
    this.isActive = false,
  });

  @override
  State<NeonCard> createState() => _NeonCardState();
}

class _NeonCardState extends State<NeonCard> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final bool highlighted = _isHovered || _isFocused || widget.isActive;

    // Configura i colori del bordo in base allo stato di attivazione/hover/focus
    final Color borderCol = widget.borderColor ??
        (highlighted ? widget.glowColor : AppTheme.borderSubtle);

    final double activeGlowRadius = highlighted ? widget.glowRadius : 0.0;

    Widget cardWidget = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: AppTokens.durationNormal,
        curve: AppTokens.curveInteractive,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          border: Border.all(
            color: borderCol,
            width: highlighted ? 1.5 : 1.0,
          ),
          boxShadow: [
            if (highlighted && activeGlowRadius > 0) ...[
              BoxShadow(
                color: widget.glowColor.withValues(alpha: 0.25),
                blurRadius: activeGlowRadius,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: widget.glowColor.withValues(alpha: 0.10),
                blurRadius: activeGlowRadius * 2.0,
                spreadRadius: 0.0,
              ),
            ]
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppTokens.radiusLg),
          child: InkWell(
            onTap: widget.onTap,
            onFocusChange: (focused) => setState(() => _isFocused = focused),
            borderRadius: BorderRadius.circular(AppTokens.radiusLg),
            splashColor: widget.glowColor.withValues(alpha: 0.08),
            highlightColor: widget.glowColor.withValues(alpha: 0.04),
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );

    // Se la card è interattiva (onTap != null), la avvolgiamo nel feedback tattile
    if (widget.onTap != null) {
      cardWidget = TactileFeedback(
        onTap: widget.onTap,
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
