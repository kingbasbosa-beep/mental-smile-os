# CORE_EXTRACTION_EXECUTION_SEQUENCE_V1

## Purpose

Define exact core dependency extraction sequence.

## Current Dependency

`mental_smile_clean_core` in `pubspec.yaml`.

## Recommended Fate

KEEP_TEMPORARY_WITH_EXPLICIT_EXPIRY, then REMOVE_AFTER_EXTRACTION.

## Execution Sequence

1. Inventory actual runtime imports from `mental_smile_clean_core`.
2. Record every used exported symbol.
3. Classify each used symbol:
   - INLINE_REQUIRED_PARTS.
   - REPLACE_WITH_OS_MODULES.
   - ARCHIVE_ONLY.
   - REMOVE.
4. Create OS-owned replacement modules for required symbols.
5. Replace imports in runtime code.
6. Replace `test/mental_smile_clean_core_import_test.dart` with OS-owned contract tests or archive it.
7. Remove `mental_smile_clean_core` dependency from `pubspec.yaml`.
8. Run `flutter pub get`.
9. Run `flutter analyze`.
10. Run `flutter test`.
11. Run `flutter build web`.
12. Run `flutter build apk --debug`.
13. Review diff.

## Validation Points

- `rg "mental_smile_clean_core" lib test pubspec.yaml` returns no active dependency references unless explicitly marked temporary.
- `flutter analyze` passes.
- Web build passes.
- Debug APK build passes.

## Stop Condition

Stop before deleting `mental_smile_clean_core/`. Archive/movement/deletion requires separate Owner confirmation.
