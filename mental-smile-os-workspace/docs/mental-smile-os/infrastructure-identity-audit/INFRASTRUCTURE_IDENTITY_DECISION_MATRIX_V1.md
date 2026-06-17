# Infrastructure Identity Decision Matrix V1

Result: INFRASTRUCTURE_IDENTITY_DECISION_MATRIX_CREATED

## Decision Matrix

| Decision Area | Current State | Classification | Safe Now? | Recommended Decision |
| --- | --- | --- | --- | --- |
| Android namespace | `com.mentalsmile.os` | NON_BLOCKING | YES | Keep. |
| Android applicationId | `com.mentalkey.app.flutterprojects` | OWNER_DECISION_REQUIRED | NO | Defer or migrate in dedicated Android/Firebase identity wave. |
| Firebase project ID | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | NO | Keep for RC unless Owner approves full Firebase migration. |
| Firebase hosting URL | legacy clean app hosting identity | OWNER_DECISION_REQUIRED | NO | Use custom domain or new project only after migration plan. |
| Firebase options | tied to `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | NO | Do not edit without Firebase project decision. |
| GitHub Actions projectId | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | NO | Keep until Firebase migration. |
| GitHub Actions secret name | `FIREBASE_SERVICE_ACCOUNT_MENTAL_SMILE_APP_CLEAN` | NON_BLOCKING | YES_WITH_CAUTION | Rename only when secret rotation is planned. |
| GitHub Pages URL | `mental-smile-os` | NON_BLOCKING | YES | Keep. |
| Repository path/name | `mental-smile-app-clean2` | ARCHIVE_ALLOWED | NO | Keep as host path unless repository extraction/rename approved. |
| Public domains | `mentalsmile.org`, `app.mentalsmile.org` | OWNER_DECISION_REQUIRED | NO | Confirm DNS/ownership before making final. |

## Safe Change Candidates

These are safe only as documentation or future planned tasks, not immediate config edits:

1. Add infrastructure identity notes to release docs.
2. Mark `mental-smile-app-clean` as current Firebase infrastructure identity.
3. Mark `com.mentalkey.app.flutterprojects` as deferred continuity applicationId.
4. Keep GitHub Pages `mental-smile-os` as public OS docs identity.

## Dangerous Change Candidates

1. Changing `applicationId`.
2. Changing Firebase project ID.
3. Regenerating `firebase_options.dart`.
4. Replacing `google-services.json`.
5. Changing GitHub Actions deploy target.
6. Renaming repository before link/path audit.
7. Switching public domains without DNS/hosting confirmation.

## Recommended Final Identity Plan

### Release Candidate Plan

Classification: SAFE_WITH_DISCLOSURE

- Product identity: Mental Smile OS.
- Firebase project: keep `mental-smile-app-clean` as technical infrastructure.
- Android applicationId: keep `com.mentalkey.app.flutterprojects` as deferred continuity ID.
- GitHub Pages: keep `mental-smile-os`.
- Custom domains: keep as Owner-confirmed or placeholder until DNS is ready.

### Strict OS-Only Plan

Classification: OWNER_DECISION_REQUIRED

Execute only as a future infrastructure migration:

1. Decide target Firebase project.
2. Decide final Android applicationId.
3. Register new Firebase apps.
4. Rotate GitHub service account secret.
5. Update workflows.
6. Regenerate Firebase options.
7. Validate Android and web builds.
8. Deploy to staging.
9. Owner confirms cutover.

## Final Result

Infrastructure identity audit is complete.

Current release candidate can proceed only if Owner accepts legacy Firebase and applicationId as temporary infrastructure identities.

Strict OS-only infrastructure certification remains blocked until those decisions are made.
