import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Custom Neon Color Palette
  static const Color background = Color(0xFF060913);
  static const Color surface = Color(0xFF0E1326);
  static const Color surfaceElevated = Color(0xFF161E38);
  
  static const Color primaryCyan = Color(0xFF00F2FE);
  static const Color secondaryMagenta = Color(0xFFFF007F);
  static const Color tertiaryYellow = Color(0xFFFFF200);

  static const Color textPrimary = Color(0xFFE2E8F0);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static const Color borderSubtle = Color(0xFF1E294B);
  static const Color borderCyan = Color(0x3300F2FE); // Low opacity for inactive/subtle glow
  static const Color borderMagenta = Color(0x33FF007F);

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
      
      // Text Theme with custom fonts
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
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
        bodyLarge: GoogleFonts.outfit(
          color: textPrimary,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.outfit(
          color: textSecondary,
          fontSize: 14,
        ),
        labelLarge: GoogleFonts.orbitron(
          color: textPrimary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),

      // Custom NavigationRail Theme
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
        unselectedLabelTextStyle: TextStyle(
          color: textMuted,
          fontSize: 11,
        ),
        indicatorColor: Colors.transparent,
      ),

      // Custom NavigationBar Theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: primaryCyan.withOpacity(0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.orbitron(
              color: primaryCyan,
              fontWeight: FontWeight.bold,
              fontSize: 11,
              letterSpacing: 0.5,
            );
          }
          return GoogleFonts.orbitron(
            color: textMuted,
            fontSize: 10,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryCyan, size: 24);
          }
          return const IconThemeData(color: textMuted, size: 22);
        }),
      ),

      // Card Theme
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
