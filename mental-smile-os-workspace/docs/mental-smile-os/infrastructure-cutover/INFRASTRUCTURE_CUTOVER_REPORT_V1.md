# Infrastructure Cutover Report V1

Result: INFRASTRUCTURE_CUTOVER_READY_FOR_OWNER_ACTION

## Summary

The infrastructure cutover could not be completed locally because the new Firebase project/app/config has not yet been provided in the workspace.

This step created the required cards and safety checkpoint only.

## Files Modified

Documentation files only:

- `INFRA_CUTOVER_SAFETY_CHECKPOINT_V1.md`
- `OLD_INFRASTRUCTURE_EVIDENCE_CARD_V1.md`
- `NEW_INFRASTRUCTURE_TARGET_CARD_V1.md`
- `INFRA_CUTOVER_DECISION_CARD_V1.md`
- `ANDROID_APPLICATION_ID_CARD_V1.md`
- `FIREBASE_PROJECT_CARD_V1.md`
- `FIREBASE_ANDROID_APP_CARD_V1.md`
- `FIREBASE_HOSTING_CARD_V1.md`
- `GOOGLE_SERVICES_CONFIG_CARD_V1.md`
- `ROLLBACK_CARD_V1.md`
- `INFRASTRUCTURE_CUTOVER_REPORT_V1.md`

## Infrastructure Files Modified

None.

## Cards Created

All required cutover cards were created.

## Old Identity Preserved

Old identity is preserved as evidence:

- Firebase project: `mental-smile-app-clean`
- Android applicationId: `com.mentalkey.app.flutterprojects`
- Android Firebase app package: `com.mentalkey.app.flutterprojects`
- Old `google-services.json` remains untouched.

## New Active Identity

Not activated yet.

Target:

- Product: Mental Smile
- Android applicationId: `com.mentalsmile.app`
- Firebase project: `mental-smile-platform`
- Hosting directory: `public-landing`

## Validation Result

Not run.

Reason: no config cutover was performed.

## Remaining Owner Actions

1. Create or confirm Firebase project `mental-smile-platform`.
2. Register Android app `com.mentalsmile.app`.
3. Register web app / hosting for Mental Smile Landing.
4. Download new `android/app/google-services.json`.
5. Confirm whether `lib/firebase_options.dart` should be regenerated.
6. Confirm whether GitHub Actions should target the new Firebase project in the same wave or a later wave.
7. Confirm deploy timing.

## Final Certification Status

INFRASTRUCTURE_CUTOVER_READY_FOR_OWNER_ACTION
