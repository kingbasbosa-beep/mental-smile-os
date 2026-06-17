# IDENTITY_PURIFICATION_VALIDATION_SEQUENCE_V1

## Purpose

Define validation commands after identity purification patches.

## Required Validation Commands

```powershell
flutter pub get
flutter analyze
flutter test
flutter build web
flutter build apk --debug
```

## Conditional Validation

If tests are absent or incomplete, record the gap explicitly.

If Android applicationId changes:

```powershell
flutter clean
flutter pub get
flutter build apk --debug
```

Then verify:

- `android/app/google-services.json`.
- Firebase Android app registration.
- package path.
- namespace.
- applicationId.

## Git Guardrail

No commit or push before:

- diff review.
- analyzer pass.
- build pass.
- Owner approval.
