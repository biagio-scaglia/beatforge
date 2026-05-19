import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_tokens.dart';
import 'tactile_feedback.dart';

/// Un pulsante in stile gioco arcade con bordature neon ed effetti di transizione.
///
/// Integra hover, focus da tastiera e animazioni tattili a molla tramite [TactileFeedback].
class NeonButton extends StatefulWidget {
  /// Il testo visualizzato all'interno del pulsante (automaticamente convertito in maiuscolo).
  final String text;

  /// Callback eseguita al clic del pulsante. Se nulla, il pulsante viene visualizzato disabilitato.
  final VoidCallback? onTap;

  /// Il colore del bordo neon e del testo.
  final Color glowColor;

  /// Icona opzionale da visualizzare a sinistra del testo.
  final IconData? icon;

  /// Se vero, il pulsante assume uno sfondo trasparente e un bordo standard non colorato all'inizio.
  final bool isSecondary;

  const NeonButton({
    super.key,
    required this.text,
    this.onTap,
    this.glowColor = AppTheme.primaryCyan,
    this.icon,
    this.isSecondary = false,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onTap != null;
    final bool highlighted = _isHovered || _isFocused;

    // Colori calcolati dinamicamente
    final Color primaryColor = isEnabled ? widget.glowColor : AppTheme.textMuted;
    final Color borderCol = highlighted
        ? primaryColor
        : (widget.isSecondary
            ? AppTheme.borderSubtle
            : primaryColor.withValues(alpha: 0.4));
    final double activeGlowRadius = highlighted ? 8.0 : 0.0;

    Widget buttonWidget = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
      child: AnimatedContainer(
        duration: AppTokens.durationFast,
        curve: AppTokens.curveInteractive,
        decoration: BoxDecoration(
          color: widget.isSecondary
              ? Colors.transparent
              : primaryColor.withValues(alpha: highlighted ? 0.12 : 0.06),
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          border: Border.all(
            color: borderCol,
            width: highlighted ? 1.5 : 1.0,
          ),
          boxShadow: [
            if (highlighted && activeGlowRadius > 0)
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.3),
                blurRadius: activeGlowRadius,
                spreadRadius: 0.5,
              ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: primaryColor, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              widget.text.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: primaryColor,
                    fontSize: 13,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );

    // Se abilitato, lo avvolgiamo nel rilevamento del focus e nel feedback tattile
    if (isEnabled) {
      buttonWidget = Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: TactileFeedback(
          onTap: widget.onTap,
          child: buttonWidget,
        ),
      );
    }

    return buttonWidget;
  }
}
