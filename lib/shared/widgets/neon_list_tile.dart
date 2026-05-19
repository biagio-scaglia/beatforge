import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_tokens.dart';
import 'tactile_feedback.dart';

/// Un elemento di lista interattivo per la libreria musicale o le impostazioni.
///
/// Dispone di un indicatore neon verticale a sinistra e supporta micro-animazioni.
class NeonListTile extends StatefulWidget {
  /// Il titolo principale dell'elemento di lista.
  final String title;

  /// La descrizione o il testo secondario.
  final String subtitle;

  /// Widget opzionale a sinistra (ad es. un'icona o un'immagine di copertina).
  final Widget? leading;

  /// Widget opzionale a destra (ad es. un pulsante di modifica o cancellazione).
  final Widget? trailing;

  /// Callback attivata al clic del tile.
  final VoidCallback? onTap;

  /// Il colore neon dell'indicatore a sinistra e della bordatura.
  final Color glowColor;

  const NeonListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.glowColor = AppTheme.primaryCyan,
  });

  @override
  State<NeonListTile> createState() => _NeonListTileState();
}

class _NeonListTileState extends State<NeonListTile> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.onTap != null;
    final bool highlighted = _isHovered || _isFocused;
    final double activeGlowRadius = highlighted ? 8.0 : 0.0;

    Widget tileWidget = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: AppTokens.durationFast,
        curve: AppTokens.curveInteractive,
        decoration: BoxDecoration(
          color: highlighted ? AppTheme.surfaceElevated : AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          border: Border.all(
            color: highlighted ? widget.glowColor : AppTheme.borderSubtle,
            width: highlighted ? 1.2 : 1.0,
          ),
          boxShadow: [
            if (highlighted && activeGlowRadius > 0)
              BoxShadow(
                color: widget.glowColor.withValues(alpha: 0.2),
                blurRadius: activeGlowRadius,
                spreadRadius: 0.5,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTokens.radiusMd),
          child: Stack(
            children: [
              // Barra colorata verticale sul bordo sinistro stile Game UI
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 4,
                child: AnimatedContainer(
                  duration: AppTokens.durationFast,
                  color: highlighted
                      ? widget.glowColor
                      : widget.glowColor.withValues(alpha: 0.3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    if (widget.leading != null) ...[
                      widget.leading!,
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: highlighted
                                      ? widget.glowColor
                                      : AppTheme.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.subtitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    if (widget.trailing != null) ...[
                      const SizedBox(width: 16),
                      widget.trailing!,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (isEnabled) {
      tileWidget = Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: TactileFeedback(onTap: widget.onTap, child: tileWidget),
      );
    }

    return tileWidget;
  }
}
