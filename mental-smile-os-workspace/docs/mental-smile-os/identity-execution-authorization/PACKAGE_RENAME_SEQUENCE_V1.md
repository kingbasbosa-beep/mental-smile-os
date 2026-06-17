# PACKAGE_RENAME_SEQUENCE_V1

## Purpose

Define exact sequence for package rename.

## Target

Current: `flutterprojects`.

Target: `mental_smile_os`.

## Execution Sequence

1. Create safety checkpoint.
2. Confirm no unrelated runtime changes are in progress.
3. Edit `pubspec.yaml`.
4. Replace `name: flutterprojects` with `name: mental_smile_os`.
5. Replace all active Dart imports:
   - From `package:flutterprojects/`
   - To `package:mental_smile_os/`
6. Include active `lib/` and `test/`.
7. Exclude `_archive/`, `.dart_tool/`, `.firebase/`, `build/`, `node_modules/`, and historical docs.
8. Run `flutter pub get`.
9. Run `flutter analyze`.
10. Run `flutter test` if tests exist.
11. Run `flutter build web`.
12. Review diff.

## Validation Points

- `rg "package:flutterprojects" lib test` returns no active results.
- `pubspec.yaml` package name is `mental_smile_os`.
- `flutter analyze` passes.
- `flutter build web` passes.

## Stop Condition

Stop before commit or push until Owner approves.
