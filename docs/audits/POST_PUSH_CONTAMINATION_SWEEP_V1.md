# Post-Push Contamination Sweep V1

Operation ID: OP-POST-PUSH-CONTAMINATION-SWEEP-V1
Operation Date: 2026-06-18
Execution Mode: AUDIT ONLY
Runtime Effect: none
Firebase Effect: none
Git Effect: none

## Executive Summary

This sweep checked remaining contamination after client legacy extraction and accessibility gateway work. The removed client legacy route/page tokens were not found in active `lib` or `test` code:

- `register/client`
- `client/dashboard`
- `ClientRegisterPage`
- `ClientDashboardPage`
- `Routes.clientRegister`
- `Routes.clientDashboard`

The repository is not blocked by active removed-route contamination. However, warnings remain in three areas:

1. Bundled legacy client dashboard/register assets remain in `pubspec.yaml`.
2. Runtime contact/save surfaces still depend on signed-in `clientId` and `saved_destinations`.
3. Firebase/GitHub deployment configuration needs Owner verification before any Firebase sweep because CLI verification could not run under the local PowerShell policy and GitHub Hosting workflows are present.

Final Verdict: CONTAMINATION_WARNINGS_FOUND

## Scope

Audited:

- `pubspec.yaml`
- `analysis_options.yaml`
- `l10n.yaml`
- `firebase.json`
- `.firebaserc`
- `storage.rules`
- `firestore.rules`
- `firestore.indexes.json`
- `lib/firebase_options.dart`
- `android/**` configuration references
- `lib/**`
- `test/**`
- `assets/**`
- `public-landing/**`
- `.github/workflows/**`
- git status and staged-file status

No runtime code was modified. No Firebase deploy was attempted. No cleanup was performed.

## Contamination Findings

| ID | Classification | Surface | Exact Files | Evidence | Recommended Next Action |
| --- | --- | --- | --- | --- | --- |
| PPCS-001 | WARNING | Bundled legacy client assets | `pubspec.yaml` lines 64-67, 72, 83 | `assets/branding/client_dashboard/**`, `assets/branding/web_registration/clients/mobile/client_register.png`, and `assets/images/client_dashboard/actions/` remain bundled. | Owner-approved asset unbundle/archive sweep after manual build verification. |
| PPCS-002 | FUTURE_CLEANUP | On-disk C5/C6 assets | `assets/c5/**`, `assets/c6_library/**` | C5/C6 files remain on disk, but no `pubspec.yaml` bundle entry for `assets/c5/**` or `assets/c6_library/**` was found. | Separate asset archive audit if repository size or release package purity becomes a priority. |
| PPCS-003 | OWNER_DECISION | Reused client-dashboard background assets | `lib/features/centers/presentation/pages/center_room_page.dart`, `lib/features/centers/presentation/pages/center_dashboard_page.dart`, `lib/features/clinician/presentation/pages/clinician_room_page.dart` | Provider/center/clinician rooms still reference `assets/branding/client_dashboard/*/client_dashboard_*_bg.png`. | Decide whether these backgrounds are shared neutral assets or should be renamed/rebundled. |
| PPCS-004 | WARNING | Signed-in client/contact assumptions | `firestore.rules`; `lib/features/contact_requests/**`; `lib/features/saved_destinations/**`; `lib/features/centers/presentation/pages/center_details_page.dart`; `lib/features/specialists/presentation/specialist_details_page.dart` | `provider_contact_requests`, `center_contact_requests`, and `saved_destinations` still use `clientId` and signed-in UID assumptions. | Focused Firebase/data-model audit before anonymous/session contact is claimed complete. |
| PPCS-005 | WARNING | Client collection/profile rules remain | `firestore.rules` lines 44-45, 92, 314-318; `storage.rules` line 68; `lib/core/auth/account_access_service.dart` | Client role and `/clients/{clientId}` rules remain, even though old client registration/dashboard runtime was removed. | Owner decision: preserve for historical accounts/personal space, or plan a governed data extraction. |
| PPCS-006 | OWNER_DECISION | Firebase CLI verification blocked locally | Local Firebase CLI invocation | `firebase use` and `firebase apps:list` were blocked by PowerShell script execution policy before credentials were evaluated. | Owner runs read-only Firebase CLI checks manually or approves an alternate shell invocation. |
| PPCS-007 | WARNING | Firebase app configuration drift candidate | `firebase.json`; `.firebaserc`; `lib/firebase_options.dart` | `firebase.json` and active web/android options use the `420957221495` app set. `lib/firebase_options.dart` also contains an additional web option using a different sender/app id for another platform branch. | Owner verifies whether the extra web option is intentional or stale before Firebase sweep. |
| PPCS-008 | WARNING | GitHub Hosting workflows present | `.github/workflows/firebase-hosting-merge.yml`; `.github/workflows/firebase-hosting-pull-request.yml` | Merge workflow deploys live Hosting on push to `ai-lab`; PR workflow deploys preview. `.github/` is currently untracked. | Owner decides whether workflows should be committed, held, or disabled before future pushes. |
| PPCS-009 | DOC_HISTORY | Historical docs still describe removed state | `docs/audits/**`; `docs/constitutional-baseline/**` | Older reports and inventories still mention `/register/client`, `/client/dashboard`, `ClientRegisterPage`, and `ClientDashboardPage` as active because they preserve pre-removal truth. | No cleanup unless Owner requests historical-doc refresh. |
| PPCS-010 | SAFE_ARCHIVE | Removed route/page residue in active code | `lib/**`; `test/**` | No active matches found for removed route/page tokens in `lib` or `test`. | No action. Keep Phase 15 residue record as closure evidence. |
| PPCS-011 | WARNING | Git status not fully committed clean | Git status | Working tree shows modified operations registry/index and untracked `.github/`. No staged files were found. | Owner reviews `.github/` and registry updates before any future commit/push. |
| PPCS-012 | SAFE_ARCHIVE | Secrets/build artifacts scan | Repository file listing | No matching `.apk`, `.aab`, `.keystore`, `.jks`, `.env`, service account JSON, `GoogleService-Info.plist`, or `google-services.json` file was reported by the targeted listing command. | Continue pre-push secret/build-artifact checks before commits. |

