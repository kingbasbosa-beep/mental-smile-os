# POST_HANDOFF_RISK_REPORT_V1

## Risk Matrix

| Risk | Severity | Evidence | Recommended Action |
|---|---|---|---|
| Live deploy on `ai-lab` push | HIGH | `.github/workflows/firebase-hosting-merge.yml` deploys `channelId: live`. | Owner review before next push/deploy. |
| Untracked Firebase cache | MEDIUM | `.firebase/hosting...cache` is untracked. | Do not commit unless explicitly approved; likely ignore/remove later. |
| Untracked signal-routing doctrine | MEDIUM | `mental-smile-os-runtime/signal-routing/*.md` untracked. | Review and either commit as accepted bootstrap or discard. |
| Storage mixed authority | MEDIUM | Clinician/center storage helpers still use Firestore document fallback. | Review in future authority cleanup. |
| Firestore duplicate helper | LOW | Duplicate `isMonitoringOperator()` in `firestore.rules`. | Cleanup before production rules deployment. |
| Workbench runtime route bundled in activation commit | MEDIUM | `5cea0d1a` adds route/page and large docs. | Confirm route remains approved. |
| Firebase project identity continuity | MEDIUM | `mental-smile-app-clean` remains in `.firebaserc`, `firebase.json`, `firebase_options.dart`. | Owner production-project decision required. |
| Technical identity residue | MEDIUM | Package still `flutterprojects`, Android namespace still `mentalkey`. | Later package identity cleanup. |
| BOM in `firebase.json` | LOW | `git diff` shows BOM before `{`. | Normalize if tooling complains. |

## Activation Recommendation

Do not activate production blindly.

Before activation, review:

1. GitHub Actions live deploy authority.
2. `.firebase/` generated cache status.
3. Untracked signal-routing files.
4. Storage/firestore rules validation.
5. Workbench route exposure.
