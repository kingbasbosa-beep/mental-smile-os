# Hosting Target Cleanup Report V1

Status: HOSTING_TARGET_PARTIAL

## Hosting Configuration

| Check | Result | Notes |
| --- | --- | --- |
| `.firebaserc` default project | PASS | Default project is `mental-smile-platform`. |
| `firebase.json` hosting public | PASS | Hosting public directory remains `public-landing`. |
| Hosting deploy path | PASS | No source runtime directory is configured as hosting public. |
| GitHub Actions merge deploy project | FAIL | Still points to `mental-smile-app-clean`. |
| GitHub Actions PR deploy project | FAIL | Still points to `mental-smile-app-clean`. |
| GitHub Actions service account secret | OWNER_DECISION_REQUIRED | Existing secret name references old Firebase project identity. |

## Firebase Hosting Site Name

The local files confirm the Firebase CLI project target, but they do not prove the remote hosting site name. Owner must verify in Firebase Console or by CLI:

```powershell
firebase hosting:sites:list
```

Do not delete or rename any Firebase Hosting site without Owner confirmation.

## Required Owner Action

1. Confirm whether `mental-smile-platform` has the desired Hosting site.
2. If a new hosting site is needed, create it in Firebase Console or CLI.
3. Update GitHub Actions to deploy to `mental-smile-platform`.
4. Create or rotate a GitHub Actions service account secret for the new project.

## Deployment Gate

Hosting deploy is blocked until CI and runtime Firebase config stop pointing at `mental-smile-app-clean`.

Result: HOSTING_TARGET_CLEANUP_REQUIRES_OWNER_ACTION
