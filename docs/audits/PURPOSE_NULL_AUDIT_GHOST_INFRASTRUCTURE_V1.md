# Purpose Null Audit: Ghost Infrastructure V1

Operation ID: OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1
Date: 2026-06-18
Execution Mode: AUDIT FIRST / NO REMOVAL WITHOUT OWNER APPROVAL
Runtime Effect: none
Firebase Effect: none
Git Effect: none

## 1. Executive Summary

This audit found ghost infrastructure after Pure DNA V2, client identity hard removal, Accessibility Gateway Alpha, and signal-first/session-first doctrine.

Final Verdict: GHOST_INFRASTRUCTURE_FOUND

Summary:

- Total ghost candidates: 31
- Immediate remove candidates: 14
- Owner decisions required: 11
- Do-not-touch items: provider, center, owner, monitoring, registry, declaration, support observer authority, forensic history, and archive history

The strongest pattern is that connected infrastructure remains after its runtime reason faded. Router cases, placeholder districts, signal validators, bundled asset directories, Firestore indexes, localization keys, and collection rules can all look valid while carrying no active journey.

## 2. Ghost Routes

| Item | File path | Classification | Evidence | Current connection | Missing purpose | Risk if left alive | Recommended action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `/s/city/tools` | `lib/app/router/routes.dart`; `lib/app/router/app_router.dart` | UNKNOWN_OWNER_DECISION | Router case builds generic `SWebSurfacePage`; text says future tools. | Linked from S city surface. | No runtime tool registry or user workflow found. | Future-looking route may be mistaken as usable tool runtime. | Owner decision: keep as governed placeholder or archive until tool registry exists. |
| `/s/city/programs` | same | UNKNOWN_OWNER_DECISION | Router case describes future programs. | Linked through S city map. | No program repository/runtime found. | Placeholder can be reported as feature completion. | Owner decision. |
| `/s/city/marketplace` | same | UNKNOWN_OWNER_DECISION | Router case says future marketplace. | Linked through S city map. | No marketplace collection/runtime found. | Marketplace promise without runtime backing. | Owner decision. |
| `/s/capital/incidents` | `routes.dart`; `app_router.dart`; `s_capital_operations_office_page.dart` | GHOST_ROUTE | Page groups contain `Timeline placeholder`. | Connected via Capital nav. | No incident collection/service found. | Monitoring can look operational without data. | Removal block candidate or keep as explicit construction placeholder. |
| `/s/capital/maintenance` | same | GHOST_ROUTE | Page groups contain planned/history placeholders. | Connected via Capital nav. | No maintenance collection/service found. | False operational readiness. | Removal block candidate. |
| `/s/capital/broadcasts` | same | GHOST_ROUTE | Broadcast sections are placeholders. | Connected via Capital nav. | No broadcast runtime found. | Silent dead surface. | Removal block candidate. |
| `/s/capital/emergency-brief` | same | GHOST_ROUTE | Emergency contacts/recovery/version groups are not connected. | Connected via Capital nav. | No emergency brief data source. | High-trust page with placeholder data. | Owner decision; likely remove or hide before testing. |
| `/s/capital/departments` | `app_router.dart` | UNKNOWN_OWNER_DECISION | Generic `SWebSurfacePage` for departments. | Router case only. | No department runtime found. | Governance map may overstate completeness. | Owner decision. |
| `/s/capital/trust-safety` | `app_router.dart` | UNKNOWN_OWNER_DECISION | Protected for support observer but rendered as generic surface. | Route guard exists. | No dedicated trust/safety workflow found. | Protected empty authority surface. | Owner decision. |
| `/s/capital/reports` | `app_router.dart` | UNKNOWN_OWNER_DECISION | Monitoring protected but generic surface. | Monitoring role route. | No report repository found. | Monitoring report route may imply live reports. | Owner decision. |
| `/request/service` | `routes.dart`; `portal_skeleton_pages.dart` | GHOST_ROUTE | Portal skeleton route. | Public portal nav. | No service request persistence/runtime found. | Public request promise without backend. | Remove/hide before public testing unless intentionally static. |
| `/request/package` | same | GHOST_ROUTE | Portal skeleton route. | Public portal nav. | No package request persistence/runtime found. | Same as above. | Remove/hide or mark unavailable. |
| `/contact` | same | UNKNOWN_OWNER_DECISION | Portal contact skeleton. | Public portal nav. | Contact handling not verified in runtime. | Public contact promise may be nonfunctional. | Owner decision. |

