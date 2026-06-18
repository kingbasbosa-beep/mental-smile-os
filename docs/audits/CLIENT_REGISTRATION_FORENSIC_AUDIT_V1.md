# Client Registration Forensic Audit V1

Status: INVESTIGATION_COMPLETE
Date: 2026-06-17
Scope: `/register/client` runtime route, active client registration screen, avatar assets, archive evidence, and registration data flow.
Runtime effect: none
Firebase effect: none
Git effect: none

## Executive Summary

The runtime route `/#/register/client` maps to `Routes.clientRegister`, which maps to `ClientRegisterPage` in `lib/features/auth/presentation/pages/client_register_page.dart`.

The active screen is the legacy/heavy registration implementation. It collects a required name, email, password, confirm password, avatar choice, goal signals, interest signals, accessibility signals, communication signals, and two privacy/recommendation switches. On submit it creates a Firebase Auth user, writes a `clients/{uid}` Firestore document, emits first-selected signal events, and routes to `Routes.clientDashboard`.

No newer simplified client registration Dart page was found in `lib`. The simplified registration doctrine exists in documentation and recreation cards, but the router still points to the heavy runtime page.

Final verdict: E. Documentation decision exists but implementation was never completed.

Secondary evidence also supports A: Legacy screen is still active and no newer screen exists.

## Runtime Route Mapping

| Route | File | Evidence | Result |
| --- | --- | --- | --- |
| `/register/client` | `lib/app/router/routes.dart` | `static const clientRegister = '/register/client';` | Active route constant |
| `Routes.clientRegister` | `lib/app/router/app_router.dart` | `case Routes.clientRegister` builds `const ClientRegisterPage()` | Active router mapping |
| `ClientRegisterPage` | `lib/features/auth/presentation/pages/client_register_page.dart` | `class ClientRegisterPage extends StatefulWidget` | Active rendered screen |

The import path in `app_router.dart` is:

```dart
import 'package:mental_smile_os/features/auth/presentation/pages/client_register_page.dart';
```

The active route is not an alias to a newer web registration flow. Clinician and center aliases route to web registration pages, but client registration routes directly to the auth feature page.

## Active Screen Evidence

Active file:

`lib/features/auth/presentation/pages/client_register_page.dart`

Role:

- Runtime page for `/register/client`.
- Creates client Firebase Auth account.
- Writes initial `clients/{uid}` profile document.
- Emits residential signal packages from registration choices.
- Navigates to `Routes.clientDashboard`.

Active runtime status: ACTIVE_RUNTIME

Legacy residue status: ACTIVE_LEGACY_BEHAVIOR

Imports / dependencies:

- `cloud_firestore`
- `firebase_auth`
- `flutter/material.dart`
- `Routes`
- `features/signals/signals.dart`
- generated localizations
- `asset_fallback_widgets.dart`
- `app_design_system.dart`
- `asset_path_utils.dart`

Collected UI fields and controls:

- `name` via `_nameController`
- `email` via `_emailController`
- `password` via `_passwordController`
- `confirmPassword` via `_confirmPasswordController`
- avatar selection via `_selectedAvatar`
- goal chips via `_selectedGoalSignals`
- interest chips via `_selectedInterestSignals`
- accessibility chips via `_selectedAccessibilitySignals`
- communication chips via `_selectedCommunicationSignals`
- `keepSupportPreferencesPrivate`
- `usePreferencesForRecommendations`

Visible legacy/heavy screen markers:

- `_avatarOptions` contains four avatar images.
- `_ClientSignalSection` renders goals, interests, accessibility, and communication chips.
- `_backgroundAsset()` uses the old web registration client mobile background.
- `_RegisterLogoutButton` appears on the registration page.

## Alternative/New Screen Search Results

Search result:

- No newer simplified client registration Dart page was found in `lib`.
- No alternate runtime `RegisterClientPage`, `ClientRegistrationPage`, or simplified client registration implementation was found.
- Existing client registration docs define a simplified future package, but it is documentation/package guidance, not connected runtime code.

Relevant runtime classes found:

| File | Class / Role | Active Runtime | Notes |
| --- | --- | --- | --- |
| `lib/features/auth/presentation/pages/client_register_page.dart` | `ClientRegisterPage` | Yes | Current `/register/client` page |
| `lib/features/client/presentation/pages/client_dashboard_page.dart` | `ClientDashboardPage` | Yes | Reads avatar and client signals produced by registration |
| `lib/features/s_personal_space/presentation/pages/s_personal_space_page.dart` | Personal Space model | Yes | Reads `clientSignals` later |

Relevant documentation/package files found:

