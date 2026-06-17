# Firebase Project Switch Card V1

## Identity

Card ID: FIREBASE_PROJECT_SWITCH_CARD_V1

Component: Firebase CLI default project.

## Old Value

`mental-smile-app-clean`

## New Value

`mental-smile-platform`

## Purpose

Switch Firebase CLI operations from the old clean-app infrastructure project to the new Mental Smile Platform project.

## Files Touched

- `.firebaserc`

## Files Not Touched

- `firebase.json`
- `firestore.rules`
- `storage.rules`
- Android applicationId files

## Rollback Method

Restore `.firebaserc` default project to:

```json
"default": "mental-smile-app-clean"
```

## Validation Status

PENDING_MANUAL_VALIDATION.

## Owner Decision

Required before deploy.

## Risk Level

HIGH.

Firebase CLI commands now target `mental-smile-platform` by default.
