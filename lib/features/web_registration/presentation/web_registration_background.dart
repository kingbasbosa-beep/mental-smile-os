import 'package:flutter/material.dart';

const Color webRegistrationDarkNavy = Color(0xFF0B2147);
const Color webRegistrationPanelNavy = Color(0xFF061A26);
const Color webRegistrationFieldFill = Color(0xCC061A26);
const Color webRegistrationBorderTurquoise = Color(0xFF00E5FF);
const Color webRegistrationTextTurquoise = Color(0xFF7DF9FF);
const List<Shadow> webRegistrationTextShadows = [
  Shadow(
    color: Colors.black,
    blurRadius: 8,
    offset: Offset(0, 1),
  ),
];

String webRegistrationBackgroundAsset(
  BuildContext context, {
  required String roleFolder,
  required String fileName,
}) {
  final width = MediaQuery.sizeOf(context).width;
  final sizeFolder = width < 700
      ? 'mobile'
      : width < 1200
          ? 'tablet'
          : 'desktop';
  return 'assets/branding/web/registration/$roleFolder/$sizeFolder/$fileName';
}

Widget webRegistrationCompactFormTheme(
  BuildContext context, {
  required Widget child,
}) {
  final theme = Theme.of(context);
  TextStyle readable(TextStyle? style) {
    return (style ?? const TextStyle()).copyWith(
      color: webRegistrationTextTurquoise,
      fontWeight: FontWeight.w700,
      shadows: webRegistrationTextShadows,
    );
  }

  final textTheme = theme.textTheme.copyWith(
    displayLarge: readable(theme.textTheme.displayLarge),
    displayMedium: readable(theme.textTheme.displayMedium),
    displaySmall: readable(theme.textTheme.displaySmall),
    headlineLarge: readable(theme.textTheme.headlineLarge),
    headlineMedium: readable(theme.textTheme.headlineMedium),
    headlineSmall: readable(theme.textTheme.headlineSmall),
    titleLarge: readable(theme.textTheme.titleLarge),
    titleMedium: readable(theme.textTheme.titleMedium),
    titleSmall: readable(theme.textTheme.titleSmall),
    bodyLarge: readable(theme.textTheme.bodyLarge),
    bodyMedium: readable(theme.textTheme.bodyMedium),
    bodySmall: readable(theme.textTheme.bodySmall),
    labelLarge: readable(theme.textTheme.labelLarge),
    labelMedium: readable(theme.textTheme.labelMedium),
    labelSmall: readable(theme.textTheme.labelSmall),
  );
  return Theme(
    data: theme.copyWith(
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: theme.iconTheme.copyWith(color: webRegistrationTextTurquoise),
      listTileTheme: theme.listTileTheme.copyWith(
        textColor: webRegistrationTextTurquoise,
        iconColor: webRegistrationTextTurquoise,
        titleTextStyle: readable(theme.listTileTheme.titleTextStyle),
      ),
      checkboxTheme: theme.checkboxTheme.copyWith(
        checkColor: WidgetStateProperty.all(webRegistrationDarkNavy),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return webRegistrationTextTurquoise;
          }
          return webRegistrationFieldFill;
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: theme.elevatedButtonTheme.style?.copyWith(
              foregroundColor:
                  WidgetStateProperty.all(webRegistrationDarkNavy),
            ) ??
            ElevatedButton.styleFrom(foregroundColor: webRegistrationDarkNavy),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        isDense: true,
        filled: true,
        fillColor: webRegistrationFieldFill,
        labelStyle: const TextStyle(
          color: webRegistrationTextTurquoise,
          fontWeight: FontWeight.w700,
          shadows: webRegistrationTextShadows,
        ),
        floatingLabelStyle: const TextStyle(
          color: webRegistrationTextTurquoise,
          fontWeight: FontWeight.w700,
          shadows: webRegistrationTextShadows,
        ),
        hintStyle: const TextStyle(
          color: webRegistrationTextTurquoise,
          fontWeight: FontWeight.w700,
          shadows: webRegistrationTextShadows,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: webRegistrationBorderTurquoise,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: webRegistrationBorderTurquoise,
            width: 1.4,
          ),
        ),
      ),
    ),
    child: child,
  );
}

double webRegistrationFormBottomPadding(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 700) return 24;
  if (width < 1200) return 36;
  return 48;
}
