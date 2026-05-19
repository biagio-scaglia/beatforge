import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Una scheda in stile arcade con bordature animate ed effetti di luce neon.
///
/// Risponde agli eventi di hover del mouse (su desktop e web) amplificando
/// l'intensità del bagliore e lo spessore del bordo.
class NeonCard extends StatefulWidget {
  /// Il contenuto interno della scheda.
  final Widget child;

  /// Callback attivata al tocco. Se nullo, l'effetto clic è disattivato.
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

  /// Stato di attivazione forzato. Se vero, mantiene attivo l'effetto neon anche senza hover.
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

class _NeonCardState extends State<NeonCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool highlighted = _isHovered || widget.isActive;

    // Configura i colori del bordo in base allo stato di attivazione/hover
    final Color borderCol =
        widget.borderColor ??
        (highlighted ? widget.glowColor : AppTheme.borderSubtle);

    final double activeGlowRadius = highlighted ? widget.glowRadius : 0.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: borderCol, width: highlighted ? 1.5 : 1.0),
          boxShadow: [
            if (highlighted && activeGlowRadius > 0) ...[
              BoxShadow(
                color: widget.glowColor.withOpacity(0.25),
                blurRadius: activeGlowRadius,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: widget.glowColor.withOpacity(0.1),
                blurRadius: activeGlowRadius * 2.0,
                spreadRadius: 0.0,
              ),
            ],
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16.0),
            splashColor: widget.glowColor.withOpacity(0.08),
            highlightColor: widget.glowColor.withOpacity(0.04),
            child: Padding(padding: widget.padding, child: widget.child),
          ),
        ),
      ),
    );
  }
}
