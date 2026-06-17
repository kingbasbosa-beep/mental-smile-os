# FIREBASE_ACTIVATION_SEQUENCE_V2

## Purpose

Define the next safe Firebase activation sequence.

## Sequence

1. Confirm Owner accepts current Firebase project `mental-smile-app-clean` as the active Generation 1 project or requests project migration.
2. Create or restore a dedicated approved collection registry file for Generation 1.
3. Align conceptual collection families with actual runtime collections.
4. Remove duplicate `isMonitoringOperator()` helper from Firestore rules.
5. Decide whether Storage clinician/center Firestore fallback should remain or become claim-only.
6. Decide whether `analytics_summaries` needs client read rules, archive-only handling, or server-only retention.
7. Validate Firestore rules syntax.
8. Validate Storage rules syntax.
9. Validate indexes.
10. Validate Functions configuration and required environment variables.
11. Run Firebase emulator checks where configured.
12. Prepare deploy plan.
13. Stop for Owner confirmation before deployment.

## Required Commands For Later Execution

```powershell
firebase emulators:start --only firestore,storage
firebase deploy --only firestore:rules --dry-run
firebase deploy --only storage --dry-run
firebase deploy --only firestore:indexes --dry-run
firebase deploy --only functions --dry-run
firebase deploy --only hosting --dry-run
```

## Boundary

This sequence is a plan only. No deployment was performed.
