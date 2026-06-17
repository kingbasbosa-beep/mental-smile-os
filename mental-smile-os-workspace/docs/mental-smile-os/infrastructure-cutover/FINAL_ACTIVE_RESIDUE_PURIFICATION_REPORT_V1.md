# Final Active Residue Purification Report V1

Status: FINAL_ACTIVE_LEGACY_RESIDUE_PURIFIED

## Scope

Only active runtime, deploy, and package identity files were changed. Historical docs, archive docs, rollback cards, evidence reports, and old infrastructure records were not edited.

## Files Changed

| File | Change |
| --- | --- |
| `.github/workflows/firebase-hosting-merge.yml` | Firebase Hosting deploy `projectId` changed from `mental-smile-app-clean` to `mental-smile-platform`. |
| `.github/workflows/firebase-hosting-pull-request.yml` | Firebase Hosting preview `projectId` changed from `mental-smile-app-clean` to `mental-smile-platform`. |
| `lib/features/app_exit/presentation/pages/app_exit_social_links_page.dart` | Official Website link changed from `https://mental-smile-app-clean.web.app` to `https://mental-smile-platform.web.app`. |
| `lib/firebase_options.dart` | Remaining old Firebase project/domain/bucket text replaced with `mental-smile-platform` values. Existing generated `apiKey` and `appId` values were preserved. |
| `package-lock.json` | Package lock root name changed from `mental-smile-app-clean2` to `mental-smile-platform`. |
| `lib/features/sovereign_construction/domain/construction_tool_registry.dart` | Hardcoded local paths containing `mental-smile-app-clean2` were replaced with relative active workspace/source paths. |

## Old Values Removed From Active Scope

- `mental-smile-app-clean`
- `https://mental-smile-app-clean.web.app`
- `mental-smile-app-clean2` from active local workspace path references

## Preserved Generated Values

`lib/firebase_options.dart` already contained Mental Smile Platform values for web and Android. The remaining old values were in the Windows Firebase options block. Only the project id, auth domain, and storage bucket text were corrected. No `apiKey` or `appId` was guessed or replaced.

## Remaining Old References

Any remaining `mental-smile-app-clean` references should be treated as one of:

- historical documentation
- rollback evidence
- archive cards
- previous cutover reports
- generated/local cache if present

They are outside this active purification scope unless a later active scan proves otherwise.

## Validation Commands

Run manually:

```powershell
flutter pub get
flutter analyze
flutter build apk --debug
flutter build web
firebase use
firebase serve --only hosting
```

## Deployment Note

GitHub Actions still use the existing Firebase service account secret name. The project id now targets `mental-smile-platform`, so the secret value must correspond to the new Firebase project before CI deploy is trusted.

Result: FINAL_ACTIVE_LEGACY_RESIDUE_PURIFIED
