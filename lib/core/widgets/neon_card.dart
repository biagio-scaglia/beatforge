import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NeonCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color glowColor;
  final Color? borderColor;
  final double glowRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
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

class _NeonCardState extends State<NeonCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool highlighted = _isHovered || widget.isActive;
    
    // Smooth transitions for neon glow
    final Color borderCol = widget.borderColor ?? 
        (highlighted ? widget.glowColor : AppTheme.borderSubtle);
    
    final double activeGlowRadius = highlighted ? widget.glowRadius : 0.0;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: borderCol,
            width: highlighted ? 1.5 : 1.0,
          ),
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
            ]
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
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
