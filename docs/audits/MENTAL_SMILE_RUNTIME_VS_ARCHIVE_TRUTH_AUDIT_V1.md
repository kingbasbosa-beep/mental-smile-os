# Mental Smile Runtime Vs Archive Truth Audit V1

Status: FORENSIC_AUDIT_COMPLETE
Date: 2026-06-17
Scope: `lib/`, `assets/`, `pubspec.yaml`, `firestore.rules`, `docs/`, `mental-smile-os-workspace/`, archive cards, guides, prompts, reports, snapshots, routes, collections, assets, signals, and localization evidence.
Runtime effect: none
Firebase effect: none
Git effect: none

## 1. Executive Summary

This audit confirms that the Client Registration drift is not fully isolated. Several governance drift pockets exist across the platform, with one major proven runtime/documentation mismatch and multiple medium-risk partial or known drift areas.

The strongest contradiction is still Client Registration: documentation and prompt cards classify the old registration screen as removed/rebuild-only, while `/register/client` still renders the old heavy `ClientRegisterPage`, persists avatars and pre-account signals, and emits registration-origin signals.

Other drift pockets are more bounded:

- Provider/Clinician naming drift remains active in routes, portal copy, contact request naming, signal names, and localization.
- The route inventory already labels `/register/provider` as `LEGACY`, but the route still actively maps to clinician registration.
- Public city routes for tools, marketplace, programs, organizations, reports, trust/safety, and departments are active placeholder surfaces, while docs identify missing tool/commercial signal governance.
- Booking/payment/session core does not appear as an active collection or route, but pricing, service time, `per_session`, and `home_visit_sessions` language still exists in center/clinician registration and center pricing models.
- Admin Zero doctrine is mostly enforced as role-specific governance, but `centerRequestViaAdmin` remains in localization keys and old admin terminology remains documented as active residue to classify.
- Accessibility was over-executed from a plan request into scaffold + route + signals and is explicitly held for Owner review.
- Reports and snapshots often truthfully record architecture/domain status, but some pass/completion language can mask UX-level runtime mismatch because earlier audits were not full runtime/doctrine audits.

Final verdict: B. Several governance drift pockets exist.

Important nuance: one pocket is major (`/register/client`), but the whole system is not proven to be globally contradictory. Most other cases are known transitional aliases, placeholder surfaces, archive survivals, or governance gaps already documented.

## 2. Investigation Method

Runtime evidence came from:

- `lib/app/router/routes.dart`
- `lib/app/router/app_router.dart`
- Runtime page files under `lib/features/**`
- Firestore collection writes and rules
- Signal factories and storage
- Asset references and `pubspec.yaml`
- Localization generated files and ARB files

Documentation evidence came from:

- `docs/constitutional-baseline/**`
- `docs/strategic-room/**`
- `docs/audits/CLIENT_REGISTRATION_FORENSIC_AUDIT_V1.md`
- `docs/accessibility/**`
- `mental-smile-os-workspace/docs/mental-smile-os/**`

Search families used:

- Runtime/routes: `Routes.`, `case Routes`, `register`, `dashboard`, `booking`, `session`, `payment`, `request`, `signal`, `avatar`, `goals`, `interests`
- Doctrine/archive: `REMOVE`, `ARCHIVE`, `LEGACY`, `FROZEN`, `DEPRECATED`, `REPLACE`, `SIMPLIFY`, `MUST NOT`, `old screen`, `source classification`, `recreation prompt`, `C5`, `C6`
- Arabic/UI terms: registration, goals, interests, avatar, booking, payment, admin, monitoring, owner, client room terms

No code was fixed. No formatting, deploy, commit, push, or tag was performed.

## 3. Route Reality Map

Primary route constants are defined in `lib/app/router/routes.dart`. Runtime routing is implemented in `lib/app/router/app_router.dart`.

