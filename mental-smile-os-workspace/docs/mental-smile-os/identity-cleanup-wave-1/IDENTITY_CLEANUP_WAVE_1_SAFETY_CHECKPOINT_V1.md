# IDENTITY_CLEANUP_WAVE_1_SAFETY_CHECKPOINT_V1

## Purpose

Create a safety checkpoint before executing Generation 1 technical identity cleanup Wave 1.

## Allowed Scope

- Rename Dart package in `pubspec.yaml` from `flutterprojects` to `mental_smile_os`.
- Replace Dart imports in `lib/`, `test/`, and `integration_test/` from `package:flutterprojects/` to `package:mental_smile_os/`.
- Run `flutter pub get`.
- Run `flutter analyze`.
- Report results.

## Forbidden Scope

- No Firebase edits.
- No Android namespace edit.
- No Android applicationId edit.
- No `mental_smile_clean_core` removal.
- No archive movement.
- No file deletion.
- No deploy.
- No push.
- No commit.

## Pre-Change Reality

`pubspec.yaml` package name before Wave 1:

```yaml
name: flutterprojects
```

Detected Dart import occurrences before replacement:

```text
package:flutterprojects/ = 268
```

## Git State Note

The worktree already contains modified and untracked documentation from previous Mental Smile OS steps. Wave 1 must not revert or clean those files.

## Safety Status

Checkpoint Status: CREATED

Rollback Required If Failure: YES

