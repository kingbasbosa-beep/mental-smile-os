# IDENTITY_ROLLBACK_PLAN_V1

## Purpose

Define rollback order for identity execution.

## Rollback Principle

Rollback must reverse the most recent execution phase first.

## Rollback Order

1. If core extraction fails:
   - Restore `mental_smile_clean_core` dependency in `pubspec.yaml`.
   - Restore imports that depended on core package.
   - Restore `test/mental_smile_clean_core_import_test.dart`.
   - Run `flutter pub get`.
2. If Android namespace migration fails:
   - Move `MainActivity.kt` back to `android/app/src/main/kotlin/com/mentalkey/app/flutterprojects/`.
   - Restore package declaration to `com.mentalkey.app.flutterprojects`.
   - Restore namespace to `com.mentalkey.app.flutterprojects`.
   - Run `flutter build apk --debug`.
3. If package rename fails:
   - Restore `pubspec.yaml` package name to `flutterprojects`.
   - Restore imports to `package:flutterprojects/`.
   - Run `flutter pub get`.
   - Run `flutter analyze`.

## Git Safety

Before any execution patch:

```powershell
git status
git diff
```

Rollback should use reviewed patch reversal, not destructive reset, unless Owner explicitly authorizes.