| File | Role | Runtime |
| --- | --- | --- |
| `mental-smile-os-workspace/docs/mental-smile-os/app-surface/client-registration/CLIENT_REGISTRATION_SOURCE_CLASSIFICATION_V1.md` | Classifies old Flutter client registration as `REMOVE` | Documentation only |
| `mental-smile-os-workspace/docs/mental-smile-os/app-surface/client-registration/CLIENT_REGISTRATION_RECREATION_PROMPT_CARD_V1.md` | Defines simplified visual package | Documentation only |
| `mental-smile-os-workspace/docs/mental-smile-os/app-surface/client-registration/CLIENT_REGISTRATION_FIELD_AUDIT_V1.md` | Inventories current heavy fields | Documentation only |
| `mental-smile-os-workspace/docs/mental-smile-os/app-surface/client-registration/CLIENT_REGISTRATION_FIELD_REVIEW_QUEUE_V1.md` | Queues fields for Owner review | Documentation only |

## Avatar Asset Investigation

### Runtime avatar references

`lib/features/auth/presentation/pages/client_register_page.dart`:

```dart
String _selectedAvatar = 'images/avatar_client_fmale.png';

static const List<String> _avatarOptions = [
  'images/avatar_client_fmale.png',
  'images/avatar_client_male.png',
  'images/avatar_clinician_fmale.png',
  'images/avatar_clinician_male.png',
];
```

These are resolved by `normalizeAssetPath`, which prepends `assets/` when a path does not already start with `assets/`. Therefore runtime asset paths become:

- `assets/images/avatar_client_fmale.png`
- `assets/images/avatar_client_male.png`
- `assets/images/avatar_clinician_fmale.png`
- `assets/images/avatar_clinician_male.png`

`lib/features/client/presentation/pages/client_dashboard_page.dart` reads `clients/{uid}.avatarAsset` and renders it inside `_ClientAvatarBadge` using `Image.asset(normalizeAssetPath(avatarAsset))`.

`lib/features/chat/presentation/pages/chat_page.dart` uses only:

- `assets/images/avatar_client.png`

`lib/features/home/presentation/pages/menu_page.dart` references:

- `assets/images/avatar_clinician_male.png`

### Asset files present

Runtime asset folder contains:

- `assets/images/avatar_client.png`
- `assets/images/avatar_client_fmale.png`
- `assets/images/avatar_client_male.png`
- `assets/images/avatar_clinician_fmale.png`
- `assets/images/avatar_clinician_male.png`
- six library category cards:
  - `assets/images/cat_articles.png`
  - `assets/images/cat_exercises.png`
  - `assets/images/cat_audio.png`
  - `assets/images/cat_videos.png`
  - `assets/images/cat_tools.png`
  - `assets/images/cat_saved.png`

### Pubspec registration

`pubspec.yaml` includes:

```yaml
- assets/images/
- assets/branding/web_registration/clients/mobile/client_register.png
```

This means all `assets/images/avatar_*` files and the client registration background are bundled for runtime use.

### Archive / retained asset comparison

Current archive and inventory evidence says:

- `assets/images/avatar_client.png` is the active chat avatar survivor.
- six C6 library cards are retained under `assets/images/cat_*.png`.
- `assets/branding/web_registration/clients/mobile/client_register.png` remains an active exception.
- `assets/branding/web_registration/` non-client mobile duplicates are legacy/present.

Conflict:

- Registration uses four avatar selection assets, including clinician/gender-coded avatars.
- Archive evidence only clearly retains `assets/images/avatar_client.png` as the chat avatar survivor.
- The four registration avatar options overlap with old avatar/identity selection behavior and are not identified as the single retained chat avatar or the six retained library cards.

## Archive/Card Evidence

Evidence that the old registration screen should not be active as-is:

`CLIENT_REGISTRATION_SOURCE_CLASSIFICATION_V1.md`:

- Old Flutter client registration screen: `REMOVE`.
- Reason: old code, old layout, Firebase, signals, extra fields, avatar, interests, and runtime behavior are not allowed.
- Old fields including name, avatar, interests, and questions: `REMOVE`.
- Tool/recommendation/profile data concepts belong inside Client Room or later preferences, not registration.

`CLIENT_REGISTRATION_RECREATION_PROMPT_CARD_V1.md`:

- Simplified visual package should include only email or phone, password, and confirm password.
- Negative rules explicitly state: no name, age, gender, avatar, interests, questions, tools, recommendations, or profile data.

`CLIENT_REGISTRATION_VISUAL_ASSET_CARD_V1.md`:

- Future Client Room feature cards are preview only.
- Personal Picture Frame is a future concept with no upload in registration.
- Private Personal Space has no preferences collected in registration.
- Assets are constitutional package assets only and not runtime-ready.

