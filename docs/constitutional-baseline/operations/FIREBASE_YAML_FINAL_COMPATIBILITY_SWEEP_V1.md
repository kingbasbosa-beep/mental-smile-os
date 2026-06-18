# Firebase YAML Final Compatibility Sweep V1

Operation ID: OP-FIREBASE-YAML-FINAL-COMPATIBILITY-SWEEP-V1
Date: 2026-06-18
Execution Mode: AUDIT ONLY
Runtime Effect: none
Firebase Effect: none
Git Effect: none

## 1. Executive Summary

This sweep audited Firebase, YAML, rules, generated Firebase options, Android Firebase config references, and held GitHub workflows against the current Mental Smile doctrine after client identity hard removal and Ghost Packages A/B/C.

Final verdict:

`FIREBASE_YAML_WARNINGS_FOUND`

No blocker was found.

Warnings and Owner decisions remain around:

- Firebase Hosting target `public-landing`.
- Held GitHub Firebase Hosting workflows.
- `saved_destinations` and `destination_saved` Owner-decision lifecycle.
- `signal_aggregates` lifecycle.
- Windows Firebase options mismatch/unclear platform intent.
- Android backup Firebase config file retained beside active `google-services.json`.

## 2. Doctrine Compatibility Matrix

| Doctrine Check | Status | Evidence |
| --- | --- | --- |
| No client account identity | COMPATIBLE | Targeted config/rules/YAML search found no `clients`, `isClient`, `clientCreateValid`, `clientUpdateValid`, `/register/client`, `/client/dashboard`, or client dashboard/register asset refs. |
| Session-first client access | COMPATIBLE / OWNER_DECISION | `signal_events`, `provider_contact_requests`, `center_contact_requests`, and `saved_destinations` allow session/visitor style inputs; `saved_destinations` remains Owner-decision. |
| Provider/center identity preserved | COMPATIBLE | Firestore rules retain `clinicians`, `centers`, profile change requests, provider/center contact requests; Storage rules retain clinician/center upload spaces. |
| Owner/monitoring/registry/declaration/support roles preserved | COMPATIBLE | Firestore rules retain `owner`, `monitoring_operator`, `registry_steward`, `declaration_reviewer`, and `support_observer`. |
| No booking/payment/session lifecycle core | COMPATIBLE | Targeted config/rules/YAML search found no `booking_requests`, payment, or session lifecycle core references. |
| Accessibility gateway active | COMPATIBLE | Config/rules do not block accessibility runtime; active accessibility runtime is not Firebase-CMS dependent. |
| Ghost assets/signals/routes removed | COMPATIBLE | Targeted config/rules/YAML search found no removed ghost signal names, ghost route paths, or removed ghost asset paths. |

## 3. File-by-File Findings

| File / Surface | Classification | Finding |
| --- | --- | --- |
| `pubspec.yaml` | COMPATIBLE | No removed ghost asset folders are bundled. Active provider/center/web/library/menu/splash/login/C7/image assets remain bundled. |
| `l10n.yaml` | COMPATIBLE | Points to `lib/l10n`, `app_ar.arb`, and `app_localizations.dart`; no ghost route/asset/signal config issue. Localization residue exists in ARB/generated files but is outside `l10n.yaml` itself and already Owner-decision. |
| `analysis_options.yaml` | COMPATIBLE | Standard Flutter lints and exclusions; no doctrine conflict found. |
| `firebase.json` | OWNER_DECISION | Project config is valid, but Hosting still points to `public-landing`; Owner must decide static landing vs Flutter web output before deploy. |
| `.firebaserc` | COMPATIBLE | Default project is `mental-smile-platform`. |
| `firestore.rules` | WARNING / OWNER_DECISION | No client identity rule block remains; provider/center/owner/monitoring/registry/declaration/support roles preserved. `saved_destinations` and `signal_aggregates` remain active rules with Owner-decision lifecycle. |
| `storage.rules` | COMPATIBLE | Clinician/center/owner/public asset storage paths remain; no client-specific storage block found. |
| `firestore.indexes.json` | COMPATIBLE | Indexes cover profile change requests, support requests, chat threads/messages, and `signal_events`; no removed ghost route/signal/client index found. |
| `lib/firebase_options.dart` | WARNING | Web and Android configs point to project number `420957221495`; Windows app id/messaging sender uses `643226562725` while projectId remains `mental-smile-platform`. Requires platform intent review if Windows builds matter. |
| Android Firebase references | WARNING / SAFE_HISTORY | Active `android/app/google-services.json` matches project `mental-smile-platform`, project number `420957221495`, app id `1:420957221495:android:356d24a12835b9723a0c72`, and package `com.mentalsmile.app`. A backup config file exists and should remain safe history unless Owner wants cleanup. |
| `.github/workflows` held state | OWNER_DECISION | Firebase Hosting merge/PR workflows exist and can deploy/preview if committed. Merge workflow targets branch `ai-lab`; both use Firebase Hosting deploy action and project `mental-smile-platform`. |

