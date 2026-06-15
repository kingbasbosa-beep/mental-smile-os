# FIREBASE_FINAL_VALIDATION_CHECKLIST_V1

## Checklist

- [ ] Confirm Owner accepts Firebase project `mental-smile-app-clean` or requests migration.
- [ ] Confirm `.firebaserc` target.
- [ ] Confirm `firebase.json` hosting target `build/web`.
- [ ] Remove or accept duplicate `isMonitoringOperator()` helper.
- [ ] Decide Storage clinician/center Firestore fallback.
- [ ] Decide `analytics_summaries` function output policy.
- [ ] Align approved collection names with runtime collections.
- [ ] Confirm deny-all fallback remains in Firestore.
- [ ] Confirm deny-all fallback remains in Storage.
- [ ] Validate Firestore rules syntax.
- [ ] Validate Storage rules syntax.
- [ ] Validate Functions environment requirements.
- [ ] Stop before deploy until Owner confirms.

## Forbidden Without Owner Confirmation

- `firebase deploy`
- production project migration
- collection deletion
- rules deployment
- function deployment
