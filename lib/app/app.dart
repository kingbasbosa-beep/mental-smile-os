import 'package:flutter/material.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojects/app/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterprojects/app/router/app_router.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class MentalKeyApp extends ConsumerWidget {
  const MentalKeyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale effectiveLocale =
        ref.watch(localeProvider) ?? const Locale('ar');

    return MaterialApp(
      locale: effectiveLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: buildMentalKeyTheme(effectiveLocale),
      title: 'Mental Smile',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
