import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutterprojects/core/auth/anonymous_auth_bootstrap.dart';
import 'package:flutterprojects/core/firebase/firebase_bootstrap.dart';

import 'firebase_options.dart';
import 'package:flutterprojects/app/app.dart';

const bool kMkBootstrap =
    bool.fromEnvironment('MK_BOOTSTRAP', defaultValue: false);
const bool kMkSeed = bool.fromEnvironment('MK_SEED', defaultValue: false);
const String kMkEnv = String.fromEnvironment('MK_ENV', defaultValue: 'dev');

// Back-compat (old names)
const bool kEnableBootstrap =
    bool.fromEnvironment('BOOTSTRAP', defaultValue: false);
const bool kEnableSeed = bool.fromEnvironment('SEED', defaultValue: false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('🔥 Firebase init failed: $e');
  }

  // Web: make sure AnonymousAuth is ready BEFORE first route builds.
  await AnonymousAuthBootstrap.ensureSignedIn();

  // Bootstrap / seed (optional) - runs after auth is ready
  if (kMkBootstrap || kMkSeed || kEnableBootstrap || kEnableSeed) {
    await FirebaseBootstrap.run(
      doConnectivityCheck: (kMkBootstrap || kEnableBootstrap),
      doSeed: (kMkSeed || kEnableSeed),
    );
  }

  runApp(const ProviderScope(child: MentalKeyApp()));

  // Anonymous identity (web) for booking continuity without PII
  // IMPORTANT: Bootstrap runs AFTER auth is ready (debug/{uid} rules pass)

  // Anonymous identity (web) for booking continuity without PII

  // Anonymous identity (web) for booking continuity without PII

  // Anonymous identity (web) for booking continuity without PII

  // Bootstrap / seed (optional)
}
