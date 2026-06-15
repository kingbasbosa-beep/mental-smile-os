# FIREBASE_WARNING_CLEANUP_WAVE_1_CHANGE_REPORT_V1

## Purpose

Report actual Firebase Warning Cleanup Wave 1 changes and validation status.

## Files Changed

- `firestore.rules`
- `mental-smile-os-workspace/docs/mental-smile-os/firebase-warning-cleanup-wave-1/FIREBASE_WARNING_CLEANUP_WAVE_1_SAFETY_CHECKPOINT_V1.md`
- `mental-smile-os-workspace/docs/mental-smile-os/firebase-warning-cleanup-wave-1/STORAGE_AUTHORITY_FALLBACK_REVIEW_V1.md`
- `mental-smile-os-workspace/docs/mental-smile-os/firebase-warning-cleanup-wave-1/FIREBASE_WARNING_CLEANUP_WAVE_1_DEFERRED_ITEMS_V1.md`

## Firestore Rule Change

Removed one duplicate helper:

```rules
function isMonitoringOperator() {
  return hasRole('monitoring_operator');
}
```

The remaining helper is still present once in `firestore.rules`.

Behavior changed: NO

Duplicate helper result: REMOVED

## Storage Fallback Decision

Storage clinician/center Firestore document fallback remains unchanged.

Decision: DEFER_UNTIL_CLAIMS_AUDIT

Reason: Removing fallback without confirming custom claims could block clinician/center uploads.

## Admin Zero Verification

Admin Zero preserved.

No `admin` or `admins` authority was introduced.

## Owner Authority Verification

Owner authority preserved through custom claim:

```rules
request.auth.token.role == 'owner'
```

## Firebase CLI Validation

`firebase.cmd --version`: PASS

Version:

```text
13.35.1
```

PowerShell `firebase --version` was blocked by local script execution policy. `firebase.cmd` was available.

`firebase deploy --only firestore:rules --dry-run`: OWNER_MANUAL_PENDING

Reason: Owner interrupted and instructed Codex not to run commands.

## Flutter Validation

`flutter analyze`: OWNER_MANUAL_PENDING

`flutter build apk --debug`: OWNER_MANUAL_PENDING

Reason: Owner instructed Codex not to run commands and will run manually.

## Warnings

- Storage clinician/center fallback remains mixed authority.
- Firebase dry-run validation remains pending.
- Flutter analyze/build validation remains pending.

## Rollback Instructions

If needed, restore the removed duplicate `isMonitoringOperator()` helper in the same location before `isClient()`.

Rollback is not expected because behavior was unchanged.

## Boundary Confirmation

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

