import 'package:flutter/material.dart';

class AppColors {
  static const Color warmIvory = Color(0xFFFAF8F5);
  static const Color sandstone = Color(0xFFEBE6D8);
  static const Color mutedGold = Color(0xFFD4AF37);
  static const Color deepTeal = Color(0xFF1A4B4F);
  static const Color obsidian = Color(0xFF14292B);
  static const Color mist = Color(0xFF7A8B8A);
  static const Color softTerracotta = Color(0xFFC26B51);
  static const Color success = Color(0xFF1F9D63);
  static const Color danger = Color(0xFFD84B4B);
  static const Color info = Color(0xFF6F9DC7);
  static const Color accentLavender = Color(0xFF8E63D2);
}

class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 28;
  static const double xxxl = 32;
}

class AppRadii {
  static const double sm = 14;
  static const double md = 18;
  static const double lg = 24;
  static const double xl = 28;
  static const double pill = 999;
}

class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(
      blurRadius: 24,
      color: Color(0x14000000),
      offset: Offset(0, 10),
    ),
  ];
}

ThemeData buildMentalKeyTheme(Locale locale) {
  final isArabic = locale.languageCode.toLowerCase() == 'ar';

  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.deepTeal,
    brightness: Brightness.light,
    primary: AppColors.deepTeal,
    surface: Colors.white,
  ).copyWith(
    secondary: AppColors.mutedGold,
    outline: AppColors.mutedGold.withValues(alpha: 0.22),
    surfaceContainerHighest: AppColors.sandstone,
  );

  final base = ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    fontFamily: 'system-ui',
    fontFamilyFallback: isArabic
        ? const [
            'Noto Sans Arabic',
            'Segoe UI',
            'Tahoma',
            'Arial',
            'sans-serif',
          ]
        : const [
            'Segoe UI',
            'Arial',
            'Tahoma',
            'sans-serif',
          ],
  );

  final textTheme = base.textTheme.copyWith(
    headlineLarge: base.textTheme.headlineLarge?.copyWith(
      color: AppColors.obsidian,
      fontWeight: FontWeight.w900,
      height: 1.15,
    ),
    headlineMedium: base.textTheme.headlineMedium?.copyWith(
      color: AppColors.obsidian,
      fontWeight: FontWeight.w800,
      height: 1.2,
    ),
    headlineSmall: base.textTheme.headlineSmall?.copyWith(
      color: AppColors.obsidian,
      fontWeight: FontWeight.w800,
      height: 1.2,
    ),
    titleLarge: base.textTheme.titleLarge?.copyWith(
      color: AppColors.obsidian,
      fontWeight: FontWeight.w800,
      height: 1.2,
    ),
    titleMedium: base.textTheme.titleMedium?.copyWith(
      color: AppColors.obsidian,
      fontWeight: FontWeight.w700,
      height: 1.3,
    ),
    titleSmall: base.textTheme.titleSmall?.copyWith(
      color: AppColors.obsidian,
      fontWeight: FontWeight.w700,
      height: 1.3,
    ),
    bodyLarge: base.textTheme.bodyLarge?.copyWith(
      color: AppColors.obsidian,
      height: 1.55,
    ),
    bodyMedium: base.textTheme.bodyMedium?.copyWith(
      color: AppColors.mist,
      height: 1.55,
    ),
    bodySmall: base.textTheme.bodySmall?.copyWith(
      color: AppColors.mist,
      height: 1.45,
    ),
  );

  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.md),
    borderSide: BorderSide(
      color: AppColors.mutedGold.withValues(alpha: 0.18),
    ),
  );

  return base.copyWith(
    textTheme: textTheme,
    scaffoldBackgroundColor: AppColors.warmIvory,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white.withValues(alpha: 0.90),
      elevation: 0,
      centerTitle: false,
      foregroundColor: AppColors.obsidian,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white.withValues(alpha: 0.82),
      elevation: 0,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        side: BorderSide(
          color: AppColors.mutedGold.withValues(alpha: 0.18),
        ),
      ),
      margin: EdgeInsets.zero,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.deepTeal,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.deepTeal.withValues(alpha: 0.55),
        disabledForegroundColor: Colors.white.withValues(alpha: 0.84),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        textStyle: textTheme.titleSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.deepTeal,
        backgroundColor: Colors.white.withValues(alpha: 0.84),
        side: BorderSide(
          color: AppColors.mutedGold.withValues(alpha: 0.24),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        textStyle: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.deepTeal,
        textStyle: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: Colors.white.withValues(alpha: 0.78),
      selectedColor: AppColors.deepTeal.withValues(alpha: 0.12),
      side: BorderSide(
        color: AppColors.mutedGold.withValues(alpha: 0.18),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      labelStyle: textTheme.bodyMedium?.copyWith(
        color: AppColors.obsidian,
        fontWeight: FontWeight.w700,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: AppColors.mist,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: const TextStyle(color: AppColors.mist),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.94),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: inputBorder.copyWith(
        borderSide: const BorderSide(
          color: AppColors.mutedGold,
          width: 1.15,
        ),
      ),
      errorBorder: inputBorder.copyWith(
        borderSide: BorderSide(
          color: AppColors.softTerracotta.withValues(alpha: 0.45),
        ),
      ),
      focusedErrorBorder: inputBorder.copyWith(
        borderSide: const BorderSide(
          color: AppColors.softTerracotta,
          width: 1.2,
        ),
      ),
    ),
    dividerColor: AppColors.mutedGold.withValues(alpha: 0.12),
  );
}
