# Infrastructure Identity Audit V1

Result: INFRASTRUCTURE_IDENTITY_AUDIT_COMPLETE

Mode: Audit only. No Firebase, applicationId, package ID, deploy, push, or commit changes were made.

## Scope

This audit focuses only on infrastructure identities:

- Firebase project IDs
- Firebase aliases
- `firebase.json`
- `.firebaserc`
- Hosting identities
- Android `applicationId`
- Android namespace
- Repository naming
- GitHub Pages naming
- Legacy URLs
- Deployment identities

## Executive Summary

Mental Smile OS is clean at the visible app label and Android namespace layer, but not yet infrastructure-identity clean.

The active infrastructure still carries legacy project identity through:

- Firebase project ID: `mental-smile-app-clean`
- Firebase alias: default -> `mental-smile-app-clean`
- Firebase web auth domain: `mental-smile-app-clean.firebaseapp.com`
- Firebase storage bucket: `mental-smile-app-clean.firebasestorage.app`
- GitHub Actions deploy project ID: `mental-smile-app-clean`
- GitHub Actions service account secret name: `FIREBASE_SERVICE_ACCOUNT_MENTAL_SMILE_APP_CLEAN`
- Android `applicationId`: `com.mentalkey.app.flutterprojects`
- Current repository path/name: `mental-smile-app-clean2`

These are not cosmetic-only strings. Changing them can affect installed app continuity, Firebase app registration, google-services files, hosting URLs, secrets, CI deploys, and release infrastructure.

## Findings