## YAML / Pubspec

`analysis_options.yaml` and `l10n.yaml` showed no removed route/page contamination.

`pubspec.yaml` still bundles legacy client asset paths:

- `assets/branding/client_dashboard/`
- `assets/branding/client_dashboard/desktop/`
- `assets/branding/client_dashboard/tablet/`
- `assets/branding/client_dashboard/mobile/`
- `assets/branding/web_registration/clients/mobile/client_register.png`
- `assets/images/client_dashboard/actions/`

The C5/C6 asset directories remain on disk, but they are not directly listed as active asset bundles in `pubspec.yaml`.

## Firebase

`.firebaserc` points to the `mental-smile-platform` default project.

`firebase.json` configures:

- functions source: `functions`
- Firestore rules/indexes
- Storage rules
- Hosting public directory: `public-landing`
- Flutter web/android app configuration for `mental-smile-platform`

`lib/firebase_options.dart` contains active `mental-smile-platform` options for web and android, plus another web options branch with a different app/sender id. This is a configuration drift candidate requiring Owner verification before a Firebase sweep.

Read-only Firebase CLI checks were attempted:

- `firebase use`
- `firebase apps:list`

Both were blocked locally by PowerShell script execution policy before credentials could be evaluated. No Firebase deploy was attempted.

## Runtime Residue

No active `lib` or `test` matches were found for:

- `register/client`
- `client/dashboard`
- `ClientRegisterPage`
- `ClientDashboardPage`
- `Routes.clientRegister`
- `Routes.clientDashboard`

Runtime residue remains around account-bound client concepts:

- `saved_destinations`
- `provider_contact_requests`
- `center_contact_requests`
- `support_requests`
- `chat_threads`
- `clients`

These are not evidence that the old client register/dashboard runtime returned. They are evidence that Firebase/data-model cleanup needs a separate governed operation before Mental Smile claims fully anonymous/session-based client contact and saved-destination behavior.

## Assets / Images

Active asset warnings:

- Client dashboard backgrounds remain bundled.
- Client registration mobile image remains bundled.
- Client dashboard action images remain bundled.

On-disk archive/future cleanup:

- C5 assets remain under `assets/c5/**`.
- C6 library assets remain under `assets/c6_library/**`.

The C5/C6 directories appear to be archive/future-cleanup candidates rather than currently bundled Flutter assets.

## Users / Roles / Identity

Provider, center, owner, monitoring, declaration reviewer, registry steward, and support observer identity surfaces remain active and should not be treated as client legacy contamination.

Client identity assumptions remain in Firestore and app-side data models:

- `isClient()`
- `/clients/{clientId}`
- `saved_destinations.clientId`
- `provider_contact_requests.clientId`
- `center_contact_requests.clientId`

This is an Owner decision surface, not a post-removal blocker. Historical accounts, personal space, support/chat, and saved destination continuity may still depend on these structures.

## Git Status

Observed status during sweep:

- Modified:
  - `docs/constitutional-baseline/operations/EXECUTED_OPERATIONS_INDEX_V1.md`
  - `docs/constitutional-baseline/operations/EXECUTED_OPERATIONS_REGISTRY_V1.md`
- Untracked:
  - `.github/`
- Staged files:
  - none

No commit, push, tag, or Firebase action was performed.

## Recommended Next Action

Do not clean automatically. Recommended focused next audits:

1. Firebase configuration and app-id drift audit.
2. Client data-model/session-contact audit.
3. Asset bundle purity audit for legacy client/dashboard/register assets.
4. GitHub workflow governance decision before the next push.

## Registry Updates

- Operations Registry: updated.
- Operations Index: updated.
- Memory Registry: updated.
- Finding Registry: updated.
- Archive Registry: not applicable; no archive/removal action was performed.

## Final Verdict

CONTAMINATION_WARNINGS_FOUND
