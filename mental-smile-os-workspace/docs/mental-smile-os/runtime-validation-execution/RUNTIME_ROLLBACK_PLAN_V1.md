# RUNTIME_ROLLBACK_PLAN_V1

## Purpose

Define rollback behavior for runtime validation changes if future validation patches are applied.

## Rollback Principle

No destructive reset unless Owner explicitly approves. Prefer reviewed reverse patches.

## Rollback Order

1. Stop validation run.
2. Preserve logs and failing command output.
3. If a route patch was applied, reverse route patch first.
4. If a localization patch was applied, reverse ARB patch and regenerate localization.
5. If an asset/YAML patch was applied, reverse YAML entry before removing asset files.
6. If package identity patch was applied, follow `IDENTITY_ROLLBACK_PLAN_V1`.
7. If Firebase validation patch was applied, follow `FIREBASE_ROLLBACK_PLAN_V1`.
8. Re-run minimum validation:

```powershell
flutter pub get
flutter analyze
flutter build web
```

## Rollback Forbidden Actions

- No deletion of historical evidence.
- No Firebase deploy during rollback unless Owner confirms.
- No git reset hard without Owner confirmation.
- No archive movement during validation rollback.