| Route | Active page/widget | Doctrine status | Legacy risk | Evidence |
| --- | --- | --- | --- | --- |
| `/` | `PortalHomePage` | Public portal | Low | `Routes.portalHome`, `AppRouter` |
| `/about` | `PortalAboutPage` | Public portal | Low | `Routes.portalAbout` |
| `/library` | `LibraryPage` | Library active | Low/Medium C6 lineage | `portalLibrary -> LibraryPage` |
| `/register/provider` | `WebClinicianRegisterPortalPage` | Transitional alias | Medium | Route inventory marks `LEGACY`; provider maps to clinician |
| `/request/service` | `PortalServiceRequestPage` | Contact/request, not booking | Medium | Commercial discovery boundary needed |
| `/request/package` | `PortalPackageRequestPage` | Contact/request, not booking | Medium | Commercial discovery boundary needed |
| `/contact` | `PortalContactPage` | Public contact | Low | Portal route |
| `/splash` | `SplashPage` | Active | Low | App route |
| `/s` | `SSurfaceIndexPage` | Signal-first index | Low | S route |
| `/s/personal-space` | `SPersonalSpacePage` | Active continuity/personal signals | Medium | Reads `clients.clientSignals`; impacted by registration drift |
| `/s/support-room` | `SSupportRoomPage` | Scoped support observer | Medium | Cross-domain support/monitoring boundary |
| `/s/registry-room` | `SRegistryRoomPage` | Scoped registry | Low | Governance route |
| `/s/declaration-review-room` | `SDeclarationReviewRoomPage` | Active review/readiness surface | Medium | Missing dedicated declaration review registry noted |
| `/s/city` | `SCityDistrictPage` | City district active | Low | City route |
| `/s/city/services` | `_sWebSurfaceRoute` placeholder | Future catalog | Medium | Placeholder route active |
| `/s/city/tools` | `_sWebSurfaceRoute` placeholder | Future tools | High | Commercial findings: tool registry unknown/missing |
| `/s/city/library` | `_sWebSurfaceRoute` placeholder | Future public library | Low/Medium | Placeholder route active |
| `/s/city/providers` | `_sWebSurfaceRoute` placeholder | Provider naming transitional | Medium | Provider/clinician drift |
| `/s/city/centers` | `_sWebSurfaceRoute` placeholder | Center discovery future | Low/Medium | Placeholder route active |
| `/s/city/organizations` | `_sWebSurfaceRoute` placeholder | Unknown maturity | Medium | Route inventory `UNKNOWN` |
| `/s/city/programs` | `_sWebSurfaceRoute` placeholder | Unknown maturity | Medium | Route inventory `UNKNOWN` |
| `/s/city/marketplace` | `_sWebSurfaceRoute` placeholder | Marketplace future | High | Booking/marketplace regression risk |
| `/s/capital` | `SCapitalOperationsOfficePage` | Monitoring/capital | Low/Medium | Monitoring should observe not control |
| `/s/capital/operations-office` | `SCapitalOperationsOfficePage` focus | Monitoring/capital | Low/Medium | Active |
| `/s/capital/incidents` | `SCapitalOperationsOfficePage` focus | Monitoring/capital | Low/Medium | Active |
| `/s/capital/maintenance` | `SCapitalOperationsOfficePage` focus | Monitoring/capital | Low/Medium | Active |
| `/s/capital/broadcasts` | `SCapitalOperationsOfficePage` focus | Monitoring/capital | Low/Medium | Active |
| `/s/capital/emergency-brief` | `SCapitalOperationsOfficePage` focus | Monitoring/capital | Low/Medium | Active |
| `/s/capital/signal-monitoring-room` | `SSignalMonitoringRoomPage` | Monitoring active | Medium | Monitoring authority boundary |
| `/s/capital/departments` | `_sWebSurfaceRoute` placeholder | Future departments | Medium | Active placeholder |
| `/s/capital/trust-safety` | `_sWebSurfaceRoute` placeholder | Future trust/safety | Medium | Active placeholder |
| `/s/capital/reports` | `_sWebSurfaceRoute` placeholder | Future reports | Medium | Active placeholder |
| `/s/owner` | `SOwnerDistrictPage` | Owner-governed | Low/Medium | Protected owner route |
| `/s/owner/room` | `SOwnerDistrictPage` focus | Owner-governed | Low/Medium | Protected |
| `/s/owner/sovereign-intelligence` | `SOwnerDistrictPage` focus | Owner-governed | Low/Medium | Protected |
| `/s/owner/strategic-memory` | `SOwnerDistrictPage` focus | Owner-governed | Low | Protected |
| `/s/owner/sovereign-vault` | `SOwnerDistrictPage` focus | Owner-governed | Low | Protected |
| `/s/owner/constitutional-memory` | `SOwnerDistrictPage` focus | Owner-governed | Low | Protected |
| `/s/owner/recovery-console` | `SOwnerDistrictPage` focus | Owner-governed | Medium | Powerful concept; protected |
| `/s/owner/capsules` | `SOwnerDistrictPage` focus | Owner-governed | Low/Medium | Protected |
| `/s/owner/regeneration` | `SOwnerDistrictPage` focus | Owner-governed | Low/Medium | Protected |
| `/owner/os/construction-workbench` | `SovereignConstructionWorkbenchPage` | Owner construction | Medium | Tool registry includes forbidden-use constraints |
| `/web/center/register` | `WebCenterRegisterPortalPage` | Declaration registration | Medium | Writes `centers`; includes pricing/capabilities |
| `/web/center/profile` | `WebCenterProfilePage` | Declaration step | Medium | Direct `centers` updates |
| `/web/center/media` | `WebCenterMediaPage` | Declaration step | Low/Medium | Direct `centers` updates |
| `/web/center/pricing` | `WebCenterPricingPage` | Service cost disclosure | Medium | Pricing/session-like terminology risk |
| `/web/center/documents` | `WebCenterDocumentsPage` | Documents/readiness | Medium | Declaration readiness |
| `/web/clinician/register` | `WebClinicianRegisterPortalPage` | Declaration registration | Medium | Writes `clinicians`; readiness signals |
| `/web/clinician/profile` | `WebClinicianProfilePage` | Declaration step | Medium | Direct `clinicians` updates |
| `/web/clinician/documents` | `WebClinicianDocumentsPage` | Documents/readiness | Medium | Declaration readiness |
| `/web/library` | `LibraryPage` | Active library | Low/Medium | C6 lineage comments/assets retained safely |
| `/web/library/policy` | `LibraryPolicyPage` | Library policy | Low | Active |
| `/web/register/success` | `WebRegistrationSuccessPage` | Registration status | Low/Medium | Readiness language |
| `/language` | `MkLanguagePage` | Language/registration entry | Low | Active |
| `/home` | `MenuPage` | Alias to menu | Low | Route inventory `ALIAS` |
| `/login` | `LoginPage` | Active login | Low/Medium | Uses role routing/readiness gate |
| `/app/exit-social-links` | `AppExitSocialLinksPage` | Exit/social | Low | Active |
| `/account-blocked` | `AccountBlockedPage` | Account access | Medium | Protected account fields |
| `/menu` | `MenuPage` | Operational menu | Medium | Uses old avatar visual in menu |
| `/accessibility` | `AccessibilityHubPage` / `AccessibilityResourceListPage` | Held for Owner review | High until approved | Over-executed scaffold report |
| `/register/client` | `ClientRegisterPage` | Contradicts simplified doctrine | High | Client Registration forensic audit |
| `/register/clinician` | `WebClinicianRegisterPortalPage` | Alias | Medium | Duplicate route alias |
| `/register/center` | `WebCenterRegisterPortalPage` | Alias | Medium | Duplicate route alias |
| `/clinician/room` | `ClinicianRoomPage` | Active clinician room | Medium | Profile change requests, direct collection reads |
| `/clinician/profile-edit-request` | `ClinicianProfileEditRequestPage` | Protected edit request | Medium | Active declaration change |
| `/clinician/chat-inbox` | `ClinicianChatInboxPage` | Protected inbox | Medium | Chat escalation/recommendation boundary |
| `/client/dashboard` | `ClientDashboardPage` | Active, hybrid | High | Reads legacy registration `avatarAsset` and `clientSignals` |
| `/center/dashboard` | `CenterDashboardPage` | Active | Medium | Center role/readiness |
| `/center/room` | `CenterRoomPage` | Active | Medium | Pricing/profile change requests |
| `/center/profile-edit-request` | `CenterProfileEditRequestPage` | Protected edit request | Medium | Active declaration change |
| `/chat` | `ChatPage` | Support/guidance only | Medium | Explicitly rejects pricing/contracts changes |
| `/chat/escalations` | `ChatEscalationsPage` | Monitoring/safety | Medium | Cross-domain authority boundary |
| `/chat/escalation/report` | `ChatEscalationReportPage` | Monitoring report | Medium | Cross-domain authority boundary |
| `/module/addiction` | `SupportEntryPage.addiction` | Support path | Medium | Sensitive domain, no booking |
| `/module/special_needs` | `SupportEntryPage.specialNeeds` | Support path | Medium | Language/doctrine review |
| `/module/support-issue-selector` | `SupportIssueSelectorPage` | Structured support | Medium | Writes `support_requests` |
| `/module/specialists` | `SpecialistsCategoriesPage` | Commercial discovery | Medium | Provider/clinician language |
| `/module/specialists/list` | `SpecialistsListPage` | Commercial discovery | Medium | Reads `clinicians` |
| `/module/specialists/details` | `SpecialistDetailsPage` | Commercial discovery/contact | Medium | Contact request, save destination |
| `/module/centers` | `CentersLandingPage` | Commercial discovery | Medium | Center discovery |
| `/module/centers/list` | `CentersListPage` | Commercial discovery | Medium | Center discovery |
| `/module/centers/details` | `CenterDetailsPage` | Commercial discovery/contact | Medium | Contact request, pricing display |
| `/module/library` | `LibraryPage` | Active library | Low/Medium | C6 lineage preserved |

