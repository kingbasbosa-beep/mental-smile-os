import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:mental_smile_os/app/app.dart';
import 'package:mental_smile_os/app/locale_provider.dart';
import 'package:mental_smile_os/core/storage/locale_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('🔥 Firebase init failed: $e');
  }

  final savedLanguageCode = await LocaleStorage().read();
  final savedLocale = savedLanguageCode == 'ar' || savedLanguageCode == 'en'
      ? Locale(savedLanguageCode!)
      : null;

  runApp(
    ProviderScope(
      overrides: [
        localeProvider.overrideWith((ref) => savedLocale),
      ],
      child: const MentalKeyApp(),
    ),
  );
}