`CLIENT_REGISTRATION_FIELD_REVIEW_QUEUE_V1.md`:

- Goal signals at registration: unknown, needs Owner review.
- Interest signals at registration: sensitive and broad, likely move to client preferences.
- Avatar options include role/gender-coded images and need review.
- Logout icon on registration page is a remove candidate.

`PHASE_3_PRE_BASELINE_PURIFICATION_EXECUTION_RESULT_V1.md`:

- Migrated only `assets/c5/avatars/avatar_client.png` to `assets/images/avatar_client.png`.
- Migrated six C6 library category cards.
- The only remaining `assets/branding/web_registration` active exception is the mobile client registration background.

Conclusion from archive/card evidence:

The simplified registration decision and removal direction are documented, but no replacement runtime page is connected to `/register/client`.

## Current Data Flow

### Submit flow

`ClientRegisterPage._register()`:

1. Validates name, email, password, confirm password.
2. Calls `FirebaseAuth.instance.createUserWithEmailAndPassword`.
3. Calls `user.updateDisplayName(name)`.
4. Writes `FirebaseFirestore.instance.collection('clients').doc(user.uid).set(...)`.
5. Calls `_emitRegistrationSignals(user.uid)`.
6. Calls `Navigator.of(context).pushNamedAndRemoveUntil(Routes.clientDashboard, ...)`.

### Firestore document target

Collection:

- `clients`

Document:

- `clients/{uid}`

Fields written:

- `role: client`
- `displayName`
- `email`
- `avatarAsset`
- `clientSignals.goalSignals`
- `clientSignals.interestSignals`
- `clientSignals.accessibilitySignals`
- `clientSignals.communicationSignals`
- `privacyPreferences.keepSupportPreferencesPrivate`
- `privacyPreferences.usePreferencesForRecommendations`
- `signalSchemaVersion: client_signals_v1`
- `createdAt`
- `updatedAt`

### Signal events

Signals emitted if the relevant selected set is non-empty:

- `SignalPackageFactory.goalSelected`
- `SignalPackageFactory.interestSelected`
- `SignalPackageFactory.accessibilityInterest`
- `SignalPackageFactory.communicationPreferenceSelected`

All use:

- `actorRole: client`
- `signalSource: client_registration`
- first selected value as `targetId`

Signal persistence:

- `CleanSignalRuntime.firestore()` emits through `SignalStorageService`.
- `SignalStorageService.eventsCollection = 'signal_events'`.

### Are chips actually persisted?

Yes.

The selected chip keys are persisted under `clients/{uid}.clientSignals`.

### Are chips only UI?

No.

They are UI controls, Firestore persisted fields, dashboard read-model inputs, personal-space inputs, and first-selected signal event sources.

### Do they affect routing?

Registration choices do not branch route selection. After submit the route always goes to:

- `Routes.clientDashboard`

However, the stored signals affect post-registration display surfaces.

### Do they affect client room / dashboard configuration?

Yes, partially.

`ClientDashboardPage` reads:

- `avatarAsset`
- `clientSignals.goalSignals`
- `clientSignals.interestSignals`
- `clientSignals.accessibilitySignals`
- `clientSignals.communicationSignals`

It displays a client avatar badge and a signal summary card.

`SPersonalSpacePage` reads the same `clientSignals` groups and computes total/completeness metrics.

## Doctrine Comparison

| Doctrine | Current Runtime | Result |
| --- | --- | --- |
| Registration should be minimal | Collects name, email, password, confirm password, avatar, four signal groups, privacy switches | Violates |
| Identity should not be forced through avatars | Default avatar is set and four avatar choices are prominent | Violates |
| No pre-account heavy signal collection | Goals, interests, accessibility, communication are collected before account creation | Violates |
| Goals/interests move to post-registration setup | Goals/interests are collected during registration and stored immediately | Violates |
| Accessibility as communication preference / hub navigation, not diagnosis | Accessibility chips are stored under `clientSignals.accessibilitySignals`; labels include speech/hearing/visual/simplified | Partial violation / needs redesign |
| Signals generated from natural choices after account creation | Signals are emitted during registration from pre-account choices | Violates |
| Same city, different access paths | Current registration asks identity/access preferences early instead of offering later access paths | Partial violation |

## Findings

### F1. `/register/client` renders the old heavy runtime page

The exact active page is:

- `lib/features/auth/presentation/pages/client_register_page.dart`
- `ClientRegisterPage`

### F2. No newer simplified runtime page is connected

No simplified client registration Dart screen was found in `lib`, and `AppRouter` still points directly to `ClientRegisterPage`.

### F3. The current screen persists heavy pre-account signals

Goals, interests, accessibility preferences, and communication preferences are persisted to `clients/{uid}.clientSignals`.

