# Old Infrastructure Evidence Card V1

## Card Identity

Card ID: OLD_INFRASTRUCTURE_EVIDENCE_CARD_V1

Purpose: Preserve current infrastructure identity before cutover.

Status: PRESERVED_AS_EVIDENCE

## Old Values

| Layer | Old Value |
| --- | --- |
| Firebase project | `mental-smile-app-clean` |
| Firebase default alias | `mental-smile-app-clean` |
| Firebase auth domain | `mental-smile-app-clean.firebaseapp.com` |
| Firebase storage bucket | `mental-smile-app-clean.firebasestorage.app` |
| Android applicationId | `com.mentalkey.app.flutterprojects` |
| Firebase Android package | `com.mentalkey.app.flutterprojects` |
| Firebase Android app id | `1:643226562725:android:889e4f18923f415b44dd4c` |
| Current hosting public directory | `public-landing` |

## Why It Existed

This infrastructure hosted the active release-candidate runtime while the project still carried legacy technical identities from the clean app / Mental Key era.

## Why It Must Be Preserved

- It may contain live Firebase resources.
- It may contain Auth users, Firestore data, Storage files, Functions, Hosting history, custom claims, and deployment evidence.
- It may be needed for rollback or historical traceability.

## Forbidden Actions

- Do not delete the old Firebase project.
- Do not delete old hosting evidence.
- Do not delete old `google-services.json` without backup.
- Do not migrate real user data in this step.

## Archive Status

Old infrastructure is archive/evidence material after cutover, not active product identity.
