import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF92A3FD);
  static const secondary = Color(0xFF9DCEFF);
  static const purpleAccent = Color(0xFFC58BF2);
  static const pinkAccent = Color(0xFFEEA4CE);
  
  static const backgroundLight = Color(0xFFF7F8F8);
  static const backgroundDark = Color(0xFF000000); // True Black
  
  static const cardLight = Colors.white;
  static const cardDark = Color(0xFF121212); // Very Dark Grey
}

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.cardLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.cardDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    canvasColor: AppColors.backgroundDark,
  );
}