## 4. Surface Doctrine Comparison

| Surface | Current runtime behavior | Current doctrine from docs/cards | Status |
| --- | --- | --- | --- |
| Client registration | Heavy form, avatars, goals/interests/accessibility signals, Firestore write, signal emit | Simplified registration; no avatar/interests/profile data; old screen `REMOVE` | Contradiction |
| Clinician/provider registration | Provider route maps to clinician registration; writes declarations/readiness | Provider/clinician transitional aliases only until naming guide | Partial match |
| Center registration | Multi-step declaration with media/pricing/documents/readiness | Declaration/readiness, not admin approval | Partial match |
| Login | Role routing to client/clinician/center/owner/monitoring surfaces | Role boundaries through AccountAccessService and rules | Match with terminology risks |
| Client dashboard | Reads avatar and client signals from registration; saved destinations; tool cards | Client room/personal space should be post-registration personalization | Hybrid / partial contradiction |
| Personal space | Reads client signals and preferences | Continuity layer, not generic dashboard | Partial match, affected by registration drift |
| Provider/specialist discovery | Uses clinicians collection but provider terminology persists in portal/contact routes | Provider/clinician drift must be governed | Partial match |
| Center discovery | Contact request, pricing display, save destination | Discovery/contact not booking/payment/session | Partial match |
| Library | C6 lineage comments, active library cards, category signals | C6 historical evidence preserved, active assets purified | Mostly match |
| Tools/marketplace/city placeholders | Active placeholder routes | Tool registry/commercial signal ownership unknown | Partial / governance gap |
| Saved destinations | Saves providers/centers/resources; emits `destination_saved` | Residential collection active | Match |
| Contact requests | Writes provider/center contact request docs; emits contact signals | Contact requests allowed but must not become booking | Match with booking regression risk |
| Booking/payment/session | No route/collection found; pricing/time words exist | Booking/payment/session lifecycle forbidden | Mostly match with language residues |
| Admin residue | Role-specific owner/monitoring/declaration gates; `centerRequestViaAdmin` key remains | Admin Zero; admin terminology must be classified | Partial match |
| Monitoring Room | Observes signals/escalations; protected role | Monitoring observes, not hidden admin | Partial match |
| Owner Room | Protected owner routes and workbench | Owner governance, not generic admin | Partial match |
| Accessibility layer | Scaffold + route + signals exists | Owner requested plan; scaffold held for review | Held / not approved |
| Localization | Generated and inline strings mixed; provider/admin/session/client terms remain | Localization registries recommended | Drift / partial |