Routes with purpose:

- Provider/center registration and identity routes remain ACTIVE_PURPOSE.
- Owner/monitoring/declaration/support protected routes remain ACTIVE_PURPOSE or OWNER_DECISION where placeholder-only.
- `/client/session-room`, `/accessibility`, `/accessibility/organizations`, discovery, library, chat, support, provider, and center routes remain ACTIVE_PURPOSE.

## 3. Ghost Pages

| Item | File path | Classification | Evidence | Current connection | Missing purpose | Risk if left alive | Recommended action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `SCapitalOperationsOfficePage` placeholder districts | `lib/features/s_capital/presentation/pages/s_capital_operations_office_page.dart` | GHOST_SURFACE | Source comments say construction placeholder; many sections say placeholder/not connected. | Routes under `/s/capital/*`. | No incident/maintenance/broadcast/emergency backing service. | Monitoring/operations surfaces look healthier than runtime. | Owner decision: hide, archive, or relabel as construction-only. |
| `SOwnerDistrictPage` placeholder subsections | `lib/features/s_owner/presentation/pages/s_owner_district_page.dart` | UNKNOWN_OWNER_DECISION | Comments say no Firebase writes; many groups are placeholders. | Protected owner routes. | Some owner pages are maps, not live runtime. | Owner dashboard may overstate readiness. | Keep only if Owner wants visible strategic placeholders. |
| `SWebSurfacePage` generic pages | `lib/features/s_web_surfaces/presentation/pages/s_web_surface_pages.dart` | UNKNOWN_OWNER_DECISION | Explicit text: `Signal-first placeholder only`. | Many `/s/city/*`, `/s/capital/*` routes. | Several routes have no data/runtime. | Connected placeholders may become ghost infrastructure. | Classify each route before public testing. |
| Portal request skeletons | `lib/features/web_portal/presentation/pages/portal_skeleton_pages.dart` | GHOST_SURFACE | Routes exist for service/package/contact. | Public portal router. | No repository/service found for requests. | Public user flow may end in nonfunctional page. | Remove/hide or connect intentionally in a later approved phase. |
| `ClientSessionRoomPage` | `lib/features/client/presentation/pages/client_session_room_page.dart` | ACTIVE_SURFACE | Account-free session entry remains current doctrine. | Splash/menu/language route to it. | none. | none. | Do not remove. |

## 4. Ghost Collections / Rules

| Item | File path | Classification | Evidence | Current connection | Missing purpose | Risk if left alive | Recommended action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `saved_destinations` | `firestore.rules`; `SavedDestinationRepository` | OWNER_DECISION | `saveDestination()` writes `sessionId`; `watchSessionDestinations()` exists, but no caller found. | Provider/center save actions write records. | No user-visible session readback journey found. | Write-only session storage and stale analytics. | Immediate removal candidate unless Owner wants session saved list. |
| `signal_aggregates` | `firestore.rules` | RULE_GHOST | Rules allow owner/monitoring read, client writes disabled. | Aggregation models exist. | No active aggregate write service found in this audit. | Empty monitoring read model can imply live aggregates. | Owner decision / focused aggregate audit. |
| `accessibility_resources` | `accessibility_resource.dart` | RULE_GHOST | Model declares collectionName; no Firestore rule block or repository found. | Sample resources are local static data. | Collection has no governed runtime path. | Future collection name can be mistaken as active CMS. | Archive or document as future-only. |
| `ai_policies` | `domain_registry.dart`; `ai_policy_seeder.dart` | OWNER_DECISION | Seeder/dev registry mention; no Firestore rule block found. | Registry room lists it. | Runtime access policy unclear. | Shadow governance collection. | Owner decision. |
| `system_domains` | `firestore.rules`; `DomainStatusService`; `s_registry_room_page.dart` | ACTIVE_COLLECTION | Service reads it; registry room consumes it. | Registry room and seeders. | Purpose is clear. | none. | Do not remove. |
| `provider_contact_requests`, `center_contact_requests` | `firestore.rules`; `ContactRequestRepository` | SESSION_COMPATIBLE | Session request IDs used after hard removal. | Provider/center contact buttons. | Read flow for requester is intentionally absent; support/provider/center ownership needs verification. | Records can accumulate without client self-view. | Keep for now; focused contact lifecycle audit. |
| Firestore indexes for `chat_threads`, `support_requests`, profile change requests, `signal_events` | `firestore.indexes.json` | ACTIVE_COLLECTION | Matched active rules/services. | Active chat/support/declaration/signal flows. | none found. | none. | Do not remove. |

