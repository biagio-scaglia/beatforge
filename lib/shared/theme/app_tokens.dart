import 'package:flutter/widgets.dart';

/// Centralizza i token del design system per layout, spaziatura e animazioni.
///
/// Evita la frammentazione di "numeri magici" all'interno del progetto e
/// fornisce valori costanti ottimizzati per l'esperienza utente.
class AppTokens {
  AppTokens._();

  // Breakpoints responsive (in pixel/dp logici)
  static const double breakpointMobileCompact = 480.0;
  static const double breakpointMobileWide = 768.0;
  static const double breakpointTablet = 1024.0;

  // Scala delle spaziazioni costanti
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // Raggi per i bordi arrotondati (Border Radii)
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;

  // Tempistiche per le micro-interazioni e transizioni (Motion)
  static const Duration durationFast = Duration(milliseconds: 100);
  static const Duration durationNormal = Duration(milliseconds: 180);
  static const Duration durationSlow = Duration(milliseconds: 300);

  // Curve di accelerazione per le animazioni
  static const Curve curveInteractive = Curves.easeOutCubic;
  static const Curve curveDecelerate = Curves.decelerate;
}
