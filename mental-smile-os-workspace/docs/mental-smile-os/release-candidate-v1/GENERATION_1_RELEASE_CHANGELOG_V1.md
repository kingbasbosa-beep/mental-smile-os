# GENERATION_1_RELEASE_CHANGELOG_V1

## STEP 056 - Identity Cleanup Execution Wave 1

- Renamed Dart package from `flutterprojects` to `mental_smile_os`.
- Replaced Dart imports from `package:flutterprojects/` to `package:mental_smile_os/`.

## STEP 057 - Android Namespace Migration Wave 1

- Migrated Android namespace from `com.mentalkey.app.flutterprojects` to `com.mentalsmile.os`.
- Preserved Android applicationId as `com.mentalkey.app.flutterprojects`.
- Updated `MainActivity` package declaration.
- Updated manifest activity reference to explicit `com.mentalsmile.os.MainActivity`.

## STEP 058 - Identity Wave Validation Closeout

- Recorded `flutter pub get` PASS.
- Recorded `flutter analyze` PASS with no Dart warnings/errors.
- Recorded `flutter build apk --debug` PASS.
- Recorded APK output: `build\app\outputs\flutter-apk\app-debug.apk`.

## STEP 059 - Core Usage Audit

- Documented active usage of `mental_smile_clean_core`.
- Determined extraction complexity: MEDIUM.
- Confirmed Wave 1 extraction was safe.

## STEP 060 - Core Extraction Wave 1

- Removed `mental_smile_clean_core` from active `pubspec.yaml` dependency.
- Updated proof test to avoid importing old core package.
- Preserved `mental_smile_clean_core/` folder as source evidence.

## STEP 061 - Firebase Warning Cleanup Wave 1

- Removed duplicate `isMonitoringOperator()` helper from `firestore.rules`.
- Reviewed Storage clinician/center Firestore fallback.
- Deferred fallback removal pending claims audit.
- Preserved Admin Zero and Owner authority.