## 5. Documentation Decision Ledger

| Decision | Source document/card/prompt | Expected runtime change | Implemented | Evidence |
| --- | --- | --- | --- | --- |
| Old client registration screen should be removed/rebuilt | `CLIENT_REGISTRATION_SOURCE_CLASSIFICATION_V1.md` | `/register/client` no longer uses old heavy screen | No | Router still builds `ClientRegisterPage` |
| Client registration should have no name/avatar/interests/profile data | `CLIENT_REGISTRATION_RECREATION_PROMPT_CARD_V1.md` | Minimal form only | No | Active form has name, avatars, goals/interests |
| Goal/interest registration signals need Owner review | `CLIENT_REGISTRATION_FIELD_REVIEW_QUEUE_V1.md` | Not finalized into runtime | No | Already runtime persisted/emitted |
| Booking/payment/session lifecycle must not enter runtime | `ARCHIVE_CARD_BOOKING_EXTRACTION_V1.md` | No booking/payment/session collections/routes | Mostly yes | No booking route/collection; pricing/session terms remain |
| Admin authority must not return | `ARCHIVE_CARD_ADMIN_ZERO_TRANSITION_V1.md` | Role-scoped Owner/Monitoring/Declaration surfaces | Partial yes | Role gates exist; admin key/copy remains |
| Provider/clinician are transitional aliases | `ARCHIVE_CARD_PROVIDER_VS_CLINICIAN_V1.md` | Route/copy aliases governed | Partial | `/register/provider` active alias to clinician; provider contact request names remain |
| C5/C6 active paths purified | `PHASE_3_PRE_BASELINE_PURIFICATION_EXECUTION_RESULT_V1.md` | Runtime uses `assets/images` survivor copies, not `assets/c5`/`assets/c6_library` | Mostly yes | Chat/library use `assets/images`; registration extra avatars still bundled |
| C6 category cards retained | Phase 3 and asset inventory | Six library cards active | Yes | `assets/images/cat_*.png`, `LibraryPage` |
| Client mobile registration image remains active exception | Phase 3 and asset inventory | Only `assets/branding/web_registration/clients/mobile/client_register.png` bundled | Yes | `pubspec.yaml` and client registration page |
| Residential signal ownership registry needed | `RESIDENTIAL_FINDINGS_REPORT_V1.md` | Dedicated registry before future expansion | Partial/unknown | Signals active across registration, saved, support, chat |
| Tool registry / commercial signal ownership unknown | `COMMERCIAL_FINDINGS_REPORT_V1.md` | Tool registry materialized before tools expansion | Unknown/no | Active placeholder tool routes exist |
| Declaration Review Registry missing | `ADMINISTRATIVE_FINDINGS_REPORT_V1.md` | Registry materialized before expansion | Partial/unknown | Declaration review room active |
| Accessibility Directory V1 should be plan/scaffold held | `ACCESSIBILITY_OPERATION_REGISTRATION_REPORT_V1.md` | No commit until format/analyze/Owner approval | Held | Route/scaffold exists but report says held |

