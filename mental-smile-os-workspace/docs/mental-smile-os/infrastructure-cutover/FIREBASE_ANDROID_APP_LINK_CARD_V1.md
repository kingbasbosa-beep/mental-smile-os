# Firebase Android App Link Card V1

## Identity

Card ID: FIREBASE_ANDROID_APP_LINK_CARD_V1

Component: Firebase Android app linkage.

## Old Link

| Field | Old Value |
| --- | --- |
| Firebase project | `mental-smile-app-clean` |
| Android package | `com.mentalkey.app.flutterprojects` |
| Android app id | `1:643226562725:android:889e4f18923f415b44dd4c` |

## New Link

| Field | New Value |
| --- | --- |
| Firebase project | `mental-smile-platform` |
| Android package | `com.mentalsmile.app` |
| Android app id | `1:420957221495:android:356d24a12835b9723a0c72` |

## Purpose

Connect the Android runtime identity to the clean Mental Smile Firebase project before real provider onboarding.

## Files Touched

- `android/app/build.gradle.kts`
- `android/app/google-services.json`

## Rollback Method

Restore old applicationId and matching old Firebase Android app config.

## Validation Status

PENDING_MANUAL_VALIDATION.

## Risk Level

HIGH.

The app must be built and launched to confirm Firebase initialization works with the new package identity.
