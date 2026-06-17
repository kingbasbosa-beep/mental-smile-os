# Firebase Project Card V1

## Identity

Card ID: FIREBASE_PROJECT_CARD_V1

Component: Firebase Project

## Old Value

`mental-smile-app-clean`

## New Target Value

`mental-smile-platform` or nearest available Owner-approved Firebase project ID.

## Purpose

Create a clean Firebase infrastructure identity for Mental Smile before real provider onboarding begins.

## Files To Touch During Cutover

- `.firebaserc`
- `firebase.json`
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `.github/workflows/firebase-hosting-merge.yml` if deployment target changes later
- `.github/workflows/firebase-hosting-pull-request.yml` if deployment target changes later

## Rollback Method

Restore:

- `.firebaserc`
- `firebase.json`
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- GitHub Actions project ID/secret references if changed

## Validation Status

PENDING_OWNER_ACTION.

## Owner Decision

Required.

## Risk Level

CRITICAL.

Firebase project migration affects Auth, Firestore, Storage, Hosting, Functions, rules, indexes, service accounts, and deployment targets.
