# Client Legacy Dependency Cut Map V1

Status: COMPLETED
Date: 2026-06-18
Operation: OP-PHASE-13-CLIENT-LEGACY-DEPENDENCY-CUT-MAP-V1
Execution Mode: SURGICAL_REMOVAL_MAP_ONLY
Runtime effect: none

## Purpose

Create a minimal surgical dependency map for removing old client login, client registration, client dashboard, and client profile/preference room surfaces.

This is a removal map only.

No runtime change, deletion, refactor, Firebase action, commit, push, or tag was performed.

## Scope Inspected

- Client registration route
- Client dashboard route
- Client room/dashboard page
- Client profile/preferences
- Saved destinations personal dependencies
- Client auth guards
- Residential route ownership
- Rules references
- Asset references
- Localization references
- Navigation/menu links
- Splash links
- App router links
- Tests if any

## Dependency Classification Legend

| Classification | Meaning |
| --- | --- |
| REMOVE_NOW | Safe removal candidate once Owner approves execution. |
| REWIRE_TO_SESSION_ROOM | Replace legacy client identity route with `/client/session-room`. |
| ARCHIVE_ONLY | Do not delete immediately; archive or mark as historical/legacy. |
| KEEP_FOR_PROVIDER_CENTER | Needed for provider, center, owner, reviewer, support, or non-client auth flow. |
| UNKNOWN_BLOCKER | Requires focused verification before removal. |

## Dependency Ledger

