# CORE_EXTRACTION_PLAN_V1

## Purpose

Plan the removal or replacement of `mental_smile_clean_core` as an active hidden dependency.

## Current Reality

`mental_smile_clean_core` is active through `pubspec.yaml` and has an import test.

## Extraction Sequence

1. Inventory all active imports from `mental_smile_clean_core`.
2. Determine which contracts are actually used at runtime.
3. Create OS-owned replacement contracts only for used APIs.
4. Replace test proving clean core integration with OS package tests.
5. Remove `mental_smile_clean_core` dependency from `pubspec.yaml`.
6. Archive `mental_smile_clean_core/` as source evidence after validation.
7. Run `flutter pub get`, `flutter analyze`, and tests.

## Classification

| Component | Classification | Decision |
| --- | --- | --- |
| `mental_smile_clean_core` dependency | REPLACE | Must not survive as hidden pure runtime dependency. |
| `mental_smile_clean_core/` folder | ARCHIVE after extraction | Source/reference only. |
| Import test | REPLACE | Test the OS-owned extracted contracts instead. |

## Boundary

This plan does not execute extraction.