## 5. Ghost Signals

| Item | File path | Classification | Evidence | Current connection | Missing purpose | Risk if left alive | Recommended action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `goal_selected` | `signal_type_registry.dart`; `signal_package_factory.dart`; validators/monitoring | GHOST_SIGNAL | Factory exists; no producer calls outside factory found. | Validators and monitoring accept it. | No current emitter after client identity hard removal. | Monitoring waits for signals no one emits. | Immediate remove candidate or rebind to session room if Owner approves. |
| `interest_selected` | same | GHOST_SIGNAL | No producer calls found. | Accepted by validators/monitoring. | No active emitter. | Stale residential analytics category. | Immediate remove candidate. |
| `accessibility_interest` | same | LEGACY_SIGNAL | No producer calls found; accessibility now has dedicated accessibility signal types. | Accepted by validators/monitoring. | Old bridge from client identity era. | Duplicate accessibility intent model. | Immediate remove candidate. |
| `communication_preference_selected` | same | GHOST_SIGNAL | Factory/registry only; not in aggregation validator output list and no producer found. | Registry/factory. | No producer/consumer. | Pure ghost signal. | Immediate remove candidate. |
| `accessibility_mode_selected` | `accessibility_signal_type.dart` | GHOST_SIGNAL | Type exists; no usage found in hub/list emit contexts. | Accessibility factory supports it. | No UI producer found. | Dead metric. | Remove candidate. |
| `provider_profile_opened`, `center_profile_opened` | details pages and monitoring registry | ACTIVE_SIGNAL | Producers found in details pages; monitoring registry consumes. | Active discovery. | none. | none. | Do not remove. |
| `destination_saved` | saved destination repo and monitoring | OWNER_DECISION | Producer exists, but readback journey absent. | Save buttons. | Clear user-facing purpose after save is weak. | Write-only signal/storage. | Decide with saved destinations block. |
| Accessibility resource signals | accessibility hub/list pages | ACTIVE_SIGNAL | Hub/category/resource opened, saved, broken link producers found. | Accessibility gateway. | none found. | none. | Do not remove. |

## 6. Ghost Assets / YAML

