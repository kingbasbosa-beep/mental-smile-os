# FIREBASE_WARNING_CLEANUP_WAVE_1_SAFETY_CHECKPOINT_V1

## Purpose

Create a safety checkpoint before Firebase Warning Cleanup Wave 1.

## Allowed Scope

- Inspect `firestore.rules`.
- Remove duplicate `isMonitoringOperator()` helper only if exact duplicate exists.
- Inspect `storage.rules`.
- Report clinician/center Firestore fallback.
- Preserve Admin Zero.
- Preserve Owner custom-claim authority.
- Run validation commands.

## Forbidden Scope

- No Firebase deploy.
- No hosting deploy.
- No Functions deploy.
- No Firestore data changes.
- No Storage data changes.
- No custom claims changes.
- No Firebase project switch.
- No `.firebaserc` edit.
- No `firebase.json` edit.
- No GitHub Actions change.
- No push.
- No commit.
- No deletion.
- No archive movement.
- No Android change.
- No package rename.

## Pre-Change Firestore Finding

`firestore.rules` contains duplicate `isMonitoringOperator()` helper definitions:

```rules
function isMonitoringOperator() {
  return hasRole('monitoring_operator');
}
```

Both definitions are exact behavior duplicates.

## Pre-Change Storage Finding

`storage.rules` contains clinician and center helpers with custom-claim role checks plus Firestore document fallback.

No `admins` collection authority was found in `storage.rules`.

## Safety Status

Checkpoint Status: CREATED

