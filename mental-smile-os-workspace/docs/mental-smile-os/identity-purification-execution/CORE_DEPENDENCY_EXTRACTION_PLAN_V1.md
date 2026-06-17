# CORE_DEPENDENCY_EXTRACTION_PLAN_V1

## Purpose

Plan extraction of `mental_smile_clean_core` from the active runtime.

## Current State

`mental_smile_clean_core` remains active in `pubspec.yaml`.

## Recommended Fate

KEEP_TEMPORARY_WITH_EXPLICIT_EXPIRY.

Then:

REMOVE_AFTER_EXTRACTION.

## Execution Phases

1. Inventory actual imports from `mental_smile_clean_core`.
2. Identify runtime-required APIs.
3. Classify each API as inline, replace, archive, or remove.
4. Create OS-owned modules only for required contracts.
5. Replace dependency imports.
6. Replace or remove `test/mental_smile_clean_core_import_test.dart`.
7. Remove `mental_smile_clean_core` from `pubspec.yaml`.
8. Run full validation.

## Validation

```powershell
flutter pub get
flutter analyze
flutter test
flutter build web
flutter build apk --debug
```

## Risk

Risk Level: HIGH.
