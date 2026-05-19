import 'package:flutter/material.dart';

class GlowText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color glowColor;
  final double glowRadius;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const GlowText(
    this.text, {
    super.key,
    this.style,
    required this.glowColor,
    this.glowRadius = 8.0,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle = style ?? Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: defaultStyle.copyWith(
        shadows: [
          Shadow(
            color: glowColor.withOpacity(0.8),
            blurRadius: glowRadius,
          ),
          Shadow(
            color: glowColor.withOpacity(0.5),
            blurRadius: glowRadius * 2.0,
          ),
        ],
      ),
    );
  }
}