## 6. Legacy Runtime Pockets

| Runtime file | Legacy/drift evidence | Risk |
| --- | --- | --- |
| `lib/features/auth/presentation/pages/client_register_page.dart` | Old heavy registration, avatar selection, pre-account signals | High |
| `lib/features/client/presentation/pages/client_dashboard_page.dart` | Reads `avatarAsset` and registration `clientSignals`; "learning shaped by your interests" | High |
| `lib/features/s_personal_space/presentation/pages/s_personal_space_page.dart` | Reads registration-origin signal groups and completeness | Medium |
| `lib/features/home/presentation/pages/menu_page.dart` | Runtime uses `assets/images/avatar_clinician_male.png` profile/avatar visual | Medium |
| `lib/features/web_portal/presentation/pages/portal_skeleton_pages.dart` | Provider route/copy (`Register as Provider`, `Provider / center name`) | Medium |
| `lib/features/contact_requests/data/contact_request_repository.dart` | Provider contact naming persists | Medium |
| `lib/features/centers/presentation/pages/center_details_page.dart` | Pricing displayed in discovery; bounded but booking-adjacent | Medium |
| `lib/features/centers/data/models/center_pricing.dart` | `home_visit_sessions`, pricing units | Medium |
| `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart` | Cost/service disclosure step; allowed but booking-adjacent | Medium |
| `lib/features/accessibility/**` | Over-executed scaffold held for Owner review | High until approved |

## 7. Archive Leakage / Archive Survival

| Item | Type | Intended classification | Runtime status | Assessment |
| --- | --- | --- | --- | --- |
| `assets/images/avatar_client.png` | Asset | Retained C5 survivor for chat | Active runtime | Intentional survival |
| `assets/images/cat_*.png` | Assets | Retained C6 category cards | Active runtime | Intentional survival |
| `assets/c5/**` | Assets | Archive evidence | Present on disk, not bundled directly | Archive survival |
| `assets/c6_library/**` | Assets | Archive evidence | Present on disk, not bundled directly | Archive survival |
| `assets/images/avatar_client_fmale.png` and related | Assets | Not clearly retained by archive cards | Bundled and runtime in registration | Possible leakage |
| `assets/branding/web_registration/clients/mobile/client_register.png` | Asset | Active exception | Bundled and runtime | Intentional survival |
| Provider terminology | Naming/model | Transitional alias | Active in route/copy/signals | Known drift |
| `centerRequestViaAdmin` | Localization key | Admin terminology should be classified | Active generated key | Admin residue |
| `per_session`, `home_visit_sessions` | Pricing/session terms | Booking/session lifecycle forbidden | Active code terms | Language/model drift, not full session lifecycle |

