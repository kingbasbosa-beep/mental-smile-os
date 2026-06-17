# Firebase Android App Card V1

## Identity

Card ID: FIREBASE_ANDROID_APP_CARD_V1

Component: Firebase Android App

## Old Value

Package: `com.mentalkey.app.flutterprojects`

App ID: `1:643226562725:android:889e4f18923f415b44dd4c`

Project: `mental-smile-app-clean`

## New Target Value

Package: `com.mentalsmile.app`

Project: `mental-smile-platform` or Owner-approved equivalent.

## Purpose

Register Android runtime against the clean Mental Smile Firebase infrastructure.

## Files Touched During Cutover

- `android/app/google-services.json`
- `firebase.json`
- `lib/firebase_options.dart` if FlutterFire is regenerated

## Rollback Method

Restore old Firebase Android app config and old applicationId.

## Validation Status

PENDING_OWNER_ACTION.

## Owner Decision

Required.

## Risk Level

HIGH.
