# PACKAGE_RENAME_EXECUTION_MAP_V1

## Purpose

Map package rename from legacy technical identity to OS identity.

## Target

Current package name: `flutterprojects`.

Recommended target package name: `mental_smile_os`.

## Rename Map

| File / Area | Current | Target | Action |
| --- | --- | --- | --- |
| `pubspec.yaml:1` | `name: flutterprojects` | `name: mental_smile_os` | RENAME |
| Dart imports | `package:flutterprojects/...` | `package:mental_smile_os/...` | RENAME |
| Tests | Any `package:flutterprojects/...` | `package:mental_smile_os/...` | RENAME |
| Generated references | Any package generated references | Regenerate if needed | REGENERATE |

## Required Guardrails

- Rename package and imports in one scoped patch.
- Do not change Android applicationId in same patch.
- Run `flutter pub get` after package rename.
- Run `flutter analyze`.
- Run tests if present.

## Risk

Risk Level: HIGH.
