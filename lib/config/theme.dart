import 'package:flutter/material.dart';

class AppTheme {
  // Colores según el diseño propuesto
  static const Color primary = Color(0xFF4CAF50);
  static const Color accent = Color(0xFFFFC107);
  static const Color alert = Color(0xFFF44336);
  static const Color accentBlue = Color(0xFF2196F3);
  
  // Light theme colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color textLight = Color(0xFF333333);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE0E0E0);
  
  // Dark theme colors
  static const Color backgroundDark = Color(0xFF1a1a1a);
  static const Color textDark = Color(0xFFE0E0E0);
  static const Color cardDark = Color(0xFF2C2C2C);
  static const Color borderDark = Color(0xFF424242);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
      error: alert,
      surface: cardLight,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: textLight,
    ),
    fontFamily: 'Manrope',
    appBarTheme: const AppBarTheme(
      backgroundColor: cardLight,
      foregroundColor: textLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textLight,
        fontFamily: 'Manrope',
      ),
    ),
    cardTheme: CardTheme(
      color: cardLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: borderLight, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Manrope',
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textLight,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textLight,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textLight,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textLight,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: textLight,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: accent,
      error: alert,
      surface: cardDark,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: textDark,
    ),
    fontFamily: 'Manrope',
    appBarTheme: const AppBarTheme(
      backgroundColor: cardDark,
      foregroundColor: textDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textDark,
        fontFamily: 'Manrope',
      ),
    ),
    cardTheme: CardTheme(
      color: cardDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: borderDark, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Manrope',
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: textDark,
      ),
    ),
  );
}
