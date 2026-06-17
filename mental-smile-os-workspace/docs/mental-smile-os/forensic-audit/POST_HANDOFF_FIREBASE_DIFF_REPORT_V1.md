# POST_HANDOFF_FIREBASE_DIFF_REPORT_V1

## Firebase Files Changed

| File | Change | Classification | Risk |
|---|---|---|---|
| `.firebaserc` | Newline normalization only; default project remains `mental-smile-app-clean`. | ACCEPTABLE | LOW |
| `firebase.json` | Re-formatted from one-line JSON, added Hosting config, final public directory is `build/web`. | ACCEPTABLE_WITH_WARNING | MEDIUM |
| `firebase.json.backup-before-hosting` | Added backup of pre-hosting config. | ACCEPTABLE | LOW |
| `.github/workflows/firebase-hosting-merge.yml` | Added live Firebase Hosting deploy on push to `ai-lab`. | ACCEPTABLE_WITH_WARNING | HIGH |
| `.github/workflows/firebase-hosting-pull-request.yml` | Added Firebase Hosting PR preview. | ACCEPTABLE | MEDIUM |
| `storage.rules` | Replaced `isAdmin()` with `isOwnerAuthority()`. Removed `admins` collection fallback. | EXPECTED | LOW |
| `.firebase/hosting...cache` | Generated untracked hosting cache. | UNPLANNED | MEDIUM |

## Firestore Rules

`firestore.rules` did not change in the inspected post-handoff diff.

Observed existing warning:

- Duplicate `isMonitoringOperator()` helper remains.
- Authority is custom-claim based for owner, monitoring operator, registry steward, declaration reviewer, support observer, client, clinician, and center.
- No active `admin` Firestore authority found.

## Storage Rules Authority Result

Admin authority removal succeeded:

- `isAdmin()` removed.
- `role == 'admin'` removed.
- `admins/{uid}` Firestore fallback removed.
- Public asset writes now require `request.auth.token.role == 'owner'`.

Remaining warning:

- `isClinician()` and `isCenter()` in `storage.rules` still allow Firestore document fallback. This is not admin resurrection, but it is mixed authority.

## Functions

No post-handoff function change was found.

Existing technical metadata:

- `functions/index.js` uses `firebase-admin` SDK.
- `analytics_summaries` is written by Cloud Functions.

This is not legacy admin authority; it is server SDK technical authority.
