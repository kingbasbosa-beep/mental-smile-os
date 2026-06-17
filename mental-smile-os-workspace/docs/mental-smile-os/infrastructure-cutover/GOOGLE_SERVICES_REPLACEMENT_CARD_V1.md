# Google Services Replacement Card V1

## Identity

Card ID: GOOGLE_SERVICES_REPLACEMENT_CARD_V1

Component: `android/app/google-services.json`

## Old Expected Value

Project: `mental-smile-app-clean`

Package: `com.mentalkey.app.flutterprojects`

## New Active Value

Project: `mental-smile-platform`

Package: `com.mentalsmile.app`

Firebase Android App ID: `1:420957221495:android:356d24a12835b9723a0c72`

## Purpose

Bind the Android app to the new Mental Smile Firebase Android app identity.

## Files Touched

- `android/app/google-services.json`
- `android/app/google-services.json.backup-before-mental-smile-platform-cutover`

## Rollback Method

Restore the backed-up or prior `google-services.json` that matches the previous Android applicationId.

## Validation Status

PENDING_MANUAL_VALIDATION.

## Owner Decision

Owner supplied or placed a `google-services.json` matching `mental-smile-platform` and `com.mentalsmile.app`.

## Risk Level

HIGH.

Firebase Android config must match `applicationId` exactly.
