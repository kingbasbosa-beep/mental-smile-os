import 'package:flutter/material.dart';

class AppColors {
  static const Color warmIvory = Color(0xFFFAF8F5);
  static const Color sandstone = Color(0xFFEBE6D8);
  static const Color mutedGold = Color(0xFFD4AF37);
  static const Color deepTeal = Color(0xFF1A4B4F);
  static const Color obsidian = Color(0xFF14292B);
  static const Color mist = Color(0xFF7A8B8A);
  static const Color danger = Color(0xFFD84B4B);
}

class AppSpacing {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
}

ThemeData buildMentalKeyTheme(Locale locale) {
  final isArabic = locale.languageCode.toLowerCase() == 'ar';
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.deepTeal,
      primary: AppColors.deepTeal,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.warmIvory,
    fontFamily: 'system-ui',
    fontFamilyFallback: isArabic
        ? const ['Noto Sans Arabic', 'Segoe UI', 'Tahoma', 'Arial']
        : const ['Segoe UI', 'Arial', 'Tahoma'],
  );

  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.obsidian,
      displayColor: AppColors.obsidian,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: AppColors.obsidian,
      centerTitle: false,
    ),
  );
}
