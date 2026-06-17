# Owner Actions Before Deploy V1

Status: OWNER_ACTION_REQUIRED_BEFORE_DEPLOY

## Required Actions

1. Confirm the `mental-smile-platform` Firebase project exists and is the intended production platform target.
2. Confirm or create the Mental Smile web app inside `mental-smile-platform`.
3. Regenerate FlutterFire configuration for the active runtime:

```powershell
flutterfire configure --project=mental-smile-platform --platforms=android,web
```

4. Verify `lib/firebase_options.dart` no longer points to `mental-smile-app-clean`.
5. Verify `firebase.json` Flutter metadata no longer points to `mental-smile-app-clean`.
6. Update GitHub Actions project id from `mental-smile-app-clean` to `mental-smile-platform`.
7. Create/replace the GitHub Actions Firebase service account secret for Mental Smile Platform.
8. Decide final official public app URL and update the app exit official link if needed.
9. Clear `.firebase/` local cache manually if desired.

## Validation Commands

Run after the above actions:

```powershell
firebase use
firebase hosting:channel:list
firebase serve --only hosting
flutter analyze
flutter build apk --debug
```

## Deploy Command

Only after Owner confirms validation:

```powershell
firebase deploy --only hosting
```

## Current Gate Decision

Deploy is blocked today because active runtime/CI Firebase references still point to the old project.

Result: DO_NOT_DEPLOY_YET
