# FIREBASE_WARNING_CLEANUP_WAVE_1_ROLLBACK_NOTES_V1

## Purpose

Document rollback for Firebase Warning Cleanup Wave 1.

## Rollback Scope

Rollback covers only the Firestore duplicate helper removal.

Storage rules were reviewed but not changed.

## Rollback Steps

1. Open `firestore.rules`.
2. Re-add the removed duplicate helper before `isClient()` only if Owner requests exact pre-wave restoration:

```rules
function isMonitoringOperator() {
  return hasRole('monitoring_operator');
}
```

3. Run owner-side validation:

```powershell
firebase.cmd deploy --only firestore:rules --dry-run
flutter analyze
flutter build apk --debug
```

## Preferred Decision

Do not roll back unless a parser or validation tool unexpectedly depends on the duplicate definition.

The duplicate helper removal is behavior-preserving.

## Rollback Safety Rules

- Do not deploy.
- Do not edit `.firebaserc`.
- Do not edit `firebase.json`.
- Do not change custom claims.
- Do not edit Storage fallback during rollback.
- Do not push.
- Do not commit.

