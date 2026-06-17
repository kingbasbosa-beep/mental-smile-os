# Android Application ID Cutover Report V1

Result: ANDROID_APPLICATION_ID_CUTOVER_READY_FOR_VALIDATION

Mode: Android applicationId cutover only. No namespace change, MainActivity package change, Firebase rules change, deploy, push, or commit was performed.

## Identity Change

| Field | Old Value | New Value |
| --- | --- | --- |
| Android applicationId | `com.mentalkey.app.flutterprojects` | `com.mentalsmile.app` |
| Android namespace | `com.mentalsmile.os` | `com.mentalsmile.os` |
| MainActivity package | `com.mentalsmile.os` | `com.mentalsmile.os` |

## Google Services Status

| Field | Value |
| --- | --- |
| google-services path | `android/app/google-services.json` |
| Firebase project id | `mental-smile-platform` |
| Firebase Android app id | `1:420957221495:android:356d24a12835b9723a0c72` |
| Firebase Android package_name | `com.mentalsmile.app` |
| Backup created | `android/app/google-services.json.backup-before-mental-smile-platform-cutover` |

## Files Changed

| File | Change |
| --- | --- |
| `android/app/build.gradle.kts` | Updated `applicationId` to `com.mentalsmile.app`. |
| `android/app/google-services.json.backup-before-mental-smile-platform-cutover` | Created backup evidence copy. |
| `mental-smile-os-workspace/docs/mental-smile-os/infrastructure-cutover/ANDROID_APPLICATION_ID_CUTOVER_REPORT_V1.md` | Created cutover report. |
| `mental-smile-os-workspace/docs/mental-smile-os/infrastructure-cutover/GOOGLE_SERVICES_REPLACEMENT_CARD_V1.md` | Created google-services evidence card. |
| `mental-smile-os-workspace/docs/mental-smile-os/infrastructure-cutover/FIREBASE_ANDROID_APP_LINK_CARD_V1.md` | Created Firebase Android app link card. |
| `mental-smile-os-workspace/docs/mental-smile-os/infrastructure-cutover/ROLLBACK_APPLICATION_ID_CARD_V1.md` | Created rollback card. |

## Validation Commands Needed

Owner/manual validation:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter build apk --debug
```

Optional Firebase verification:

```powershell
firebase use
```

## Validation Status

PENDING_MANUAL_VALIDATION.

## Final Status

ANDROID_APPLICATION_ID_CUTOVER_READY_FOR_VALIDATION