| Dependency | Evidence | Classification | Cut Instruction |
| --- | --- | --- | --- |
| `Routes.clientRegister` / `/register/client` | `lib/app/router/routes.dart`; `lib/app/router/app_router.dart`; `language_page.dart` | REWIRE_TO_SESSION_ROOM | Remove route constant and router case only after language/register entry rewires to `/client/session-room` or another approved account-free path. |
| `ClientRegisterPage` | `lib/features/auth/presentation/pages/client_register_page.dart` | REMOVE_NOW | Delete after route and language-page link are rewired; it creates Firebase Auth user, `clients` doc, stored signals, and preferences. |
| Client registration writes to `clients` | `client_register_page.dart` writes `role`, `displayName`, `avatarAsset`, `clientSignals`, `privacyPreferences` | ARCHIVE_ONLY | Do not delete Firestore data in this phase; future Firebase rules/data archive requires separate approval. |
| Client registration emits registration signals | `client_register_page.dart` emits goal/interest/accessibility/communication signals from `client_registration` | REWIRE_TO_SESSION_ROOM | Future signal capture should move to repeated session-room selections, not registration-time stored profile preferences. |
| `Routes.clientDashboard` / `/client/dashboard` | `routes.dart`; `app_router.dart`; Route Registry; Residential Route Ownership Registry | REWIRE_TO_SESSION_ROOM | Replace client dashboard destinations with `/client/session-room`; remove protected dashboard route after all navigation callers are rewired. |
| `ClientDashboardPage` | `lib/features/client/presentation/pages/client_dashboard_page.dart` | REMOVE_NOW | Delete after dashboard route, menu shortcut, login client branch, and internal dashboard nav references are removed. |
| Client dashboard `clients` stream | `ClientDashboardPage._clientStream()` reads `clients` by uid/email | ARCHIVE_ONLY | Do not remove `clients` collection globally; provider/center/admin rules are separate. Mark client dashboard dependency archived after removal. |
| Client dashboard saved destinations preview | `ClientDashboardPage` reads `saved_destinations` by `clientId` | UNKNOWN_BLOCKER | Do not remove `saved_destinations`; it is used by provider/center/library save flows. Decide whether saved destinations move to Personal Space, Session Room, or remain as account-only continuity. |
| Client dashboard personal/profile UI | `ClientDashboardPage` displays avatar, name, personal space/profile edit, preferences, tools | REWIRE_TO_SESSION_ROOM | Replace client profile/dashboard access with session-room intent and optional Personal Space continuity only if Owner approves account-based personal space retention. |
| `Routes.clientSessionRoom` / `/client/session-room` | Phase 8 route and page | KEEP_FOR_PROVIDER_CENTER | Keep as replacement public client access path. Despite label, this is the target account-free path, not legacy. |
| Login route `/login` | `LoginPage` routes owner, monitoring, registry, reviewer, support, clinician, center, client | KEEP_FOR_PROVIDER_CENTER | Do not remove `/login`; remove or rewire only the `RoleNames.client -> Routes.clientDashboard` branch. |
| Login client role branch | `login_page.dart` returns `Routes.clientDashboard` for `RoleNames.client` | REWIRE_TO_SESSION_ROOM | Rewire client role login result to `/client/session-room`, or block legacy client account login only after Owner approval. |
| App router dashboard guard | `_clientOnlyRoutes` and `_requiresSignedInNonAnonymous` include `Routes.clientDashboard` | REMOVE_NOW | Remove only when dashboard route is removed. Keep auth guards for Personal Space and non-client roles. |
| Menu client shortcut | `menu_page.dart` returns `Routes.clientDashboard` for role `client` | REWIRE_TO_SESSION_ROOM | Rewire to `/client/session-room` or remove client dashboard shortcut. Keep owner/clinician/center shortcuts. |
| Splash legacy login link | `splash_page.dart` shows `Legacy Login` -> `Routes.login` | KEEP_FOR_PROVIDER_CENTER | Keep login entry only if renamed/reframed for provider/center/admin access; client quick access already points to session room. |
| Language page client registration link | `language_page.dart` `Register as client` -> `Routes.clientRegister` | REWIRE_TO_SESSION_ROOM | Replace with Quick Access or remove client registration row. Keep clinician and center registration rows. |
| Home page login link | `home_page.dart` unauthenticated login button -> `Routes.login` | KEEP_FOR_PROVIDER_CENTER | Keep or relabel as staff/provider/center login; do not treat as client-only. |
| App exit login link | `app_exit_social_links_page.dart` routes to `Routes.login` | KEEP_FOR_PROVIDER_CENTER | Keep if login remains for provider/center/admin; review text only in future execution. |
| Account blocked login redirect | `account_blocked_page.dart` routes to `Routes.login` | KEEP_FOR_PROVIDER_CENTER | Keep for non-client account recovery unless future auth architecture changes. |
| Web clinician/center registration login links | web registration pages route to `Routes.login` | KEEP_FOR_PROVIDER_CENTER | Keep. Provider and center auth still depend on login. |
| `saved_destinations` repository | `SavedDestinationRepository` writes/reads by `clientId` and emits `destinationSaved` | KEEP_FOR_PROVIDER_CENTER | Keep for provider/center/library saved paths until a separate Personal Space/Session Room decision is made. |
| `saved_destinations` Firestore rules | `firestore.rules` match `/saved_destinations/{savedId}` | KEEP_FOR_PROVIDER_CENTER | Keep rules while repository remains active. Do not remove under client legacy removal. |
| `provider_contact_requests` and `center_contact_requests` rules | `firestore.rules` require signed-in `clientId` | UNKNOWN_BLOCKER | Accessible contact and contact requests still require signed-in client identity. Future account-free contact needs separate rules/data design. |
| `support_requests` and `chat_threads` rules | `firestore.rules` require signed-in user for create/read | UNKNOWN_BLOCKER | Client account-free support/chat requires separate design; do not remove rules here. |
| `clients` collection ownership | Residential Collection Ownership Registry | ARCHIVE_ONLY | Mark client legacy profile usage archived only after runtime removal; do not delete collection without Firebase/data archive operation. |
| `RESIDENTIAL_ROUTE_OWNERSHIP_REGISTRY_V1` `/client/dashboard` | Existing registry marks `LEGACY_CANDIDATE` | ARCHIVE_ONLY | After removal, mark `/client/dashboard` archived. |
| `ADMINISTRATIVE_ROUTE_OWNERSHIP_REGISTRY_V1` `/register/client` | Existing registry marks `LEGACY_CANDIDATE` | ARCHIVE_ONLY | After removal, mark `/register/client` archived. |
| `ROUTE_REGISTRY_V1` legacy notes | Phase 8 notes list `/login`, `/register/client`, `/client/dashboard` | ARCHIVE_ONLY | After removal, update `/register/client` and `/client/dashboard` to archived; keep `/login` as provider/center/admin if retained. |
| Client dashboard localization keys | `clientDashboardSubtitle`, `clientDashboardWelcome`, `clientMessagePreferences` | REMOVE_NOW | Remove/archive after `ClientDashboardPage` is deleted and generated localization is regenerated. |
| Auth registration localization keys | `authClientRegister`, `authName`, `authConfirmPassword`, `authCreatingAccount`, client registration validation strings | ARCHIVE_ONLY | Some auth keys are shared by login/provider/center or may be needed by other registration forms. Remove only keys proven client-register-only. |
| Login localization keys | `authEmail`, `authPassword`, `authInvalidEmail`, login failure keys | KEEP_FOR_PROVIDER_CENTER | Keep because `/login` remains required for provider/center/admin roles. |
| Client registration background assets | `assets/branding/web_registration/clients/**/client_register.png` | ARCHIVE_ONLY | Archive/unbundle after `ClientRegisterPage` removal and asset inventory confirms no other references. |
| Client avatar assets | `assets/images/avatar_client.png`, `avatar_client_fmale.png`, `avatar_client_male.png`, `assets/c5/avatars/avatar_client.png` | UNKNOWN_BLOCKER | Client dashboard/register use them, but menu/personal surfaces may still rely on avatar conventions. Confirm global references before unbundling. |
| Login background assets | `assets/branding/login/login_mobile_v1.png`, `login_tablet_v1.png`, `login_web_v1.png` | KEEP_FOR_PROVIDER_CENTER | Keep while `/login` remains. |
| `assets/branding/logo_primary_dark.png` | Used by client dashboard and broader branding | KEEP_FOR_PROVIDER_CENTER | Do not remove; shared branding. |
| Tests | `rg` found no direct `ClientDashboardPage` / `ClientRegisterPage` test files under `test` | REMOVE_NOW | No test files identified for removal, but run full test search before execution. |

