# CORE_DEPENDENCY_AUDIT_V1

## Purpose

Identify remaining active dependencies that still belong to legacy/core technical identity.

## Findings

| Dependency / Reference | File | Exact Reference | Classification | Action |
| --- | --- | --- | --- | --- |
| Flutter package technical name | `pubspec.yaml:1` | `name: flutterprojects` | RENAME | Rename only in a controlled package-identity execution step. |
| Local core dependency | `pubspec.yaml:30` | `mental_smile_clean_core:` | REPLACE | Extract required contracts or replace with OS-owned package. |
| Local core dependency path | `pubspec.yaml:31` | `path: mental_smile_clean_core` | REPLACE | Remove hidden dependency after extraction. |
| Core package import test | `test/mental_smile_clean_core_import_test.dart:2` | `package:mental_smile_clean_core/mental_smile_clean_core.dart` | ARCHIVE / REPLACE | Archive if core package is retired; replace if OS package is created. |
| Core package integration test label | `test/mental_smile_clean_core_import_test.dart:5` | `Proof of mental_smile_clean_core integration` | ARCHIVE / REPLACE | Historical proof, not production identity. |
| Core source folder | `mental_smile_clean_core/` | local path package | ARCHIVE / REPLACE | Current active dependency; must not remain hidden in pure OS runtime. |

## Risk

Risk Level: HIGH.

`mental_smile_clean_core` is not merely historical. It is an active dependency through `pubspec.yaml`.

## Verdict

Core extraction is required before the runtime can be called independent.
