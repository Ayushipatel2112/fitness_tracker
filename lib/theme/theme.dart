import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── App Colors ─────────────────────────────────────────────
// These are the main colors used throughout the app.
// The primary color is a deep pink/maroon matching your shared code.
class AppColors {
  // ── Brand Colors (from your shared main.dart) ──
  static const Color appBar      = Color.fromARGB(255, 167, 3, 85);   // Deep pink AppBar
  static const Color button      = Color.fromARGB(255, 158, 9, 91);   // Button background
  static const Color buttonGlow  = Color.fromARGB(255, 218, 7, 123);  // Button shadow/glow
  static const Color inputFocus  = Color.fromARGB(255, 167, 3, 85);   // Focused border of TextFields

  // ── Gradient (kept for gradient widgets like cards) ──
  static const List<Color> primaryGradient = [
    Color(0xFF92A3FD),
    Color(0xFF9DCEFF),
  ];
  static const List<Color> secondaryGradient = [
    Color(0xFFC58BF2),
    Color(0xFFEEA4CE),
  ];

  // ── General Palette ──
  static const Color primary        = Color.fromARGB(255, 167, 3, 85); // matches AppBar
  static const Color primaryShade   = Color(0xFF9BB0FF);
  static const Color secondary      = Color(0xFFC58BF2);
  static const Color secondaryShade = Color(0xFFDABFFF);

  static const Color black  = Color(0xFF1D1617);
  static const Color gray1  = Color(0xFF7B6F72);
  static const Color gray2  = Color(0xFFADA4A5);
  static const Color gray3  = Color(0xFFDDDADA);
  static const Color white  = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFF7F8F8);
}

// ─── App Theme ───────────────────────────────────────────────
// Light and dark themes with the design from your shared code applied.
class AppTheme {

  // ── Light Theme ──────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Background color of every Scaffold screen
    scaffoldBackgroundColor: Colors.grey[200],

    // Primary color used by Material widgets internally
    primaryColor: AppColors.appBar,

    // Font family (Poppins for clean beginner-friendly look)
    fontFamily: GoogleFonts.poppins().fontFamily,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.appBar,
      brightness: Brightness.light,
    ),

    // ── AppBar Style ──
    // Makes every AppBar in the app use the deep pink/maroon color
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBar,        // Color.fromARGB(255, 167, 3, 85)
      foregroundColor: AppColors.white,          // text & icons are white
      elevation: 0,
      centerTitle: true,
    ),

    // ── ElevatedButton Style ──
    // All ElevatedButton widgets will look the same automatically
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.button,       // Color.fromARGB(255, 158, 9, 91)
        foregroundColor: AppColors.white,         // Text color = white
        shadowColor: AppColors.buttonGlow,        // Color.fromARGB(255, 218, 7, 123)
        elevation: 4,
        minimumSize: const Size(double.infinity, 50), // full-width, 50px tall
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // rounded corners
        ),
      ),
    ),

    // ── TextField / InputDecoration Style ──
    // All TextField widgets will use white background with rounded border
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,               // white background
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), // rounded corners
        borderSide: BorderSide.none,             // no visible border by default
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.inputFocus,           // pink border when focused
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),

    // ── Text Theme ──
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.gray1,
      ),
    ),
  );

  // ── Dark Theme ───────────────────────────────────────────
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: AppColors.appBar,
    fontFamily: GoogleFonts.poppins().fontFamily,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.appBar,
      brightness: Brightness.dark,
    ),

    // ── AppBar (same pink in dark mode) ──
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBar,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
    ),

    // ── ElevatedButton (same style in dark mode) ──
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.button,
        foregroundColor: AppColors.white,
        shadowColor: AppColors.buttonGlow,
        elevation: 4,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),

    // ── TextField (slightly darker fill in dark mode) ──
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.inputFocus,
          width: 1.5,
        ),
      ),
    ),

    // ── Text Theme ──
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFB0B0B0),
      ),
    ),
  );
}
