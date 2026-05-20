import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Classe di configurazione del tema grafico dell'applicazione.
///
/// Fornisce una tavolozza di colori scura e neon stile arcade pop (ispirata a
/// Project DIVA) e definisce lo stile tipografico principale con i font Orbitron
/// per le intestazioni e Outfit per i testi di lettura.
class AppTheme {
  AppTheme._();

  // Colori principali del tema scuro arcade
  static const Color background = Color(0xFF060913);
  static const Color surface = Color(0xFF0E1326);
  static const Color surfaceElevated = Color(0xFF161E38);

  // Colori accento in stile neon
  static const Color primaryCyan = Color(0xFF00F2FE);
  static const Color secondaryMagenta = Color(0xFFFF007F);
  static const Color tertiaryYellow = Color(0xFFFFF200);

  // Gradienti a tema cyber-pop
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryCyan, secondaryMagenta],
  );

  static const Gradient surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surface, surfaceElevated],
  );

  // Colori del testo freddi e leggibili
  static const Color textPrimary = Color(0xFFE2E8F0);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Bordature
  static const Color borderSubtle = Color(0xFF1E294B);
  static const Color borderCyan = Color(0x3300F2FE);
  static const Color borderMagenta = Color(0x33FF007F);

  /// Genera il tema scuro personalizzato per l'applicazione.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primaryCyan,
      colorScheme: const ColorScheme.dark(
        primary: primaryCyan,
        secondary: secondaryMagenta,
        tertiary: tertiaryYellow,
        surface: surface,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),

      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.orbitron(
              color: textPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
            displayMedium: GoogleFonts.orbitron(
              color: textPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            displaySmall: GoogleFonts.orbitron(
              color: textPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            headlineLarge: GoogleFonts.orbitron(
              color: textPrimary,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: GoogleFonts.orbitron(
              color: textPrimary,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: GoogleFonts.orbitron(
              color: textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            bodyLarge: GoogleFonts.outfit(color: textPrimary, fontSize: 16),
            bodyMedium: GoogleFonts.outfit(color: textSecondary, fontSize: 14),
            labelLarge: GoogleFonts.orbitron(
              color: textPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),

      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: surface,
        selectedIconTheme: IconThemeData(color: primaryCyan, size: 28),
        unselectedIconTheme: IconThemeData(color: textMuted, size: 24),
        selectedLabelTextStyle: TextStyle(
          color: primaryCyan,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 1.0,
        ),
        unselectedLabelTextStyle: TextStyle(color: textMuted, fontSize: 11),
        indicatorColor: Colors.transparent,
      ),

      splashFactory: InkSparkle.splashFactory,

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: primaryCyan.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.orbitron(
              color: primaryCyan,
              fontWeight: FontWeight.bold,
              fontSize: 11,
              letterSpacing: 0.5,
            );
          }
          return GoogleFonts.orbitron(color: textMuted, fontSize: 10);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryCyan, size: 24);
          }
          return const IconThemeData(color: textMuted, size: 22);
        }),
      ),

      cardTheme: const CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderSubtle, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
