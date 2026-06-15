# FIREBASE_ROLLBACK_PLAN_V1

## Purpose

Define rollback order for Firebase activation changes.

## Rollback Principle

Rollback must restore the last known safe Firebase configuration without deleting historical evidence or production data.

## Rollback Order

1. Stop new deploys.
2. Record deployed version and deployment timestamp.
3. Revert Functions deployment first if Functions caused runtime side effects.
4. Revert Firestore rules to the previous validated ruleset.
5. Revert Storage rules to the previous validated ruleset.
6. Revert indexes only if a newly deployed index causes operational failure.
7. Revert custom claim mutations only for affected test users first.
8. Restore previous claim assignment policy for production users only after Owner confirmation.
9. Preserve all audit logs and deployment records.

## Non-Destructive Rollback Requirements

- Do not delete collections.
- Do not delete Firebase project.
- Do not delete Storage objects.
- Do not remove historical deployment records.
- Do not purge signal collections.

## Validation After Rollback

```powershell
firebase deploy --only firestore:rules --dry-run
firebase deploy --only storage --dry-run
firebase emulators:start --only firestore,storage
```

## Owner Confirmation Required

Any rollback that changes production claims, production rules, or production functions requires Owner approval.

