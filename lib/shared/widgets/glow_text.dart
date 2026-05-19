import 'package:flutter/material.dart';

/// Un widget di testo che applica un effetto di bagliore (glow) neon.
///
/// Sovrappone due ombreggiature sfumate del colore specificato (`glowColor`)
/// per emulare la luminosità dei neon dei cabinati arcade.
class GlowText extends StatelessWidget {
  /// Il testo da visualizzare.
  final String text;

  /// Lo stile opzionale del testo.
  final TextStyle? style;

  /// Il colore dell'effetto di bagliore neon.
  final Color glowColor;

  /// Il raggio dell'effetto sfocatura del bagliore.
  final double glowRadius;

  /// Allineamento orizzontale del testo.
  final TextAlign? textAlign;

  /// Numero massimo di righe consentite.
  final int? maxLines;

  /// Comportamento in caso di overflow del testo.
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
    final TextStyle defaultStyle =
        style ?? Theme.of(context).textTheme.bodyMedium ?? const TextStyle();

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: defaultStyle.copyWith(
        shadows: [
          Shadow(
            color: glowColor.withValues(alpha: 0.8),
            blurRadius: glowRadius,
          ),
          Shadow(
            color: glowColor.withValues(alpha: 0.5),
            blurRadius: glowRadius * 2.0,
          ),
        ],
      ),
    );
  }
}
