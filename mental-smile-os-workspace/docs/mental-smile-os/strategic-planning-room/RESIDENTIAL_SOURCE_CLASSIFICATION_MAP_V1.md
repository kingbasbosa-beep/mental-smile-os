# Residential Source Classification Map V1

Status: SOURCE_CLASSIFICATION_REQUIRED
Room: Strategic Planning Room
Signal: SP_SIGNAL_002 SOURCE_CLASSIFICATION_REQUIRED
Runtime effect: none

## 1. Classification Rule

All Mental Smile Core source candidates must be classified before any Residential Domain build package.

No source item may be copied as-is.

Allowed path:

```text
Extract -> Purify -> Reclassify -> Rebuild
```

## 2. Source Classification Map

| Source ID | Source Item | Observed Paths | Classification | Strategic Reason |
| --- | --- | --- | --- | --- |
| RES-SRC-001 | Client dashboard surface | `lib/features/client/presentation/pages/client_dashboard_page.dart`, `assets/branding/client_dashboard/*`, `assets/images/client_dashboard/*` | USE_AFTER_PURIFICATION | Strong residential candidate; must remove legacy room assumptions and align to future domain language. |
| RES-SRC-002 | Client registration/onboarding | `lib/features/auth/presentation/pages/client_register_page.dart`, `assets/branding/web_registration/clients/*`, `docs/history/legacy/CLIENT_REGISTRATION_AUDIT_DUMP.txt` | USE_AFTER_PURIFICATION | Needed for residential entry; must purify legacy registration residue. |
| RES-SRC-003 | Personal space/client room residue | `lib/features/s_personal_space/*` | REBUILD_FROM_SCRATCH | Contains useful concepts but likely old room semantics; rebuild into Residential identity/preferences model. |
| RES-SRC-004 | Client signals | `lib/features/signals/domain/models/client_signals.dart`, signal registries/factory | USE_AFTER_PURIFICATION | Useful residential signal basis; must align to new Signal Asset doctrine. |
| RES-SRC-005 | Selected tools/preferences | Personal space preferences, saved destinations, recommendation signal magnet files | MISSING_CREATE_NEW | Existing pieces imply selection memory but no clean residential tool-selection doctrine exists. |
| RES-SRC-006 | Support entry surfaces | `lib/features/modules/presentation/pages/support_entry_page.dart`, `support_issue_selector_page.dart`, `s_support_room_page.dart` | USE_AFTER_PURIFICATION | Residential support pathways are relevant; must not create operations room or support department. |
| RES-SRC-007 | Discovery surfaces | `lib/features/home/presentation/pages/menu_page.dart`, `home_page.dart`, specialists/centers/library routing | USE_AFTER_PURIFICATION | Useful navigation/discovery source; must be rebuilt as residential discovery strategy. |
| RES-SRC-008 | Accessibility surfaces | Accessibility signal fields and `accessibility_text_profile.dart` | USE_AFTER_PURIFICATION | Required for residential dignity/access; must purify language and registry fit. |
| RES-SRC-009 | Library/content surfaces | `lib/features/library/*`, `assets/branding/library/*`, `assets/c6_library/*` | USE_AFTER_PURIFICATION | Relevant content access source; must not create Library Department. |
| RES-SRC-010 | Profile/account surfaces | `lib/core/auth/account_access_service.dart`, `account_blocked_page.dart` | USE_AFTER_PURIFICATION | Needed for account access; authority and privacy boundaries require purification. |
| RES-SRC-011 | Localization | `lib/l10n/*`, `docs/registry/localization/*` | USE_AFTER_PURIFICATION | Required for bilingual residential build; must use constitutional language rules. |
| RES-SRC-012 | Assets and visual sources | `assets/branding/*`, `assets/images/*`, `docs/registry/assets/*` | USE_AFTER_PURIFICATION | Visual assets are useful but must be reclassified under new asset/card/guide rules. |
| RES-SRC-013 | Routes | `lib/app/router/routes.dart`, `lib/app/router/app_router.dart` | REBUILD_FROM_SCRATCH | Current route map is source evidence; future Residential route topology must be rebuilt cleanly. |
| RES-SRC-014 | Firebase client collections | `firestore.rules`, service files touching `clients`, `saved_destinations`, `support_requests`, `chat_escalations` | USE_AFTER_PURIFICATION | Data boundaries matter; no rules are created here. Requires future technical/legal review. |
| RES-SRC-015 | Storage paths | `storage.rules`, storage services | USE_AFTER_PURIFICATION | Storage boundaries are source candidates only; no implementation in planning room. |
| RES-SRC-016 | Booking residues | `docs/BOOKING_*`, `BOOKING_AUTHORITY_FREEZE_P2.md`, booking rules/dev residues | REMOVE | Booking legacy must not become Residential foundation. Preserve only as risk/removal evidence. |
| RES-SRC-017 | Residential monitoring code | `lib/features/monitoring/residential/*` | NOT_RELEVANT | Monitoring is explicitly forbidden in this room and must not be imported into Residential build strategy. |
| RES-SRC-018 | Commercial monitoring/intelligence | `lib/features/monitoring/commercial/*` | NOT_RELEVANT | Commercial intelligence is outside Residential planning scope. |

## 3. Missing Create New Items

| Missing Item | Reason |
| --- | --- |
| Residential Domain Guide | Needed before future Residential cards can exist. |
| Residential Card Set | Needed after guide approval, not in this step. |
| Residential Signal Registry Subset | Needed to distinguish residential signals from monitoring/support signals. |
| Residential Source Purification Queue | Needed to process source candidates before build. |
| Residential Build Package | Needed after Owner review, not created here. |

## 4. Stop Boundary

This map classifies source candidates only. It does not approve build, create Residential Domain, modify code, change Firebase rules, or create runtime.
