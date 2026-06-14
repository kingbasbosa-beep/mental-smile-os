# Mental Smile Core Inventory Request Residential V1

Status: CORE_INVENTORY_REQUESTED
Room: Strategic Planning Room
Signal: SP_SIGNAL_001 CORE_INVENTORY_REQUESTED
Runtime effect: none

## 1. Request

Strategic Planning Room requests a source inventory from Mental Smile Core for anything related to the future Residential Domain.

Mental Smile Core remains source repository only. Inventory does not activate, migrate, or approve any source item.

## 2. Requested Source Areas

Inventory is requested for:

- Residential app references.
- Client room references.
- Client dashboard.
- User onboarding.
- Tools selected by client.
- Support surfaces.
- Discovery surfaces.
- Accessibility surfaces.
- Content and library surfaces.
- Profile and account surfaces.
- Localization.
- Assets.
- Routes.
- Firebase collections.
- Storage paths.
- Old booking residues if still referenced.

## 3. Initial Observed Source Candidates

| Source Area | Observed Candidate Paths |
| --- | --- |
| Client dashboard | `lib/features/client/presentation/pages/client_dashboard_page.dart`, `assets/branding/client_dashboard/*` |
| Client registration/onboarding | `lib/features/auth/presentation/pages/client_register_page.dart`, `assets/branding/web_registration/clients/*`, `docs/history/legacy/CLIENT_REGISTRATION_AUDIT_DUMP.txt` |
| Client room/personal space | `lib/features/s_personal_space/presentation/pages/s_personal_space_page.dart`, `lib/features/s_personal_space/presentation/widgets/signal_communication_board.dart` |
| Support surfaces | `lib/features/modules/presentation/pages/support_entry_page.dart`, `lib/features/modules/presentation/pages/support_issue_selector_page.dart`, `lib/features/s_support_room/presentation/pages/s_support_room_page.dart` |
| Discovery surfaces | `lib/features/home/presentation/pages/menu_page.dart`, `lib/features/home/presentation/pages/home_page.dart`, specialist/center/library route references |
| Accessibility surfaces | `lib/features/localization/federation/models/accessibility_text_profile.dart`, accessibility signal fields in client/provider/center signal models |
| Library/content surfaces | `lib/features/library/presentation/pages/library_page.dart`, `lib/features/library/presentation/pages/library_policy_page.dart`, `lib/features/library/data/library_signal_metadata.dart`, `assets/branding/library/*`, `assets/c6_library/*` |
| Profile/account surfaces | `lib/core/auth/account_access_service.dart`, `lib/core/auth/presentation/pages/account_blocked_page.dart` |
| Localization | `lib/l10n/*`, `docs/registry/localization/*`, root localization foundation documents |
| Assets | `assets/branding/*`, `assets/images/client_dashboard/*`, `assets/images/family_support/*`, `assets/images/addiction/*`, `docs/registry/assets/*` |
| Routes | `lib/app/router/routes.dart`, `lib/app/router/app_router.dart` |
| Firebase collections | `firestore.rules`, `firestore.indexes.json`, `firebase_rules/*`, services touching client/support/saved destinations/chat |
| Storage paths | `storage.rules`, `lib/core/storage/locale_storage.dart`, center storage services as source candidates |
| Booking residues | `docs/BOOKING_*`, `BOOKING_AUTHORITY_FREEZE_P2.md`, `firebase_rules/firestore.rules.DEV_BOOKING`, booking references in Firestore and legacy docs |

## 4. Required Response Format

Each inventory response item must include:

- Source ID.
- Source path.
- Source area.
- Current behavior summary.
- Related routes.
- Related assets.
- Related collections or storage paths.
- Known legacy coupling.
- Initial risk.
- Recommended classification.

## 5. Classification Options

- USE_AFTER_PURIFICATION.
- REBUILD_FROM_SCRATCH.
- REMOVE.
- NOT_RELEVANT.
- MISSING_CREATE_NEW.
