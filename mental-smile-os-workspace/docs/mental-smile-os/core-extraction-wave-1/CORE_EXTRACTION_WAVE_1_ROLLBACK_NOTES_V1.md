# CORE_EXTRACTION_WAVE_1_ROLLBACK_NOTES_V1

## Purpose

Document rollback for `mental_smile_clean_core` Extraction Wave 1.

## Rollback Scope

Rollback only covers:

- Restoring `mental_smile_clean_core` dependency in `pubspec.yaml`.
- Restoring the old proof test import and symbol usage if needed.

Rollback does not cover Firebase, Android namespace, applicationId, archive movement, or folder movement, because Wave 1 did not change them.

## Rollback Order

1. Restore dependency in `pubspec.yaml`:

```yaml
mental_smile_clean_core:
  path: mental_smile_clean_core
```

2. Restore the test import:

```dart
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';
```

3. Restore the previous proof assertion:

```dart
const adminKey = AuditActorType.admin;

expect(adminKey.key, equals('admin'));
```

4. Owner runs:

```powershell
flutter pub get
flutter analyze
flutter build apk --debug
```

## Recommended Rollback Method

Use a reviewed reverse patch.

Do not use destructive repository reset unless Owner explicitly approves it.

## Rollback Safety Rules

- Do not delete files.
- Do not move `mental_smile_clean_core/`.
- Do not edit Firebase.
- Do not edit Android namespace/applicationId.
- Do not deploy.
- Do not push.

## Rollback Decision

Rollback is only needed if Owner manual validation shows dependency removal causes blocking errors that cannot be handled inside the approved Wave 1 scope.

