
import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF070D17);
  static const Color surface = Color(0xFF101C2B);
  static const Color surfaceLight = Color(0xFF172638);
  static const Color panel = Color(0xFF0D1928);
  static const Color line = Color(0xFF263B50);

  static const Color cyan = Color(0xFF20C9E8);
  static const Color blue = Color(0xFF398BFF);
  static const Color magenta = Color(0xFFE83D91);

  static const Color text = Color(0xFFEAF3FF);
  static const Color muted = Color(0xFF91A4BA);

  static const Color success = Color(0xFF2DD4A7);
  static const Color warning = Color(0xFFFFB547);
  static const Color danger = Color(0xFFFF4F78);

  // Compatibilidade com nomes usados em versões anteriores.
  static const Color bg = background;

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      fontFamily: 'Roboto',
      colorScheme: const ColorScheme.dark(
        primary: cyan,
        secondary: magenta,
        surface: surface,
        error: danger,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        labelStyle: const TextStyle(color: muted),
        hintStyle: const TextStyle(color: muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: cyan, width: 1.5),
        ),
      ),
    );
  }
}
