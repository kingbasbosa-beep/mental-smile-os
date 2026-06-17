# CORE_EXTRACTION_WAVE_1_CHANGE_REPORT_V1

## Purpose

Report the actual result of `mental_smile_clean_core` Extraction Wave 1.

## Executed Changes

| Change | Status |
| --- | --- |
| Safety checkpoint created | COMPLETED |
| `mental_smile_clean_core` removed from `pubspec.yaml` active dependencies | COMPLETED |
| Test proof file isolated from old core import | COMPLETED |
| `mental_smile_clean_core/` folder deleted | NOT PERFORMED |
| `mental_smile_clean_core/` folder moved | NOT PERFORMED |
| Runtime architecture changed | NOT PERFORMED |
| Firebase edited | NOT PERFORMED |
| Android namespace/applicationId changed | NOT PERFORMED |
| Deploy/push/commit | NOT PERFORMED |

## Dependency Before

```yaml
mental_smile_clean_core:
  path: mental_smile_clean_core
```

## Dependency After

`mental_smile_clean_core` is no longer declared as an active dependency in `pubspec.yaml`.

## Files Changed

- `pubspec.yaml`
- `test/mental_smile_clean_core_import_test.dart`
- `mental-smile-os-workspace/docs/mental-smile-os/core-extraction-wave-1/CORE_EXTRACTION_WAVE_1_SAFETY_CHECKPOINT_V1.md`

## Test Proof Handling

Before:

```dart
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';
```

The test referenced:

- `AuditActorType`
- `AuditActorType.admin`
- `AuditActorTypeKey.key`

After:

The test no longer imports `mental_smile_clean_core`.

It now uses a minimal local proof that the active runtime no longer requires the old core package as an active dependency.

## Lockfile Status

`pubspec.lock`: OWNER_MANUAL_PENDING

Reason: Owner will run `flutter pub get` manually. That command is expected to remove the `mental_smile_clean_core` lockfile entry if no active dependency remains.

## Validation Status

`flutter pub get`: OWNER_MANUAL_PENDING

`flutter analyze`: OWNER_MANUAL_PENDING

`flutter build apk --debug`: OWNER_MANUAL_PENDING

Reason: Owner instructed Codex not to run commands and will run them manually.

## Warnings

- `pubspec.lock` may still contain `mental_smile_clean_core` until Owner runs `flutter pub get`.
- The folder `mental_smile_clean_core/` remains present by design as source repository evidence.
- Construction Workbench may still reference the folder path as source evidence, not active runtime dependency.

## Boundary Confirmation

- No Firebase modified.
- No Android namespace/applicationId modified.
- No `mental_smile_clean_core/` folder deletion.
- No archive movement.
- No deploy.
- No push.
- No commit.

