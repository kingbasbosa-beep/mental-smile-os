# Active Infrastructure Identity Card V1

Status: ACTIVE_IDENTITY_PARTIALLY_APPLIED

## Active Identity

| Component | Active Value | Verification |
| --- | --- | --- |
| Product name | Mental Smile | Public product identity |
| OS / documentation name | Mental Smile OS | Documentation identity |
| Firebase project target | mental-smile-platform | `.firebaserc` default project |
| Android applicationId | com.mentalsmile.app | `android/app/build.gradle.kts` |
| Android namespace | com.mentalsmile.os | `android/app/build.gradle.kts` |
| Android Firebase app package | com.mentalsmile.app | `android/app/google-services.json` |
| Hosting public directory | public-landing | `firebase.json` |

## Active Identity Health

The Android application identity and Firebase CLI default project are aligned with Mental Smile Platform.

The runtime Firebase options and CI deploy configuration are not fully aligned yet.

## Required Completion

1. Regenerate or replace FlutterFire runtime options for `mental-smile-platform`.
2. Align `firebase.json` Flutter metadata with the new Firebase app ids.
3. Replace old GitHub Actions project id and service account secret with the Mental Smile Platform deployment identity.
4. Confirm final public hosting URL before replacing old app links.

## Certification

Active infrastructure identity is not yet deploy-certified.

Result: ACTIVE_IDENTITY_REQUIRES_FINAL_ALIGNMENT
