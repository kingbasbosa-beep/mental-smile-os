import 'package:flutter/material.dart';
import 'package:mental_smile_os/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_smile_os/app/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mental_smile_os/app/router/app_router.dart';
import 'package:mental_smile_os/shared/ui_kit/app_design_system.dart';

class MentalSmileOSApp extends ConsumerWidget {
  const MentalSmileOSApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref.watch(localeProvider);
    final effectiveLocale = selectedLocale ?? const Locale('ar');

    return MaterialApp(
      locale: effectiveLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: buildMentalSmileOSTheme(effectiveLocale),
      title: 'Mental Smile',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
