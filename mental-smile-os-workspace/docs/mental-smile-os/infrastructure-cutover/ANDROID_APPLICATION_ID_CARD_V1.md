# Android Application ID Card V1

## Identity

Card ID: ANDROID_APPLICATION_ID_CARD_V1

Component: Android applicationId

## Old Value

`com.mentalkey.app.flutterprojects`

## New Target Value

`com.mentalsmile.app`

## Purpose

Move installed Android app identity from legacy Mental Key / Flutter template identity to clean Mental Smile app identity.

## Files To Touch During Cutover

- `android/app/build.gradle.kts`
- `android/app/google-services.json`
- potentially `lib/firebase_options.dart`
- possibly Firebase console Android app registration

## Rollback Method

Restore:

- old `applicationId`
- old `google-services.json`
- old Firebase options, if changed
- old Firebase project selection

## Validation Status

PENDING_OWNER_ACTION.

## Owner Decision

Required before any edit.

## Risk Level

HIGH.

Changing `applicationId` changes Android installed app identity and Firebase Android app linkage.