## 4. Compatibility Details

### Client Identity

Classification: `COMPATIBLE`

The audited Firebase/YAML/config surfaces do not contain active client account identity assumptions:

- No `clients` Firestore rule block.
- No `isClient()` or client create/update validators in rules.
- No removed client route references in audited config surfaces.
- No removed client dashboard/register asset bundles in `pubspec.yaml`.

### Session-First Access

Classification: `COMPATIBLE / OWNER_DECISION`

Session-first behavior remains compatible through:

- `provider_contact_requests` and `center_contact_requests` requiring `requesterSessionId` and `requesterRole == 'session'`.
- `signal_events` allowing `actorRole` values `session` and `visitor` for non-signed-in signal observation.

Owner-decision residue:

- `saved_destinations` still allows session-scoped writes and support-observer reads.
- Purpose/readback lifecycle remains unresolved.

### Provider / Center Identity

Classification: `COMPATIBLE`

Provider/center identity is preserved:

- Firestore `clinicians` and `centers` rules remain.
- Profile change request collections remain.
- Storage clinician/center upload paths remain.
- Android Firebase app package matches the active application id.

### Owner / Monitoring / Registry / Declaration / Support Roles

Classification: `COMPATIBLE`

Rules preserve:

- `owner`
- `monitoring_operator`
- `registry_steward`
- `declaration_reviewer`
- `support_observer`
- `clinician`
- `center`

No hidden client role was found in audited Firebase/YAML surfaces.

### Booking / Payment / Session Lifecycle Core

Classification: `COMPATIBLE`

Targeted search found no active booking/payment/session lifecycle core entries in the audited Firebase/YAML/config surfaces.

### Accessibility Gateway

Classification: `COMPATIBLE`

The accessibility gateway remains runtime/static-data oriented. No Firebase/YAML blocker was found for active accessibility hub, organization directory, or resource gateway behavior.

### Ghost Purge Verification

Classification: `COMPATIBLE`

Targeted search in audited Firebase/YAML/config surfaces found no active references to:

- `communication_preference_selected`
- `goal_selected`
- `interest_selected`
- `accessibility_interest`
- `accessibility_mode_selected`
- `/s/capital/incidents`
- `/s/capital/maintenance`
- `/s/capital/broadcasts`
- `/s/capital/emergency-brief`
- `/request/service`
- `/request/package`
- `assets/branding/client_dashboard`
- `assets/branding/web_registration/clients`
- `assets/images/client_dashboard/actions`

## 5. Warnings

| Warning | Classification | Reason | Required Owner Action |
| --- | --- | --- | --- |
| Firebase Hosting target remains `public-landing` | OWNER_DECISION | Could deploy static landing while Flutter web build exists separately. | Decide hosting target before deploy. |
| GitHub Firebase Hosting workflows exist | OWNER_DECISION | If committed, workflows can deploy/preview on PR/push. | Decide whether workflows are allowed, held, or removed. |
| `saved_destinations` remains active | OWNER_DECISION | Session write path exists; readback/user purpose remains unresolved. | Decide keep, expose, or remove in a future package. |
| `signal_aggregates` remains read-only/write-disabled | OWNER_DECISION | Monitoring read model exists without active write lifecycle in this audit. | Decide aggregate lifecycle or archive. |
| Windows Firebase options mismatch | WARNING | Windows app id/messaging sender differs from web/android project number, while projectId remains same. | Review if Windows build target is in scope. |
| Android backup Firebase config file exists | SAFE_HISTORY / WARNING | Backup is not active app config but can confuse audits. | Keep as safe history or archive-clean later. |

## 6. Blockers

No blocker found.

## 7. Registry Updates Required

Because warnings were found, this operation updates:

- Operations Registry
- Operations Index
- Memory Registry
- Finding Registry

New finding:

- `FINDING-FIREBASE-YAML-FINAL-WARNINGS-FOUND-V1`

## 8. Manual Follow-Up

No commands were run.

Recommended Owner/manual checks before deploy:

```text
flutter analyze
flutter build web
flutter build apk --debug
firebase use
firebase apps:list
```

Do not deploy until hosting target and workflows are Owner-approved.

## Final Verdict

FIREBASE_YAML_WARNINGS_FOUND
