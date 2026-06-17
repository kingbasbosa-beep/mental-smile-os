# Firebase Identity Impact Report V1

Result: FIREBASE_IDENTITY_IMPACT_REVIEW_COMPLETE

## Current Firebase Identity

| Surface | Current Value | Classification |
| --- | --- | --- |
| `.firebaserc` default project | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED |
| `firebase.json` Flutter Android projectId | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED |
| `firebase.json` Dart projectId | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED |
| `lib/firebase_options.dart` projectId | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED |
| Auth domain | `mental-smile-app-clean.firebaseapp.com` | OWNER_DECISION_REQUIRED |
| Storage bucket | `mental-smile-app-clean.firebasestorage.app` | OWNER_DECISION_REQUIRED |
| Hosting deploy project | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED |
| GitHub Actions service account secret name | `FIREBASE_SERVICE_ACCOUNT_MENTAL_SMILE_APP_CLEAN` | NON_BLOCKING / OWNER_DECISION_REQUIRED |

## Meaning

Firebase remains tied to the historical `mental-smile-app-clean` project identity.

This can be acceptable for Release Candidate continuity if explicitly documented, but it blocks strict infrastructure OS-only certification.

## If Firebase Project Is Changed

Changing Firebase project identity requires creating or switching to a different Firebase project. It is not a simple rename.

Impacted assets:

- Firebase project
- Firestore database
- Storage bucket
- Hosting site
- Functions
- Auth users
- Custom claims
- Rules
- Indexes
- Web app config
- Android app config
- `firebase_options.dart`
- `google-services.json`
- GitHub Actions workflows
- GitHub secrets

## Deployment Risk

| Risk | Severity |
| --- | --- |
| Deploys to wrong Firebase project | CRITICAL |
| App points to empty/new Firestore project | HIGH |
| Auth users missing in new project | HIGH |
| Storage files missing in new bucket | HIGH |
| Service account secret mismatch | HIGH |
| Hosting URL changes unexpectedly | HIGH |
| Rules/indexes not deployed to new project | HIGH |

## Safe Path

For current Release Candidate:

- Keep `mental-smile-app-clean` as active Firebase infrastructure only if Owner accepts it as a technical legacy project.
- Label it in docs as infrastructure identity, not product identity.
- Do not deploy during identity review.

For future strict OS-only:

1. Create/approve target Firebase project, for example `mental-smile-os` if available.
2. Register web app.
3. Register Android app with final applicationId.
4. Regenerate Firebase config.
5. Update secrets.
6. Update workflows.
7. Deploy rules to staging first.
8. Validate runtime.
9. Cut over hosting only after Owner confirmation.

## Recommendation

Firebase project identity should not be changed as part of a normal cleanup patch.

It requires a dedicated Firebase migration wave.

Final Firebase identity status: OWNER_DECISION_REQUIRED.