## Required Final List

### 1. Files To Delete

Classified `REMOVE_NOW` after Owner approves actual removal:

- `lib/features/auth/presentation/pages/client_register_page.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`

No deletion in this phase.

### 2. Routes To Remove

Classified `REWIRE_TO_SESSION_ROOM` or `REMOVE_NOW`:

- `/register/client`
- `/client/dashboard`

Do not remove:

- `/login` because it is shared by provider, center, owner, monitoring, registry, declaration reviewer, and support roles.
- `/client/session-room` because it is the account-free replacement path.

### 3. Router Cases To Remove

After rewiring callers:

- `case Routes.clientRegister`
- `case Routes.clientDashboard`
- `Routes.clientDashboard` from `_clientOnlyRoutes`
- `Routes.clientDashboard` from `_requiresSignedInNonAnonymous`
- imports for `ClientRegisterPage`
- imports for `ClientDashboardPage`

Keep:

- `case Routes.login`
- provider/center/owner/support auth routing
- `case Routes.clientSessionRoom`

### 4. Rules To Remove Or Keep

Keep:

- `/saved_destinations/{savedId}` rules until saved destinations are redesigned.
- `/provider_contact_requests/{requestId}` rules.
- `/center_contact_requests/{requestId}` rules.
- `/support_requests/{requestId}` rules.
- `/chat_threads/{threadId}` rules.
- provider/center/profile change rules.

Potential future removal/archive:

- client profile write assumptions in `/clients` rules, only after a dedicated Firebase/data operation.

Unknown blockers:

- account-free accessible contact cannot fully work while provider/center contact rules require signed-in `clientId`.
- account-free support/chat cannot fully work while support/chat rules require signed-in user.

### 5. Assets To Unbundle/Archive

Archive candidates:

- `assets/branding/web_registration/clients/desktop/client_register.png`
- `assets/branding/web_registration/clients/mobile/client_register.png`
- `assets/branding/web_registration/clients/tablet/client_register.png`

Unknown blockers:

- `assets/images/avatar_client.png`
- `assets/images/avatar_client_fmale.png`
- `assets/images/avatar_client_male.png`
- `assets/c5/avatars/avatar_client.png`

Keep:

- `assets/branding/login/**`
- shared logos and navigation assets

### 6. Localization Keys To Remove/Archive

Remove/archive after dashboard/register deletion and localization regeneration:

- `clientDashboardSubtitle`
- `clientDashboardWelcome`
- `clientMessagePreferences`
- `authClientRegister`