| Item | File path | Classification | Evidence | Current connection | Missing purpose | Risk if left alive | Recommended action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/branding/client_dashboard/**` | assets tree | ARCHIVE_EVIDENCE / REMOVE_CANDIDATE | Files remain on disk; no `pubspec.yaml` bundle entry and no runtime refs found. | None active. | Old client dashboard backgrounds. | Repository clutter and future accidental rebundle. | Archive/delete only after Owner approval. |
| `assets/branding/web_registration/clients/**/client_register.png` | assets tree | ARCHIVE_EVIDENCE / REMOVE_CANDIDATE | Files remain on disk; not bundled; no runtime refs found. | None active. | Old client registration visual. | Same. | Archive/delete after approval. |
| `assets/images/client_dashboard/actions/**` | assets tree | ARCHIVE_EVIDENCE / REMOVE_CANDIDATE | Files remain on disk; not bundled; no runtime refs found. | None active. | Old client dashboard action icons. | Same. | Archive/delete after approval. |
| `assets/images/avatar_client*.png` | assets tree; `chat_page.dart` | OWNER_DECISION | `chat_page.dart` uses `assets/images/avatar_client.png`. | Chat avatar fallback. | Name is client-era, but asset has active chat purpose. | Naming can reintroduce client identity language. | Rename/reclassify in later asset operation, not now. |
| `assets/c5/**` | assets tree | ARCHIVE_EVIDENCE | On disk, not bundled in `pubspec.yaml`. | None found. | C5 booking-era evidence. | Storage clutter. | Do not touch unless Owner approves archive cleanup. |
| `assets/c6_library/**` | assets tree | ARCHIVE_EVIDENCE / OWNER_DECISION | On disk, not directly bundled, while `LibraryPage` uses `assets/images/cat_*` equivalents. | No direct active refs found. | C6 leftovers may be duplicate evidence. | Confusing asset lineage. | Asset audit block. |
| `.github/workflows/firebase-hosting-*.yml` | `.github/` | OWNER_DECISION | Present as untracked from previous sweep; deploy behavior exists. | GitHub action if committed. | Owner has not approved commit. | Accidental deploy workflow activation. | Keep uncommitted until Owner decision. |
| `firebase.json` hosting public `public-landing` | `firebase.json` | ACTIVE_ASSET / OWNER_DECISION | Hosting points to static landing, not Flutter web build output. | Firebase hosting config. | Owner must decide landing vs Flutter hosting target. | Wrong deployed surface. | Firebase sweep before deploy. |

YAML config notes:

- `l10n.yaml` and `analysis_options.yaml` have no ghost asset references.
- `pubspec.yaml` no longer bundles old client dashboard/register assets.

## 7. Ghost Roles / Authority

| Item | File path | Classification | Evidence | Current connection | Missing purpose | Risk if left alive | Recommended action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `owner` | rules/router/auth | ACTIVE_AUTHORITY | Protected owner routes and rules. | Owner governance. | none. | none. | Do not touch. |
| `monitoring_operator` | rules/router/auth | ACTIVE_AUTHORITY | Monitoring route guards and signal aggregate rules. | Monitoring. | Aggregate write lifecycle incomplete. | Partial observability. | Keep; audit aggregates separately. |
| `registry_steward` | rules/router/auth | ACTIVE_AUTHORITY | Registry route guard and `system_domains` reads. | Registry room. | none. | none. | Do not touch. |
| `declaration_reviewer` | rules/router/auth | ACTIVE_AUTHORITY | Declaration room and profile review rules. | Provider/center readiness review. | none. | none. | Do not touch. |
| `support_observer` | rules/router/auth | ACTIVE_AUTHORITY | Support room, escalations, contact request reads. | Support observation. | none. | none. | Do not touch. |
| `clinician`, `center` | rules/router/auth/storage | ACTIVE_AUTHORITY | Provider/center identity preserved. | Registration, rooms, profile requests. | none. | none. | Do not touch. |
| `client` auth role | active runtime | ARCHIVED | No `RoleNames.client`, `_roleClient`, `isClient()`, or rules role check found. | Historical docs only. | none in runtime. | Reintroduction risk from docs/assets. | Keep archived, do not restore. |

## 8. Ghost Localization

| Item | File path | Classification | Evidence | Current connection | Missing purpose | Risk if left alive | Recommended action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `centerRequestViaAdmin` | `lib/l10n/*.arb`; generated localizations | LOCALIZATION_GHOST | Key name says Admin, value now says contact center. | May still be referenced by center details. | Name is admin-era residue. | Admin doctrine confusion. | Rename in localization cleanup phase. |
| `clientSupport`, `clientSupportRequests`, `clientLinksAndCodes`, `clientRatingsCount`, `clientAverageStars`, `clientOverallAverage` | `lib/l10n/*.arb`; generated localizations | LOCALIZATION_GHOST | Keys remain after client identity hard removal. | Some may be unused or provider dashboard legacy copy. | Key namespace is client-era. | Future developers may infer client account layer exists. | Localization residue audit/removal block. |
| `booking/payment` keys | `lib/l10n` | DOC_SAFE / NOT_FOUND_ACTIVE | Targeted search did not find active ARB booking/payment keys. | none. | none. | none. | No action. |

## 9. Safe Archive / Doc History

Do not touch:

- `docs/audits/**` forensic history.
- `mental-smile-os-workspace` archive/history.
- Archive cards and historical registries that preserve past truth.
- C5/C6 assets unless Owner approves an asset archive cleanup.
- Historical references to `clients` or client registration in audit reports.

## 10. Owner Decisions Required

1. Whether S City future routes (`tools`, `programs`, `marketplace`) stay visible before implementation.
2. Whether Capital placeholder routes stay visible before live operational data.
3. Whether Owner placeholder routes stay visible as strategic maps.
4. Whether public portal request routes should be hidden until backed by a real intake flow.
5. Whether `saved_destinations` should remain session-scoped or be removed.
6. Whether `destination_saved` should remain while saved destination readback is absent.
7. Whether old residential signals should be removed or rebound to session room.
8. Whether `.github` Firebase workflows should be committed, held, or deleted.
9. Whether Firebase hosting should serve `public-landing` or Flutter web output.
10. Whether client-named active chat avatar should be renamed.
11. Whether localization client/admin residue should be removed in a dedicated l10n pass.

## 11. Immediate Remove Candidates

These are candidates only; no removal was performed.

| Candidate | Type | Reason |
| --- | --- | --- |
| `communication_preference_selected` | Signal | No producer or consumer found beyond registry/factory. |
| `goal_selected` | Signal | No active producer found after client identity hard removal. |
| `interest_selected` | Signal | No active producer found. |
| `accessibility_interest` | Signal | Superseded by dedicated accessibility signals; no active producer found. |
| `accessibility_mode_selected` | Signal | Type exists; no producer found. |
| `/s/capital/incidents` | Route/page | Placeholder only; no data source found. |
| `/s/capital/maintenance` | Route/page | Placeholder only. |
| `/s/capital/broadcasts` | Route/page | Placeholder only. |
| `/s/capital/emergency-brief` | Route/page | High-trust placeholder, not connected. |
| `/request/service` | Public route | No runtime request flow found. |
| `/request/package` | Public route | No runtime request flow found. |
| `assets/branding/client_dashboard/**` | Asset | No bundle/ref found; old client dashboard evidence. |
| `assets/branding/web_registration/clients/**` | Asset | No bundle/ref found; old client registration evidence. |
| `assets/images/client_dashboard/actions/**` | Asset | No bundle/ref found; old client dashboard actions. |

Immediate remove candidates count: 14

## 12. Do Not Touch List

- Provider identity and routes.
- Center identity and routes.
- Owner identity and protected owner routes.
- Monitoring identity and protected monitoring routes.
- Registry steward, declaration reviewer, support observer authority.
- Chat/support/escalation collections and rules.
- Forensic reports and archive history.
- `mental-smile-os-workspace` archive/history.
- Accessibility hub, organization directory, and resource gateway.

## 13. Risk if Left Alive

- Placeholder authority routes can make the platform look operational when they are not connected to data.
- Old residential signals can keep monitoring schemas waiting for events that no longer exist.
- Session saved destinations can become write-only storage.
- Client-named localization and asset residue can invite reintroduction of account-based client identity.
- Public portal request routes can look like live intake without a governed backend.

## 14. Recommended Removal Blocks

1. Signal Purity Block:
   - Remove or rebind ghost residential signals.
   - Update validators, monitoring registries, and aggregate adapters.

2. Placeholder Route Visibility Block:
   - Hide/archive empty S Capital and public portal request routes or label them construction-only.

3. Session Saved Destination Block:
   - Decide whether saved destinations are kept, exposed as session readback, or removed.

4. Asset Evidence Cleanup Block:
   - Remove unbundled old client dashboard/register assets only after archive approval.

5. Localization Residue Block:
   - Rename/remove `centerRequestViaAdmin` and client-namespaced keys.

6. Firebase Hosting/Workflow Block:
   - Decide `.github` workflow state and hosting target before deploy.

## Final Verdict

GHOST_INFRASTRUCTURE_FOUND