## 8. Prompt vs Execution Gap

| Prompt/card | Intent | Runtime execution state |
| --- | --- | --- |
| `CLIENT_REGISTRATION_RECREATION_PROMPT_CARD_V1.md` | Minimal client registration visual package | Not implemented; old page remains |
| `CLIENT_REGISTRATION_VISUAL_ASSET_CARD_V1.md` | Package assets only, not runtime-ready | Not reflected in active `/register/client` |
| `CLIENT_REGISTRATION_SOURCE_CLASSIFICATION_V1.md` | Old screen `REMOVE` | Not executed |
| Provider/center no-dead-placeholder docs | Future runtime should avoid placeholders | Several public city/capital placeholders active |
| Accessibility Directory plan | Plan requested | Scaffold executed and held for Owner review |
| Tool/city marketplace route concepts | Future catalog placeholders | Routes exist but governance incomplete/unknown |

## 9. Snapshot / Report Contradictions

| Report/snapshot | Claim / implication | Runtime contradiction or nuance |
| --- | --- | --- |
| `TOPOLOGY_SNAPSHOT_V1.md` | C5/C6 active runtime paths purified in Phase 3 | True for direct C5/C6 paths, but not enough to catch registration avatar-selection doctrine drift |
| `PHASE_3_PRE_BASELINE_PURIFICATION_EXECUTION_RESULT_V1.md` | C5/C6 runtime asset paths purified | Mostly true; extra `assets/images/avatar_*` runtime selection remains outside the C5/C6 direct-path check |
| `ADMINISTRATIVE_ROUTE_HEALTH_REPORT_V1.md` | `/register/client` active/pass | Route health pass does not mean doctrine pass |
| `ADMINISTRATIVE_ARCHITECTURE_REPORT_V1.md` | Client registration active/pass | Architecture presence pass masked old-screen doctrine contradiction |
| `RESIDENTIAL_ASSET_USAGE_REPORT_V1.md` | Residential asset usage mostly clean | True for audited assets; did not classify client registration avatar choices |
| `PURE_DNA_V2_SEAL_REPORT_V1.md` | Asset contamination reduced | True at archive/path level; runtime UX drift remained |
| `ACCESSIBILITY_OPERATION_REGISTRATION_REPORT_V1.md` | Accessibility held for review | Accurate after correction; scaffold exists but not approved |

## 10. Signal Drift

Active signal sources found:

- `client_registration`: goal, interest, accessibility, communication signals from old client registration.
- `saved_destinations`: `destination_saved`.
- `provider_contact_requests`: `provider_contact_started`.
- `center_contact_requests`: `center_contact_started`.
- `support_requests`: `support_started`.
- `library`: `library_category_opened`.
- `provider_discovery`: `provider_profile_opened`.
- `center_discovery`: `center_profile_opened`.
- `accessibility`: accessibility scaffold signals, held for Owner review.

Drift findings:

- High: `client_registration` emits heavy pre-account signals from an old screen that docs say should be rebuilt.
- Medium: Provider/clinician naming persists in `providerContactStarted` and provider contact request collections while runtime role identity is clinician.
- Medium: Accessibility signals exist from a scaffold explicitly held for review.
- Low/Medium: Library signals align with active LibraryPage and C6 survivor doctrine.

## 11. Collection Drift

Active collections from inventory and rules:

- `clients`
- `clinicians`
- `centers`
- `saved_destinations`
- `support_requests`
- `chat_threads`
- `chat_threads/{id}/messages`
- `chat_escalations`
- `chat_escalations/{id}/reports`
- `signal_events`
- `clinician_profile_change_requests`
- `center_profile_change_requests`
- `provider_contact_requests`
- `center_contact_requests`
- `system_domains`

Drift findings:

- High: `clients` allows and stores `avatarAsset`, `clientSignals`, `privacyPreferences`, `roomPreferences`, `enabledToolKeys`, and room/schema fields. This is compatible with personal-space doctrine but contradicts the current old registration source when populated before account trust is established.
- Medium: `provider_contact_requests` uses provider naming while clinician is the runtime professional role.
- Medium: `centers` includes pricing readiness and detailed costs. This is declaration/service disclosure, not payment, but booking-adjacent language must remain bounded.
- Low/Medium: `signal_events` correctly restricts creates to actor id and known schema fields, but old signal sources can still produce valid events.
- No active booking/payment collection was found.

