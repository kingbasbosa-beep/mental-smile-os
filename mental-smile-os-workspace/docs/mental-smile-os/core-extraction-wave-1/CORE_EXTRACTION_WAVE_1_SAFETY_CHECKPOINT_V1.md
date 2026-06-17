# CORE_EXTRACTION_WAVE_1_SAFETY_CHECKPOINT_V1

## Purpose

Create a safety checkpoint before removing `mental_smile_clean_core` as an active Dart dependency.

## Allowed Scope

- Remove only the `mental_smile_clean_core` path dependency from `pubspec.yaml`.
- Update the test proof file that imports `mental_smile_clean_core`.
- Run validation commands.
- Preserve the `mental_smile_clean_core/` folder as source repository evidence.

## Forbidden Scope

- No deletion of `mental_smile_clean_core/`.
- No movement of `mental_smile_clean_core/`.
- No runtime architecture change.
- No Firebase edit.
- No Android namespace or applicationId change.
- No deploy.
- No push.
- No commit.
- No archive movement.
- No broad test rewrite.

## Pre-Change Dependency

```yaml
mental_smile_clean_core:
  path: mental_smile_clean_core
```

## Pre-Change Test Import

```dart
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';
```

## Source Evidence Boundary

The folder `mental_smile_clean_core/` must remain in place.

It is preserved as source repository evidence only.

## Safety Status

Checkpoint Status: CREATED

