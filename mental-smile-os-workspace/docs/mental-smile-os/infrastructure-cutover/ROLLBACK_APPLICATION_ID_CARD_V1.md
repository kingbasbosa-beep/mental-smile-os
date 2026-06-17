# Rollback Application ID Card V1

## Identity

Card ID: ROLLBACK_APPLICATION_ID_CARD_V1

Purpose: Define rollback for Android applicationId cutover.

## Current New Value

`com.mentalsmile.app`

## Previous Value

`com.mentalkey.app.flutterprojects`

## Rollback Files

| File | Rollback Action |
| --- | --- |
| `android/app/build.gradle.kts` | Restore `applicationId = "com.mentalkey.app.flutterprojects"`. |
| `android/app/google-services.json` | Restore the previous config matching `com.mentalkey.app.flutterprojects`. |
| `lib/firebase_options.dart` | Restore only if it is later changed in a separate wave. |

## Rollback Commands

Manual validation after rollback:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter build apk --debug
```

## Rollback Trigger

Rollback only if:

- Android build fails due to applicationId/Firebase mismatch.
- Firebase initialization fails and cannot be corrected within the cutover scope.
- Owner chooses to preserve legacy applicationId for continuity.

## Status

PREPARED_NOT_USED.
