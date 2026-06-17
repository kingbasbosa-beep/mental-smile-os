# RUNTIME_VALIDATION_EXECUTION_PACK_V1

## Purpose

Prepare the exact runtime validation sequence for the Generation 1 active runtime candidate.

## Source Reality

- Runtime status: `PRODUCTION_READY_WITH_WARNINGS`
- Route host files:
  - `lib/app/router/routes.dart`
  - `lib/app/router/app_router.dart`
- Runtime still carries known identity warnings:
  - `flutterprojects`
  - `package:flutterprojects`
  - `mental_smile_clean_core`
  - `com.mentalkey.app.flutterprojects`

## Validation Order

1. Dependency readiness validation.
2. Static analysis validation.
3. Route registry validation.
4. Owner protected route validation.
5. Monitoring protected route validation.
6. Signal runtime validation.
7. Web build validation.
8. Android debug build validation.
9. Runtime smoke validation.
10. Validation report and owner review.

## Command Targets

```powershell
flutter pub get
flutter analyze
flutter build web
flutter build apk --debug
```

## Execution Boundary

This pack prepares validation only. It does not run Flutter, modify runtime files, change Firebase, change YAML, deploy, commit, or push.