Review before removal:

- `authName`
- `authConfirmPassword`
- `authCreatingAccount`
- `authNameRequired`
- `authEmailRequired`
- `authWeakPassword`
- `authPasswordsDoNotMatch`
- `authRegistrationFailed`

Keep:

- `authEmail`
- `authPassword`
- `authInvalidEmail`
- login failure and blocked account strings

### 7. Navigation Links To Rewire

Rewire to `/client/session-room`:

- `language_page.dart` client registration row.
- `menu_page.dart` client role shortcut.
- `login_page.dart` `RoleNames.client` route result, if client login remains allowed during transition.

Keep or relabel for provider/center/admin:

- `splash_page.dart` Legacy Login button.
- `home_page.dart` login button.
- `app_exit_social_links_page.dart` login link.
- provider/center web registration login redirects.

Already correct:

- Splash `Quick Access` -> `/client/session-room`.

### 8. Registry Entries To Mark Archived

After actual removal:

- `ROUTE_REGISTRY_V1.md`
  - `/register/client` -> ARCHIVED
  - `/client/dashboard` -> ARCHIVED
- `RESIDENTIAL_ROUTE_OWNERSHIP_REGISTRY_V1.md`
  - `/client/dashboard` -> ARCHIVED
- `ADMINISTRATIVE_ROUTE_OWNERSHIP_REGISTRY_V1.md`
  - `/register/client` -> ARCHIVED
- `RESIDENTIAL_COLLECTION_OWNERSHIP_REGISTRY_V1.md`
  - client profile usage of `clients` -> ARCHIVE_ONLY or LEGACY_DATA
  - keep `saved_destinations` ACTIVE unless separate decision changes it.
- `ARCHIVE_REGISTRY_V1.md`
  - add archive card for client registration/dashboard/profile runtime removal.
- `MEMORY_REGISTRY_V1.md`
  - add completed removal memory after execution.
- `EXECUTED_OPERATIONS_REGISTRY_V1.md`
  - register actual removal as a separate operation.

### 9. Manual Checks After Removal

Required manual checks after future removal operation:

- Run `dart format` on touched Dart files.
- Run `flutter analyze`.
- Run route smoke checks:
  - `/client/session-room`
  - `/login`
  - `/web/clinician/register`
  - `/web/center/register`
  - `/module/specialists/details`
  - `/module/centers/details`
- Confirm provider login still routes to clinician room.
- Confirm center login still routes to center dashboard/room.
- Confirm owner/support/reviewer login still routes correctly.
- Confirm language page no longer links to `/register/client`.
- Confirm menu client shortcut no longer links to `/client/dashboard`.
- Confirm splash Quick Access still works.
- Confirm saved provider/center destination flow still works or is intentionally frozen.
- Confirm contact request flows still work for provider and center.
- Confirm no `ClientRegisterPage` or `ClientDashboardPage` imports remain.
- Confirm generated localization files compile after ARB cleanup.
- Confirm `pubspec.yaml` asset bundle no longer includes removed client-only assets, if unbundled.
- Confirm registries mark removed routes archived.

## Minimal Cut Sequence For Future Execution

1. Rewire `language_page.dart` client row to `/client/session-room` or remove the row.
2. Rewire `menu_page.dart` client role shortcut to `/client/session-room`.
3. Rewire `login_page.dart` client role branch away from `/client/dashboard`.
4. Remove `Routes.clientRegister` and `Routes.clientDashboard`.
5. Remove router cases/imports for `ClientRegisterPage` and `ClientDashboardPage`.
6. Delete client register and dashboard page files.
7. Archive/unbundle client registration assets only after asset reference check.
8. Remove/archive client-only localization keys and regenerate localization outputs.
9. Update route, archive, memory, and operations registries.
10. Run manual checks.

## Blockers

The removal is blocked until these are resolved:

- `saved_destinations` still depends on signed-in `clientId` and is used by provider/center/library save flows.
- provider/center contact request rules still require signed-in `clientId`.
- support/chat rules still require signed-in participants.
- `/login` is shared infrastructure and cannot be removed as part of client-only extraction.
- client avatar assets require a broader asset reference check before unbundling.

## Final Verdict

BLOCKED_UNKNOWN_DEPENDENCIES