## 12. Asset Drift

Asset evidence:

- `pubspec.yaml` bundles `assets/images/`.
- `pubspec.yaml` bundles `assets/branding/web_registration/clients/mobile/client_register.png`.
- `assets/images/avatar_client.png` is an intentional chat survivor.
- Six `assets/images/cat_*.png` are intentional C6 library survivors.
- Four registration avatar assets are active through `ClientRegisterPage` and dashboard rendering.
- `assets/c5/` and `assets/c6_library/` remain archive evidence, not direct runtime bundle entries.

Asset drift:

- High/Medium: registration avatar options remain active under `assets/images/` and are persisted into `clients.avatarAsset`.
- Medium: `MenuPage` uses `assets/images/avatar_clinician_male.png`.
- Low: Library C6 survivor cards are active intentionally.
- Low: client mobile registration background is active intentionally as a known exception, but attached to old heavy runtime screen.

## 13. Localization Drift

Localization evidence:

- `authClientRegister`: "Create client account" / Arabic equivalent.
- `centerRequestViaAdmin`: "Contact this center" but key name preserves `Admin`.
- `webClinicianSessionPrice`: "Service cost information".
- `webClinicianSessionDuration`: "Service time information".
- `clinicianAcceptRequest`: "Confirm readiness".
- `clinicianRejectRequest`: "Mark incomplete".
- Several old `Reject` keys now map to "Mark incomplete", showing partial terminology migration.
- Inline strings remain across major screens, especially residential and registration surfaces.

Localization drift assessment:

- Medium: provider/clinician, client, admin, session, and support terms are not fully centralized.
- Medium: generated key names retain old concepts even when visible strings are improved.
- Low/Medium: inline bilingual copy makes doctrine review harder.

## 14. Root Cause Analysis

The likely historical pattern is:

1. Documentation-first governance created accurate decisions, archive cards, recreation prompts, and classification records.
2. Some infrastructure-level cleanup happened, especially asset path purification and archive card materialization.
3. Route health and architecture audits verified that routes existed and were protected, but did not always validate screen-level doctrine.
4. Old widgets remained connected to active routes, especially `/register/client`.
5. Some reports marked pass/completion for architecture, inventory, or asset-path criteria, while runtime UX criteria remained out of scope.
6. Transitional aliases were kept intentionally, but some became long-lived active drift pockets.
7. Analyzer/build passing would not detect doctrine mismatch because the code is syntactically valid and functionally connected.
8. New scaffold work, such as accessibility, could be created before governance approval unless operation mode is strictly enforced.

## 15. Risk Classification

| Finding | Risk |
| --- | --- |
| Client registration old heavy screen active despite removal/simplification docs | Critical |
| Pre-account client signal capture and emission | High |
| Client dashboard/personal space depend on registration-origin signals | High |
| Accessibility scaffold route/signals exist while held for Owner review | High |
| Provider/clinician naming drift in route/copy/collections/signals | Medium |
| Public tools/marketplace placeholders active before tool registry maturity | Medium |
| Center pricing/session-like terminology | Medium |
| Admin terminology residue in localization keys | Medium |
| Contact requests could become booking-like if expanded without governance | Medium |
| C5/C6 survivor assets retained intentionally | Historical only / Low |
| Archive folders present on disk | Historical only |
| Library C6 lineage comments | Low |
| Owner/Monitoring protected routes with strong labels | Low/Medium |

## 16. Recommended Next Investigations

These are investigations, not fixes:

1. Full Client Registration replacement readiness audit.
2. Client Dashboard and Personal Space signal-origin audit.
3. Provider/Clinician terminology migration map.
4. Contact Request vs Booking boundary audit.
5. Center pricing/service-time language audit.
6. Accessibility scaffold approval/readiness audit.
7. Placeholder route maturity audit for `/s/city/*` and `/s/capital/*`.
8. Localization key-name doctrine audit, not only visible text audit.
9. Firestore field doctrine audit for `clients`, `clinicians`, `centers`, and `signal_events`.
10. Asset registry audit for all `assets/images/avatar_*` runtime references.

## 17. Final Verdict

B. Several governance drift pockets exist.

Rationale:

- The client registration mismatch is major and proven.
- Provider/clinician naming drift, placeholder route maturity, client signal origin, avatar survival, pricing/session wording, and admin key residue are real but vary in severity.
- Booking/payment/session core appears mostly successfully extracted.
- C5/C6 archive survival is mostly intentional, not accidental.
- Accessibility scaffold is not approved completion; it is already held for Owner review.