| Finding | Location | Current Identity | Classification | Risk |
| --- | --- | --- | --- | --- |
| Firebase default project alias | `.firebaserc` | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | HIGH |
| Firebase project config | `firebase.json` | `projectId: mental-smile-app-clean` | OWNER_DECISION_REQUIRED | HIGH |
| FlutterFire Android app | `firebase.json` | Android app id under `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | HIGH |
| FlutterFire Dart config | `firebase.json`, `lib/firebase_options.dart` | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | HIGH |
| Firebase auth domain | `lib/firebase_options.dart` | `mental-smile-app-clean.firebaseapp.com` | OWNER_DECISION_REQUIRED | HIGH |
| Firebase storage bucket | `lib/firebase_options.dart` | `mental-smile-app-clean.firebasestorage.app` | OWNER_DECISION_REQUIRED | HIGH |
| GitHub Actions live deploy | `.github/workflows/firebase-hosting-merge.yml` | projectId `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | HIGH |
| GitHub Actions preview deploy | `.github/workflows/firebase-hosting-pull-request.yml` | projectId `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | HIGH |
| GitHub secret name | workflows | `FIREBASE_SERVICE_ACCOUNT_MENTAL_SMILE_APP_CLEAN` | NON_BLOCKING | MEDIUM |
| Android applicationId | `android/app/build.gradle.kts` | `com.mentalkey.app.flutterprojects` | OWNER_DECISION_REQUIRED | HIGH |
| Android namespace | `android/app/build.gradle.kts` | `com.mentalsmile.os` | NON_BLOCKING | LOW |
| Android visible label | `AndroidManifest.xml` | `Mental Smile` | NON_BLOCKING | LOW |
| Activity name | `AndroidManifest.xml` | `com.mentalsmile.os.MainActivity` | NON_BLOCKING | LOW |
| Repository path/name | workspace path | `mental-smile-app-clean2` | ARCHIVE_ALLOWED | MEDIUM |
| GitHub Pages identity | public links | `kingbasbosa-beep.github.io/mental-smile-os/` | NON_BLOCKING | LOW |
| Public landing official URLs | `public-landing/landing-links.js` | `mentalsmile.org`, `app.mentalsmile.org`, GitHub Pages | OWNER_DECISION_REQUIRED | MEDIUM |

## What Still Carries Legacy Identity?

1. Firebase project and hosting infrastructure: `mental-smile-app-clean`.
2. Android installed app identity: `com.mentalkey.app.flutterprojects`.
3. GitHub Actions Firebase deployment project and secret naming.
4. Host repository/workspace path: `mental-smile-app-clean2`.
5. Some public docs correctly mention these as technical/legacy infrastructure evidence.

## Runtime Impact If Changed

| Identity | Runtime Impact |
| --- | --- |
| Android `applicationId` | Creates a different Android app identity. Existing installed app continuity may break. Firebase Android app config must be regenerated. Google Play identity may be affected if published. |
| Firebase project ID | Runtime backend changes. Auth, Firestore, Storage, Hosting, Functions, indexes, custom claims, and security rules must be recreated or migrated. |
| Firebase hosting URL | Public website/app URL changes. Existing links and GitHub Actions deploy targets must change. |
| Repository name/path | Local tooling, docs, scripts, and source references may break. GitHub remote identity may change. |

## Firebase Impact If Changed

Changing the Firebase project ID is a project migration, not a rename.

Impacted surfaces:

- `.firebaserc`
- `firebase.json`
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- GitHub Actions workflows
- GitHub repository secrets
- Firestore rules deployment target
- Storage rules deployment target
- Hosting deployment target
- Functions deployment target
- Existing Firestore data
- Existing Storage files
- Existing Auth users
- Existing custom claims

## Safe Change Candidates

| Candidate | Classification | Why Safer |
| --- | --- | --- |
| Documentation labels that describe legacy IDs as technical infrastructure | NON_BLOCKING | Already historical/explanatory. |
| Public copy using Mental Smile / Mental Smile OS | NON_BLOCKING | Already aligned. |
| GitHub Pages public link `mental-smile-os` | NON_BLOCKING | Correct OS identity. |
| GitHub secret display name change | OWNER_DECISION_REQUIRED | Safer than project migration, but requires secret recreation and workflow update. |

## Dangerous Change Candidates

| Candidate | Classification | Why Dangerous |
| --- | --- | --- |
| Android `applicationId` | OWNER_DECISION_REQUIRED | Changes Android app identity and Firebase Android app linkage. |
| Firebase project ID | OWNER_DECISION_REQUIRED | Requires full backend/project migration. |
| `lib/firebase_options.dart` project switch | BLOCKING without migration | App points to different backend. |
| `android/app/google-services.json` switch | BLOCKING without matching Firebase app | Android Firebase initialization can break. |
| GitHub Actions projectId switch | BLOCKING without secrets/project setup | CI deploy breaks or deploys to wrong target. |
| Repository rename | OWNER_DECISION_REQUIRED | Docs, remotes, local path references, GitHub Pages settings may need update. |

## Recommended Final Identity Plan

Phase 1: Accept current infrastructure identity for Release Candidate only.

- Keep Firebase project `mental-smile-app-clean` temporarily.
- Keep Android `applicationId` temporarily if Play/Firebase continuity matters.
- Document both as legacy technical infrastructure, not product identity.

Phase 2: Owner decision gate.

Owner must decide:

1. Keep current Firebase project for Generation 1 production, or create a new Firebase project.
2. Keep current Android applicationId for continuity, or migrate to `com.mentalsmile.os`.
3. Keep current repository identity, rename repository, or create a new clean runtime repository.

Phase 3: If migration is approved, execute as a separate infrastructure migration wave.

- Create new Firebase project.
- Register web and Android apps.
- Generate new Firebase options.
- Create new service account secret.
- Update workflows.
- Validate rules and hosting.
- Validate Android build and runtime backend connection.
- Deploy only after Owner confirmation.

## Final Verdict

Infrastructure identity audit is complete.

Strict OS-only infrastructure certification is not ready until Owner decides Firebase and Android applicationId fate.

Result: INFRASTRUCTURE_IDENTITY_AUDIT_COMPLETE
