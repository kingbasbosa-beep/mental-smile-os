# Rollback Firebase Hosting Card V1

## Identity

Card ID: ROLLBACK_FIREBASE_HOSTING_CARD_V1

Purpose: Define rollback for Firebase hosting project switch.

## Current Value

`mental-smile-platform`

## Previous Value

`mental-smile-app-clean`

## Rollback File

`.firebaserc`

## Rollback Method

Restore:

```json
{
  "projects": {
    "default": "mental-smile-app-clean"
  }
}
```

## Validation After Rollback

```powershell
firebase use
```

## Rollback Scope

Rollback only changes Firebase CLI target.

It does not change:

- Firestore rules
- Storage rules
- Android applicationId
- `firebase.json`
- public landing content

## Status

PREPARED_NOT_USED.