## 18. Evidence Appendix

### Runtime evidence

- `lib/app/router/routes.dart`
- `lib/app/router/app_router.dart`
- `lib/features/auth/presentation/pages/client_register_page.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/s_personal_space/presentation/pages/s_personal_space_page.dart`
- `lib/features/web_portal/presentation/pages/portal_skeleton_pages.dart`
- `lib/features/contact_requests/data/contact_request_repository.dart`
- `lib/features/saved_destinations/data/saved_destination_repository.dart`
- `lib/features/signals/domain/factories/signal_package_factory.dart`
- `lib/features/signals/data/services/signal_storage_service.dart`
- `lib/features/centers/data/models/center_pricing.dart`
- `lib/features/centers/presentation/pages/center_details_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart`
- `firestore.rules`
- `pubspec.yaml`

### Documentation evidence

- `docs/audits/CLIENT_REGISTRATION_FORENSIC_AUDIT_V1.md`
- `docs/accessibility/ACCESSIBILITY_OPERATION_REGISTRATION_REPORT_V1.md`
- `docs/constitutional-baseline/inventory/ROUTES_INVENTORY_V1.md`
- `docs/constitutional-baseline/inventory/COLLECTIONS_INVENTORY_V1.md`
- `docs/constitutional-baseline/inventory/ASSETS_INVENTORY_V1.md`
- `docs/constitutional-baseline/cards/archive/ARCHIVE_CARD_BOOKING_EXTRACTION_V1.md`
- `docs/constitutional-baseline/cards/archive/ARCHIVE_CARD_ADMIN_ZERO_TRANSITION_V1.md`
- `docs/constitutional-baseline/cards/archive/ARCHIVE_CARD_PROVIDER_VS_CLINICIAN_V1.md`
- `docs/constitutional-baseline/operations/PHASE_3_PRE_BASELINE_PURIFICATION_EXECUTION_RESULT_V1.md`
- `docs/constitutional-baseline/domain-audits/administrative/ADMINISTRATIVE_FINDINGS_REPORT_V1.md`
- `docs/constitutional-baseline/domain-audits/commercial/COMMERCIAL_FINDINGS_REPORT_V1.md`
- `docs/constitutional-baseline/domain-audits/residential/RESIDENTIAL_FINDINGS_REPORT_V1.md`
- `mental-smile-os-workspace/docs/mental-smile-os/app-surface/client-registration/CLIENT_REGISTRATION_SOURCE_CLASSIFICATION_V1.md`
- `mental-smile-os-workspace/docs/mental-smile-os/app-surface/client-registration/CLIENT_REGISTRATION_RECREATION_PROMPT_CARD_V1.md`
- `mental-smile-os-workspace/docs/mental-smile-os/app-surface/client-registration/CLIENT_REGISTRATION_FIELD_REVIEW_QUEUE_V1.md`
- `mental-smile-os-workspace/docs/mental-smile-os/app-surface/client-registration/CLIENT_REGISTRATION_VISUAL_ASSET_CARD_V1.md`

### Key snippets

`routes.dart`:

```dart
static const portalProviderRegister = '/register/provider';
static const clientRegister = '/register/client';
static const accessibility = '/accessibility';
```

`app_router.dart`:

```dart
case Routes.clientRegister:
  return MaterialPageRoute(
    builder: (_) => const ClientRegisterPage(),
    settings: settings,
  );
```

`client_register_page.dart`:

```dart
String _selectedAvatar = 'images/avatar_client_fmale.png';
final Set<String> _selectedGoalSignals = {};
final Set<String> _selectedInterestSignals = {};
final Set<String> _selectedAccessibilitySignals = {};
```

`ContactRequestRepository`:

```dart
collection(ProviderContactRequestRecord.collectionName)
SignalPackageFactory.providerContactStarted(...)
```

`firestore.rules`:

```text
match /provider_contact_requests/{requestId}
match /center_contact_requests/{requestId}
match /signal_events/{signalId}
```

### Search terms used

```text
Routes.
case Routes
register
dashboard
client
provider
center
admin
owner
monitoring
booking
session
payment
payout
request
contact
signal
avatar
goals
interests
REMOVE
ARCHIVE
LEGACY
FROZEN
DEPRECATED
REPLACE
SIMPLIFY
MUST NOT
old screen
legacy screen
source classification
recreation prompt
C5
C6
```
