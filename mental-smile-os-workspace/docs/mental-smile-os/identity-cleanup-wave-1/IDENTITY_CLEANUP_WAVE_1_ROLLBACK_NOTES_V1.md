# IDENTITY_CLEANUP_WAVE_1_ROLLBACK_NOTES_V1

## Purpose

Document how to roll back Identity Cleanup Wave 1 if manual validation fails.

## Rollback Scope

Rollback only covers:

- `pubspec.yaml` package name change.
- Dart import rewrite from `package:flutterprojects/` to `package:mental_smile_os/`.

Rollback does not cover Android namespace, Firebase, or `mental_smile_clean_core`, because Wave 1 did not change them.

## Rollback Order

1. Revert Dart imports first:

```text
package:mental_smile_os/
```

Back to:

```text
package:flutterprojects/
```

2. Revert `pubspec.yaml` package name:

```yaml
name: mental_smile_os
```

Back to:

```yaml
name: flutterprojects
```

3. Run owner-side validation:

```powershell
flutter pub get
flutter analyze
```

## Recommended Rollback Method

Use a reviewed reverse patch.

Do not use destructive repository reset unless Owner explicitly approves it.

## Rollback Safety Rules

- Do not delete files.
- Do not remove `mental_smile_clean_core`.
- Do not change Android namespace.
- Do not change applicationId.
- Do not change Firebase config.
- Do not deploy.
- Do not push.

## Rollback Decision

Rollback is only needed if manual validation shows package rename/import rewrite causes compile failure that cannot be addressed within Wave 1 scope.

