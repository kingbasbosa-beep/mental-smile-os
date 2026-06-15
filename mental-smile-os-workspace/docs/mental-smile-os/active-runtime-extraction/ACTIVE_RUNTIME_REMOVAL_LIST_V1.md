# ACTIVE_RUNTIME_REMOVAL_LIST_V1

## Purpose

List runtime areas that should not survive as source in the pure Generation 1 runtime.

## REMOVE AFTER ARCHIVE OR IGNORE

| Item | Reason |
| --- | --- |
| `build/` | Generated output. |
| `.dart_tool/` | Generated tooling cache. |
| `.firebase/` | Generated Firebase cache. |
| `node_modules/` | Dependency install output. |
| `functions/node_modules/` | Dependency install output. |
| `test/node_modules/` | Dependency install output. |
| `.flutter-plugins-dependencies` | Generated tooling metadata. |

## REMOVE AFTER MIGRATION

| Item | Reason |
| --- | --- |
| Hidden dependency on `mental_smile_clean_core` | Pure runtime must not depend on source mine package implicitly. |
| Legacy technical package identity `flutterprojects` | Must be replaced during package identity phase, not in this audit. |
| Android legacy namespace `com.mentalkey.app.flutterprojects` | Must be replaced during Android identity phase, not in this audit. |

## Rule

No removal is authorized by this document. It is a classification only.