### F4. The current screen emits registration-origin signals

The page emits first-selected goal, interest, accessibility, and communication signals from `client_registration`.

### F5. Avatar selection is still active and persisted

The selected avatar is written to `clients/{uid}.avatarAsset` and rendered later by `ClientDashboardPage`.

### F6. Documentation says the old screen should be removed/rebuilt

The source classification and recreation prompt explicitly reject the old code, old layout, Firebase/signals behavior, avatars, interests, and profile data at registration.

### F7. Asset purification did not remove registration avatar selection behavior

Phase 3 purified C5/C6 active references and retained one chat avatar plus six library cards. The registration page still uses four `assets/images/avatar_*` options through the broad `assets/images/` bundle.

## Risk Assessment

| Risk | Severity | Reason |
| --- | --- | --- |
| Sensitive early preference capture | High | Addiction, special needs, speech/hearing/accessibility choices are collected before trust is established. |
| Doctrine drift | High | Runtime contradicts documented simplified registration doctrine. |
| Forced/gendered/role-coded identity | Medium | Avatar choices include client/clinician and male/female variants. |
| Signal overreach | Medium | Signals emitted from registration instead of natural post-account choices. |
| Data migration complexity | Medium | Existing `clients` documents may already contain `clientSignals` and `avatarAsset`. |
| Cleanup regression risk | Medium | Client dashboard and personal space currently read these fields. |
| Asset confusion | Medium | Active chat avatar survivor and legacy avatar selection assets coexist under `assets/images/`. |

## Recommended Next Steps

1. Owner confirms final minimal registration field set.
2. Create a new governed operation before code changes.
3. Build or connect a simplified `ClientRegisterPage` replacement with only approved credential fields.
4. Move goals/interests/accessibility/communication to post-registration client room setup or personal-space onboarding.
5. Convert accessibility from identity-like chips into communication/navigation preferences and accessibility hub entry points.
6. Stop emitting goal/interest/accessibility/communication signals from registration.
7. Decide migration policy for existing `clients/{uid}.clientSignals` and `avatarAsset`.
8. Decide whether old avatar selection assets should remain bundled, move to archive evidence, or become neutral future profile assets.
9. Run formatting and analyze before any commit.

## Do Not Touch List

Until Owner approval:

- Do not delete `lib/features/auth/presentation/pages/client_register_page.dart`.
- Do not remove `clients/{uid}.clientSignals` readers from dashboard or personal space.
- Do not delete `assets/images/avatar_*`.
- Do not remove `assets/images/` from `pubspec.yaml`.
- Do not change Firebase Auth registration flow.
- Do not change Firestore rules.
- Do not change `signal_events` persistence.
- Do not migrate existing client documents.
- Do not commit, push, deploy, or tag.

## Safe Refactor Candidate List

After Owner approval and before implementation:

- Introduce a minimal registration route/page behind the existing route.
- Move `_ClientSignalSection` concepts to post-registration setup.
- Move avatar selection to optional profile personalization.
- Replace registration-origin signal emission with post-account natural-choice signals.
- Keep `ClientDashboardPage` tolerant of missing `avatarAsset` and empty `clientSignals`.
- Add a migration-safe fallback for existing users.
- Archive or reclassify unused avatar assets after runtime references are removed.

## Verification Commands To Include

These commands are listed for manual verification and should not be treated as cleanup commands:

```powershell
Get-ChildItem lib -Recurse | Select-String "register/client"
Get-ChildItem lib -Recurse | Select-String "ClientRegister|RegisterClient|ClientRegistration"
Get-ChildItem lib -Recurse | Select-String "CircleAvatar|AssetImage|Image.asset"
Get-ChildItem lib -Recurse | Select-String "goals|interests|avatar|avatars"
Get-ChildItem lib -Recurse | Select-String "أهدافي|اهتماماتي|تفضيلات الوصول|دعم السمع|دعم التخاطب"

Get-ChildItem docs -Recurse | Select-String "avatar|avatars|client registration|C6|library cards|chat avatar|registration simplification|onboarding interests"
```

Equivalent `rg` searches used for this investigation:

```powershell
rg -n 'ClientRegister|RegisterClient|ClientRegistration|register/client|client registration' lib docs mental-smile-os-workspace pubspec.yaml
rg -n 'goals|interests|avatar|avatars|CircleAvatar|AssetImage|Image\.asset|accessibility' lib/features/auth lib/features/client lib/app pubspec.yaml
rg -n 'avatar_client|avatar_client_fmale|avatar_client_male|avatar_' assets lib pubspec.yaml
```

## Final Verdict

E. Documentation decision exists but implementation was never completed.

Supporting secondary verdict:

A. Legacy screen is still active and no newer screen exists.
