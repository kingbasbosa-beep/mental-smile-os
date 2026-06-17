# Final Infrastructure Cutover Cleanup Report V1

Status: FINAL_INFRASTRUCTURE_CUTOVER_BLOCKED

## Target Active Identity

| Area | Target | Current Reality | Status |
| --- | --- | --- | --- |
| Product | Mental Smile | Mental Smile | PASS |
| OS / Docs | Mental Smile OS | Mental Smile OS | PASS |
| Firebase default project | mental-smile-platform | `.firebaserc` default is `mental-smile-platform` | PASS |
| Android applicationId | com.mentalsmile.app | `android/app/build.gradle.kts` uses `com.mentalsmile.app` | PASS |
| Android namespace | com.mentalsmile.os | Preserved as `com.mentalsmile.os` | PASS |
| Android Firebase config | mental-smile-platform / com.mentalsmile.app | `android/app/google-services.json` matches target | PASS |
| Hosting public directory | public-landing | `firebase.json` hosting public is `public-landing` | PASS |

## Cleanup Attempt

`.firebase/` was identified as local Firebase hosting cache and is a disposable generated deploy residue. Deletion was attempted, but Windows denied removal of the cache files. No escalation or destructive workaround was used.

Result: DELETE_CANDIDATE remains pending manual cleanup.

## Active Blockers Before Deploy

| Finding | Location | Classification | Reason |
| --- | --- | --- | --- |
| Old FlutterFire project id | `firebase.json` | ACTIVE_BLOCKER | FlutterFire metadata still points to `mental-smile-app-clean`. |
| Old Firebase runtime options | `lib/firebase_options.dart` | ACTIVE_BLOCKER | Runtime Firebase options still target `mental-smile-app-clean`. |
| Old GitHub Actions deploy project | `.github/workflows/firebase-hosting-merge.yml` | ACTIVE_BLOCKER | Merge deploy still targets `mental-smile-app-clean`. |
| Old GitHub Actions PR project | `.github/workflows/firebase-hosting-pull-request.yml` | ACTIVE_BLOCKER | PR preview deploy still targets `mental-smile-app-clean`. |
| Old service account secret name | GitHub Actions workflows | OWNER_DECISION_REQUIRED | New platform project needs confirmed service account secret. |
| Old public app link | `lib/features/app_exit/presentation/pages/app_exit_social_links_page.dart` | OWNER_DECISION_REQUIRED | Link points to old `mental-smile-app-clean.web.app` hosting URL. |

## Historical References Allowed

Infrastructure cutover cards and rollback records intentionally preserve old values such as `mental-smile-app-clean` and `com.mentalkey.app.flutterprojects` as rollback evidence. These are not active blockers when clearly used as historical evidence.

## Validation Status

No deploy was run.
No Firebase project was changed through CLI.
No Firebase rules were edited.
No app code was changed in this step.

Manual validation remains pending after Owner resolves the active blockers:

```powershell
firebase use
firebase hosting:channel:list
firebase serve --only hosting
flutter analyze
flutter build apk --debug
```

## Deploy Gate

Do not run:

```powershell
firebase deploy --only hosting
```

until `firebase.json`, `lib/firebase_options.dart`, and GitHub Actions deploy project/secret configuration are aligned with `mental-smile-platform`.

Final result: FINAL_INFRASTRUCTURE_CUTOVER_BLOCKED
