# Infrastructure Cutover Safety Checkpoint V1

Result: INFRASTRUCTURE_CUTOVER_READY_FOR_OWNER_ACTION

Mode: Safety checkpoint only. No Firebase config, Android applicationId, package ID, deploy, push, commit, or data migration was performed.

## Current Git State

| Item | Value |
| --- | --- |
| Current branch | `ai-lab` |
| Git status | Dirty working tree with existing modified/untracked files |
| Commit performed | NO |
| Push performed | NO |
| Deploy performed | NO |

## Current Infrastructure Identity

| Infrastructure Layer | Current Value |
| --- | --- |
| Firebase project id | `mental-smile-app-clean` |
| Firebase alias | `default -> mental-smile-app-clean` |
| Firebase hosting public directory | `public-landing` |
| Android namespace | `com.mentalsmile.os` |
| Android applicationId | `com.mentalkey.app.flutterprojects` |
| Android Firebase app id | `1:643226562725:android:889e4f18923f415b44dd4c` |
| Android Firebase package name | `com.mentalkey.app.flutterprojects` |
| google-services path | `android/app/google-services.json` |
| Firebase config files | `.firebaserc`, `firebase.json`, `lib/firebase_options.dart`, `android/app/google-services.json` |
| Current Firebase hosting project | `mental-smile-app-clean` |

## Current File Evidence

| File | Evidence |
| --- | --- |
| `.firebaserc` | default project: `mental-smile-app-clean` |
| `firebase.json` | hosting public directory: `public-landing`; FlutterFire project: `mental-smile-app-clean` |
| `android/app/build.gradle.kts` | namespace: `com.mentalsmile.os`; applicationId: `com.mentalkey.app.flutterprojects` |
| `android/app/google-services.json` | project id: `mental-smile-app-clean`; package name: `com.mentalkey.app.flutterprojects` |

## Target Identity

| Layer | Target |
| --- | --- |
| Product name | Mental Smile |
| Android applicationId | `com.mentalsmile.app` |
| Firebase project | `mental-smile-platform` or nearest Owner-approved available ID |
| Firebase Android app | `com.mentalsmile.app` |
| Firebase Hosting | Mental Smile Landing |
| Hosting public directory | `public-landing` |

## Safety Decision

Local cutover is blocked until Owner provides the new Firebase project/app/config evidence.

Required Owner manual action:

1. Create or confirm Firebase project `mental-smile-platform`.
2. Create Android app `com.mentalsmile.app`.
3. Create web app / hosting target for Mental Smile Landing.
4. Download new `android/app/google-services.json`.
5. Confirm whether `lib/firebase_options.dart` should be regenerated during the same cutover wave.

## Stop Condition

No local infrastructure files were modified in this checkpoint.
