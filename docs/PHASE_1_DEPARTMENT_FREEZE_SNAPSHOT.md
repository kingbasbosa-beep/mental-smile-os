# Mental Smile Phase 1 Department Freeze Snapshot

Document ID: `phase1.department.freeze.snapshot.v1`
Phase: `PHASE_1`
Phase Name: `Department Constitution Structure`
Scope: Department build only
Generated From:
- `docs/MASTER_CONSTITUTIONAL_SNAPSHOT_REPORT.md`
- `docs/MASTER_CONSTITUTION_GENERATION_PLAN.md`
- `docs/CONSTITUTION_SECTIONS_PHASE_1_TO_3.md`

Runtime Changes: `NONE`
Firebase Changes: `NONE`
ARB Changes: `NONE`
Route Changes: `NONE`
UI Changes: `NONE`
Purpose: Freeze the local constitutional view of departments, what exists, what is missing, what connects to what, and what Phase 1 must hand to Phase 2.

## 0. Phase 1 Freeze Boundary

Phase 1 is the department freeze phase. It does not create workforce authority in full, does not write runtime registries, does not implement cards, and does not change app code. It freezes the constitutional department map so the next phase can build workforce authority on top of stable department boundaries.

| Boundary Item | Phase 1 Rule |
|---|---|
| Master constitution | Consumed as dependency only. Not generated here. |
| Departments | Generated and frozen as constitutional domains. |
| Workforce | Listed as required roles only. Full workforce constitution belongs to Phase 2. |
| Cards | Department, signal, registry, workflow, UI freeze cards listed for Phase 1 only. |
| Signals | Department construction and gap signals listed for Phase 1 only. |
| Registries | Registry requirements frozen, not runtime-implemented. |
| Localization | Frozen as department-localization ownership map, not ARB edits. |
| Rules | Frozen as department-rule requirements, not Firebase rule edits. |
| UI | Frozen as department-to-surface/screen ownership, not UI edits. |
| Archive | Archive records required for Phase 1 listed, not implemented. |

## 1. Phase 1 Doctrine

Phase 1 doctrine:

Every existing Mental Smile surface, route, screen, collection, card-like unit, signal, asset area, localization area, rule surface, and operational gap must belong to a named department before workforce authority, card lifecycle, registries, auditors, or archive systems can safely govern it.

Phase 1 does not clean reality. It freezes reality. It preserves active, transitional, legacy, frozen, orphaned, missing, and unknown objects as visible constitutional facts.

| Doctrine ID | Doctrine | Meaning In Phase 1 |
|---|---|---|
| `doctrine.phase1.freeze_reality` | Freeze reality before assigning workforce. | Department structure must match observed project state. |
| `doctrine.phase1.no_redesign` | Do not redesign departments to look cleaner. | If a surface is transitional, it remains transitional in the freeze. |
| `doctrine.phase1.every_surface_has_department` | Every surface maps to a department. | Public, residential, commercial, admin, owner, monitoring, legal, archive, technical, localization surfaces must be assigned. |
| `doctrine.phase1.every_route_has_department` | Every route maps to a department. | Route authority can no longer remain implicit. |
| `doctrine.phase1.every_collection_has_department` | Every collection maps to a department. | Firestore authority must be department-scoped. |
| `doctrine.phase1.every_ui_surface_has_owner` | Every UI surface must have a department owner or visible gap. | Screens and card-like units enter department freeze. |
| `doctrine.phase1.localization_freeze` | Localization ownership is frozen at department level. | ARB/localization drift is recorded, not edited. |
| `doctrine.phase1.rules_freeze` | Rule authority is frozen at department level. | Firestore/custom claim dependencies are mapped, not changed. |
| `doctrine.phase1.gaps_are_outputs` | Missing items are outputs, not failures to hide. | Missing cards/signals/registries/workforce definitions become Phase 1 gap records. |
| `doctrine.phase1.phase2_handoff` | Department freeze must feed workforce structure. | Each department must expose required roles for Phase 2. |

## 2. Phase 1 Definitions

| Term | Definition |
|---|---|
| Department Freeze | A local constitutional snapshot of all departments and their current boundaries. |
| Department | A constitutional domain that owns surfaces, routes, screens, collections, cards, signals, assets, localization, tools, and gaps. |
| Department Boundary | The complete set of objects assigned to a department. |
| Department Card | A future-compatible card that represents one department and its evidence. |
| Department Signal | A constitutional signal produced when a department object is mapped, missing, or frozen. |
| Department Registry | A future registry that records department ownership and status. |
| Department Logic Card | A workflow card that explains the department construction logic. |
| UI Freeze | A map of screens and card-like widgets to departments. |
| Localization Freeze | A map of localization objects, language policy, and string drift to departments. |
| Rules Freeze | A map of Firestore rules, role gates, custom claims, and collection ownership to departments. |
| Missing Department Object | Any required card, signal, registry, role, localization owner, rule owner, or archive record not observed as complete. |
| Phase 2 Handoff | The set of department outputs consumed by Workforce Structure. |

## 3. Department Set Freeze

| Department ID | Department | Purpose | Current Status | Exists Now | Missing / Incomplete | Freeze Classification |
|---|---|---|---|---|---|---|
| `department.residential` | Residential | Client personal space, dashboard, support entry, discovery, saved destinations, library. | Active | Client dashboard, personal space, saved destinations, support/library routes, residential signals. | Residential ownership registry, full residential card registry, persistent residential signal summaries. | `ACTIVE_WITH_GAPS` |
| `department.commercial` | Commercial | Clinician/center registration, profiles, readiness, discovery, contact requests, marketplace direction. | Active/transitional | Clinician/center routes, profile edit requests, specialist/center discovery, contact request collections. | Runtime marketplace registry, commercial ownership registry, marketplace governance cards, endorsement/marketplace governance model. | `ACTIVE_WITH_TRANSITIONAL_GAPS` |
| `department.administrative` | Administrative | Registry stewardship, declaration review, support administration, chat escalation administration. | Transitional | Registry room, declaration review room, support room, chat escalation routes. | Unified administrative registry, full administrative role workflow, complete declaration/support signal ownership. | `TRANSITIONAL` |
| `department.owner` | Owner | Owner sovereignty, strategic memory, recovery, capsules, regeneration, owner-only control. | Transitional | Owner route family, owner-only route gates, owner district UI. | Owner workflow registry, owner action ledger, runtime owner collection, archive integration. | `TRANSITIONAL` |
| `department.monitoring` | Monitoring | Signal observation, analytics summaries, capital operations. | Transitional | Capital routes, signal monitoring room, signal events, analytics summaries, monitoring operator role. | Persistent aggregate writer, alert lifecycle registry, monitoring report registry, monitoring cards for alerts. | `TRANSITIONAL` |
| `department.legal_governance` | Legal & Governance | Policy interpretation, language permissions, compliance doctrine, declaration review support. | Transitional | Policy docs, language matrix, validation rules, declaration review route, AI policies collection. | Runtime legal role, governance action registry, legal review route, compliance runtime registry. | `TRANSITIONAL` |
| `department.archive` | Archive | Preserve snapshots, versions, frozen/legacy systems, owner memory, constitutional memory. | Transitional | Git/docs history, owner memory/vault/capsule route names, archive doctrine references. | Runtime archive service, archive role, archive registry, archive records collection. | `TRANSITIONAL` |
| `department.technical` | Technical | Flutter, Firebase, Firestore rules, routes, functions, tools, builds, implementation feasibility. | Active | Flutter app, AppRouter, Routes, Firebase, Firestore, Cloud Functions, Git. | Technical authority registry, technical lifecycle registry, complete tool registry. | `ACTIVE_WITH_GAPS` |
| `department.public_portal` | Public Portal | Public entry, about, library, contact, public requests, provider registration entry. | Active | Public routes and portal screens. | Public ownership registry, public surface card registry, complete request lifecycle ownership. | `ACTIVE_WITH_GAPS` |
| `department.localization` | Localization | Runtime strings, language page, language policy, surface term permissions, string drift ownership. | Transitional | Generated localization, language page, policy docs, term matrix, validation rules. | Localization ownership registry, hardcoded string inventory, runtime term validation, mojibake remediation owner. | `TRANSITIONAL` |

## 4. Phase 1 Department Logic

Phase 1 logic is a deterministic freeze workflow:

1. Read current snapshot.
2. List all current departments.
3. Map every surface to a department.
4. Map every route to a department.
5. Map every collection and Firebase integration to a department.
6. Map every UI screen and card-like unit to a department.
7. Map every signal and signal gap to a department.
8. Map localization and rules to departments.
9. Produce department cards, registry cards, signal cards, workflow cards, and gap ledger.
10. Freeze Phase 1 and hand department outputs to Phase 2.

| Logic ID | Logic Step | Input | Output | Produced Signal | Produced Card |
|---|---|---|---|---|---|
| `logic.phase1.read_snapshot` | Read current constitutional snapshot. | Snapshot report | Source evidence set | `signal.phase1.source_loaded` | `card.workflow.phase1.department_logic` |
| `logic.phase1.create_department_set` | Create department set. | Surface topology | Department list | `signal.department.created` | `card.department.*` |
| `logic.phase1.bind_surfaces` | Bind surfaces to departments. | Surface inventory | Surface department matrix | `signal.department.surface_bound` | `card.registry.surface_department` |
| `logic.phase1.bind_routes` | Bind routes to departments. | Route inventory | Route department matrix | `signal.department.route_bound` | `card.registry.route_department` |
| `logic.phase1.bind_collections` | Bind collections to departments. | Firestore/Firebase inventory | Collection department matrix | `signal.department.collection_bound` | `card.registry.collection_department` |
| `logic.phase1.bind_ui` | Bind UI screens/cards to departments. | Screen/card topology | UI freeze matrix | `signal.department.ui_bound` | `card.registry.department_ui` |
| `logic.phase1.bind_localization` | Bind localization objects to departments. | Localization inventory | Localization freeze matrix | `signal.department.localization_bound` | `card.registry.department_localization` |
| `logic.phase1.bind_rules` | Bind rule surfaces to departments. | Firestore rules/custom claims/route gates | Rules freeze matrix | `signal.department.rule_bound` | `card.registry.department_rules` |
| `logic.phase1.record_gaps` | Record missing/incomplete objects. | Gap analysis | Phase 1 gap ledger | `signal.department.gap_recorded` | `card.workflow.phase1.gap_ledger` |
| `logic.phase1.freeze` | Freeze Phase 1 outputs. | All matrices | Phase 1 freeze package | `signal.phase1.freeze_completed` | `card.workflow.phase1.freeze` |

## 5. Department-to-Surface Freeze

| Department | Primary Surfaces | Secondary / Shared Surfaces | Existing | Missing |
|---|---|---|---|---|
| Residential | `surface.residential`, `/client/dashboard`, `/s/personal-space` | Library, support, commercial discovery | Active dashboard/personal surfaces | Residential card registry, ownership registry, persistent signal summaries |
| Commercial | Commercial registration, clinician/center rooms, specialist/center discovery | Public portal, city marketplace, support/contact | Active commercial flows | Runtime marketplace registry, commercial governance cards |
| Administrative | Registry room, declaration review room, chat escalations | Support, legal, owner | Active admin-like S rooms | Unified admin registry, role workflow model |
| Owner | Owner district and owner route family | Archive, monitoring, technical | Owner route gate and district | Owner action ledger, runtime owner workflow registry |
| Monitoring | Capital, signal monitoring room | Residential/commercial/support signal consumers | Monitoring room and analytics summaries | Alert lifecycle, aggregate writer, monitoring report registry |
| Legal & Governance | Policy docs, language policy, declaration review | Localization, commercial readiness, compliance | Docs and review surface | Runtime legal role and review workflow |
| Archive | Owner memory surfaces, Git/docs history | Owner, compliance, all departments | Static/archive naming and docs | Archive service, archive registry, archive workforce role |
| Technical | App router, routes, Firebase, Firestore rules, functions | All departments | Active technical substrate | Technical authority and lifecycle registries |
| Public Portal | Public pages, public requests, provider registration entry | Commercial, support, library | Active public routes | Public surface registry and request lifecycle ownership |
| Localization | Language page, generated localization, policy docs | All departments | Active generated localization and docs | Ownership registry, string inventory, validation runtime |

## 6. Department-to-Route Freeze

| Department | Routes Frozen Into Department | Current Status | Missing / Notes |
|---|---|---|---|
| Residential | `/client/dashboard`, `/s/personal-space`, `/register/client`, `/module/addiction`, `/module/special_needs`, `/module/support-issue-selector`, `/module/library` | Active | Needs department route registry and residential route owner fields. |
| Commercial | `/register/provider`, `/register/clinician`, `/register/center`, `/clinician/room`, `/clinician/profile-edit-request`, `/clinician/chat-inbox`, `/center/dashboard`, `/center/room`, `/center/profile-edit-request`, `/module/specialists`, `/module/specialists/list`, `/module/specialists/details`, `/module/centers`, `/module/centers/list`, `/module/centers/details`, `/web/center/register*`, `/web/clinician/register*`, `/web/register/success`, `/s/city/providers`, `/s/city/centers`, `/s/city/marketplace` | Active/transitional | Marketplace and city commercial placeholders need status freeze as transitional. |
| Administrative | `/s/registry-room`, `/s/declaration-review-room`, `/s/support-room`, `/chat/escalations`, `/chat/escalation/report`, `/account-blocked` | Active/transitional | Needs unified admin workflow and route ownership registry. |
| Owner | `/s/owner`, `/s/owner/room`, `/s/owner/sovereign-intelligence`, `/s/owner/strategic-memory`, `/s/owner/sovereign-vault`, `/s/owner/constitutional-memory`, `/s/owner/recovery-console`, `/s/owner/capsules`, `/s/owner/regeneration` | Active/transitional | Many owner routes are focus/static surfaces, not complete workflows. |
| Monitoring | `/s/capital`, `/s/capital/operations-office`, `/s/capital/incidents`, `/s/capital/maintenance`, `/s/capital/broadcasts`, `/s/capital/emergency-brief`, `/s/capital/signal-monitoring-room`, `/s/capital/reports` | Active/transitional | Reports/incidents/alerts need lifecycle ownership. |
| Legal & Governance | `/s/declaration-review-room`, `/web/library/policy`, `/s/capital/trust-safety` | Transitional | Runtime legal role/review queue not observed. |
| Archive | `/s/owner/strategic-memory`, `/s/owner/sovereign-vault`, `/s/owner/constitutional-memory`, `/s/owner/capsules` | Transitional | Archive routes are owner focus surfaces, not archive runtime. |
| Technical | `/splash`, `/login`, `/language`, `/home`, `/menu`, `/s/capital/maintenance` plus all route infrastructure | Active | Technical route ownership registry missing. |
| Public Portal | `/`, `/about`, `/library`, `/contact`, `/request/service`, `/request/package`, `/register/provider`, `/splash` | Active | Public request lifecycle ownership incomplete. |
| Localization | `/language` plus all localized UI strings | Active/transitional | Department localization registry missing. |

## 7. Department-to-Collection Freeze

| Department | Collections / Firebase Objects | Existing | Missing / Incomplete |
|---|---|---|---|
| Residential | `clients`, `saved_destinations`, `signal_events` | Present | Residential collection ownership registry, retention map. |
| Commercial | `clinicians`, `centers`, `clinician_profile_change_requests`, `center_profile_change_requests`, `provider_contact_requests`, `center_contact_requests` | Present | Marketplace collection authority, commercial retention/governance registry. |
| Administrative | `system_domains`, `support_requests`, `chat_escalations`, `chat_escalations/{id}/reports` | Present | Unified admin collection registry. |
| Owner | Owner-specific collection not observed | Not observed | Owner action ledger, owner workflow collection. |
| Monitoring | `signal_events`, `signal_aggregates`, `analytics_summaries`, Firebase Analytics, BigQuery | Present/transitional | Persistent aggregate writer and alert/report lifecycle collection. |
| Legal & Governance | `ai_policies`, profile change request collections, declaration review data sources | Present/transitional | Legal review collection and compliance decision registry. |
| Archive | Git/docs history, archive records conceptual | Present as docs/history | Runtime archive collection/registry. |
| Technical | Firebase Auth, Firestore, Cloud Functions, Firestore rules, Firebase config | Present | Technical lifecycle registry, storage rules file unknown. |
| Public Portal | Service/package/contact request data paths where implemented | Partial | Request lifecycle collection ownership. |
| Localization | ARB/generated localization files, policy docs | Present | Localization ownership registry, string drift collection/ledger. |

## 8. Department-to-UI Freeze

| Department | UI / Screens / Cards Existing | UI Status | Missing UI Cards / Missing Freeze Items |
|---|---|---|---|
| Residential | `ClientDashboardPage`, `SPersonalSpacePage`, theme catalog card, tool card, signal summary card, saved summary card, guidance card, personal overview card, signal board | Active | Residential department UI registry, residential card ownership, persistent signal UI binding. |
| Commercial | Web clinician/center registration, clinician room, center room, specialist/center list/details, contact cards, provider/center signal options | Active/transitional | Commercial governance cards, marketplace cards, readiness card registry. |
| Administrative | Registry room, declaration review room, support room, chat escalation screens | Active/transitional | Admin workflow cards, admin route owner cards, unified admin dashboard card. |
| Owner | Owner district, owner overview/card/district/capsule cards | Active/transitional | Owner workflow cards, owner action cards, archive-linked owner cards. |
| Monitoring | Capital office, signal monitoring room, control cards, section cards | Active/transitional | Alert cards, monitoring report cards, aggregate health card. |
| Legal & Governance | Policy docs UI, declaration review cards, language policy documents | Transitional | Legal review UI, compliance interpretation cards. |
| Archive | Owner memory/capsule UI naming, docs/Git history | Transitional | Archive dashboard/cards, version cards, supersession cards. |
| Technical | Router, splash, login, language, menu, maintenance focus, dev seeders | Active | Technical lifecycle cards, tool registry UI, route governance UI. |
| Public Portal | Portal home/about/library/contact/request/register screens | Active | Public route ownership cards, request lifecycle cards. |
| Localization | Language page, generated localized UI, policy docs | Active/transitional | Localization owner cards, hardcoded string drift card, mojibake drift card. |

## 9. Department-to-Signal Freeze

| Department | Existing Signals | Missing / Incomplete Signals | Required Phase 1 Signals |
|---|---|---|---|
| Residential | `goal_selected`, `interest_selected`, `accessibility_interest`, `communication_preference_selected`, `destination_saved`, `library_category_opened` | Persistent residential summaries, option registry ownership, personal-space signal health lifecycle | `signal.department.created`, `signal.department.surface_bound`, `signal.department.route_bound`, `signal.department.gap_recorded` |
| Commercial | `provider_contact_started`, `center_contact_started`, `provider_profile_opened`, `center_profile_opened` | Marketplace governance signals, readiness/declaration signal registry, commercial ownership signals | `signal.department.collection_bound`, `signal.department.ui_bound`, `signal.department.gap_recorded` |
| Administrative | Support/admin surfaces consume support/declaration data | Admin workflow signals, declaration review signals, registry stewardship signals | `signal.department.rule_bound`, `signal.department.gap_recorded` |
| Owner | Owner summary routing target exists conceptually | Owner action signals, owner authorization signals, owner archive signals | `signal.department.created`, `signal.department.gap_recorded` |
| Monitoring | Signal events, analytics summaries, monitoring routing targets | Alert lifecycle signals, persistent aggregate signals, monitoring report signals | `signal.department.collection_bound`, `signal.department.gap_recorded` |
| Legal & Governance | Policy/AI policy data exists; declaration review consumes readiness evidence | Legal interpretation signals, policy conflict signals, language violation signals | `signal.department.localization_bound`, `signal.department.gap_recorded` |
| Archive | Archive preservation conceptual | Version preserved, superseded, frozen, legacy recorded signals | `signal.phase1.freeze_completed` |
| Technical | Route/rule/Firebase state evidence | Technical lifecycle, route drift, rule drift signals | `signal.department.rule_bound`, `signal.department.route_bound` |
| Public Portal | Contact/request/profile open signal intersections | Public request lifecycle signals | `signal.department.route_bound`, `signal.department.ui_bound` |
| Localization | Language selection/runtime localization exists | Localization ownership, hardcoded string, mojibake, validation signals | `signal.department.localization_bound`, `signal.department.gap_recorded` |

## 10. Phase 1 Required Signal Cards

| Signal Card ID | Signal ID | Purpose | Producer | Consumer | Missing If Not Created |
|---|---|---|---|---|---|
| `card.signal.phase1.source_loaded` | `signal.phase1.source_loaded` | Confirms snapshot source loaded. | Phase 1 logic | Department workflow | Phase source cannot be traced. |
| `card.signal.department.created` | `signal.department.created` | Records department creation. | Department logic | Workforce Phase 2, registries | Department cannot be consumed by Phase 2. |
| `card.signal.department.surface_bound` | `signal.department.surface_bound` | Records surface-to-department binding. | Surface freeze | Registry/compliance | Surface ownership remains implicit. |
| `card.signal.department.route_bound` | `signal.department.route_bound` | Records route-to-department binding. | Route freeze | Registry/compliance | Route ownership remains implicit. |
| `card.signal.department.collection_bound` | `signal.department.collection_bound` | Records collection-to-department binding. | Collection freeze | Data governance | Collection ownership remains implicit. |
| `card.signal.department.asset_bound` | `signal.department.asset_bound` | Records asset-to-department binding. | Asset freeze | UI/product/technical | Asset ownership remains implicit. |
| `card.signal.department.ui_bound` | `signal.department.ui_bound` | Records UI/screen/card-to-department binding. | UI freeze | Card constitution | UI cards cannot be assigned later. |
| `card.signal.department.localization_bound` | `signal.department.localization_bound` | Records localization-to-department binding. | Localization freeze | Legal/localization | Localization ownership remains missing. |
| `card.signal.department.rule_bound` | `signal.department.rule_bound` | Records rule/claim/gate-to-department binding. | Rules freeze | Technical/legal | Rule authority remains unclear. |
| `card.signal.department.gap_recorded` | `signal.department.gap_recorded` | Records department gap. | Gap ledger | Compliance/owner/archive | Gaps can be hidden accidentally. |
| `card.signal.phase1.freeze_completed` | `signal.phase1.freeze_completed` | Records Phase 1 freeze completion. | Phase 1 logic | Phase 2 workforce | Phase 2 cannot verify handoff. |

## 11. Phase 1 Required Department Cards

| Department Card | Department | Must Include | Exists As Generated Card | Missing Detail Still Needed |
|---|---|---|---|---|
| `card.department.residential` | Residential | Routes, screens, collections, residential signals, UI cards, missing registries | Yes, in previous selected section doc | Complete residential card registry, persistent signal summary mapping. |
| `card.department.commercial` | Commercial | Provider/center routes, readiness gates, contact collections, marketplace gaps | Yes | Marketplace governance card details, commercial ownership registry. |
| `card.department.administrative` | Administrative | Registry/declaration/support rooms, escalation collections, admin gaps | Yes | Unified admin workflow and registry details. |
| `card.department.owner` | Owner | Owner route family, owner cards, owner gaps | Yes | Owner action ledger and archive integration. |
| `card.department.monitoring` | Monitoring | Capital routes, signal monitoring, analytics, aggregate gaps | Yes | Alert lifecycle and aggregate writer mapping. |
| `card.department.legal_governance` | Legal & Governance | Policy docs, language rules, declaration review, compliance gaps | Yes | Runtime legal role and governance action registry. |
| `card.department.archive` | Archive | Git/docs, owner memory surfaces, archive gaps | Yes | Runtime archive records and registry. |
| `card.department.technical` | Technical | Flutter/Firebase/routes/rules/functions/tools | Yes | Technical lifecycle registry and tool registry. |
| `card.department.public_portal` | Public Portal | Public routes and request surfaces | Yes | Request lifecycle ownership and public cards. |
| `card.department.localization` | Localization | Generated localization, language page, policy docs, string drift | Yes | Localization ownership registry and validation runtime. |

## 12. Missing Department Cards By Department

| Department | Missing Card ID | Missing Card Name | Why Missing Matters | Phase 1 Status |
|---|---|---|---|---|
| Residential | `card.department.residential_signal_summary_registry` | Residential Signal Summary Registry Card | Residential signal summaries are active but persistent summary ownership is incomplete. | Required gap |
| Residential | `card.department.residential_ui_registry` | Residential UI Registry Card | Dashboard/personal cards need department ownership. | Required gap |
| Commercial | `card.department.marketplace_governance` | Marketplace Governance Department Card | Marketplace direction exists but governance is missing. | Required gap |
| Commercial | `card.department.commercial_readiness` | Commercial Readiness Department Card | Clinician/center readiness gates need department governance. | Required gap |
| Administrative | `card.department.admin_workflow` | Administrative Workflow Card | Registry/declaration/support admin flows are split. | Required gap |
| Owner | `card.department.owner_action_ledger` | Owner Action Ledger Card | Owner authority exists but action ledger is missing. | Required gap |
| Monitoring | `card.department.monitoring_alert_lifecycle` | Monitoring Alert Lifecycle Card | Monitoring observes but alert lifecycle is incomplete. | Required gap |
| Legal & Governance | `card.department.legal_runtime_authority` | Legal Runtime Authority Card | Legal docs exist but runtime role/surface is missing. | Required gap |
| Archive | `card.department.archive_runtime` | Archive Runtime Department Card | Archive doctrine exists but runtime archive is missing. | Required gap |
| Technical | `card.department.technical_lifecycle` | Technical Lifecycle Card | Technical authority and change lifecycle are not fully mapped. | Required gap |
| Public Portal | `card.department.public_request_lifecycle` | Public Request Lifecycle Card | Public request surfaces need ownership and lifecycle. | Required gap |
| Localization | `card.department.localization_ownership` | Localization Ownership Card | Localization ownership registry is missing. | Required gap |

## 13. Phase 1 Required Registry Cards

| Registry Card ID | Registry | Purpose | Existing Runtime Equivalent | Current Status |
|---|---|---|---|---|
| `card.registry.department` | `registry.department` | Stores department identity and boundaries. | None observed as runtime registry. | Missing |
| `card.registry.surface_department` | `registry.surface_department` | Maps surfaces to departments. | None observed. | Missing |
| `card.registry.route_department` | `registry.route_department` | Maps routes to departments. | `Routes` exists, but no department metadata. | Transitional |
| `card.registry.collection_department` | `registry.collection_department` | Maps Firestore collections to departments. | Firestore rules/usage exist, no registry. | Missing |
| `card.registry.asset_department` | `registry.asset_department` | Maps assets to departments. | `AppAssets` partial. | Transitional |
| `card.registry.ui_department` | `registry.ui_department` | Maps screens and card-like widgets to departments. | No runtime UI registry. | Missing |
| `card.registry.localization_department` | `registry.localization_department` | Maps localization objects to departments. | Generated localization and docs exist. | Transitional |
| `card.registry.rules_department` | `registry.rules_department` | Maps rules, claims, route gates to departments. | AppRouter/rules exist, no registry. | Missing |
| `card.registry.department_gap` | `registry.department_gap` | Stores missing/transitional/orphaned department gaps. | Snapshot docs only. | Missing |

## 14. Rules Freeze

Rules freeze means Phase 1 maps authority evidence. It does not edit Firestore rules, auth claims, route gates, or Firebase configuration.

| Rule Surface | Connected Department(s) | Existing Evidence | Missing / Gap | Required Phase 1 Card |
|---|---|---|---|---|
| Firebase Auth custom claims | Technical, Owner, Residential, Commercial, Monitoring, Admin | Runtime roles and route gates consume claims. | Complete authority registry missing. | `card.registry.rules_department` |
| AppRouter role gates | Technical, all routed departments | Routes gated for owner/monitoring/registry/declaration/support/client/center/clinician. | Route-to-department authority metadata missing. | `card.registry.route_department` |
| Firestore rules | Technical, Residential, Commercial, Support, Monitoring, Legal | Rules enforce collection access. | Collection ownership/retention map missing. | `card.registry.collection_department` |
| Visibility readiness gate | Commercial, Legal/Governance, Technical | Clinician/center rooms check readiness. | Readiness governance card missing. | `card.department.commercial_readiness` |
| Signal event writes | Monitoring, Residential, Commercial, Support | `signal_events` collection and storage service exist. | Persistent aggregate writer ownership incomplete. | `card.department.monitoring_alert_lifecycle` |
| AI policy seeding | Legal/Governance, Technical | `ai_policies` collection and seeder exist. | Legal runtime ownership incomplete. | `card.department.legal_runtime_authority` |
| Storage rules reference | Technical | `firebase.json` references storage rules. | `storage.rules` not observed in snapshot. | `card.registry.department_gap` |

## 15. Localization Freeze

Localization freeze means Phase 1 records ownership and gaps. It does not edit ARB or generated localization files.

| Localization Object | Connected Department(s) | Existing | Missing | Required Phase 1 Card |
|---|---|---|---|---|
| Generated `AppLocalizations` | Localization, Technical, all UI departments | Active | Department owner registry for strings. | `card.department.localization` |
| Language page `/language` | Localization, Technical, Public/Core | Active | Language selection governance card. | `card.registry.localization_department` |
| Residential language policy | Residential, Legal/Governance, Localization | Docs exist | Runtime validation binding missing. | `card.department.localization_ownership` |
| Commercial language policy | Commercial, Legal/Governance, Localization | Docs exist | Runtime validation binding missing. | `card.department.localization_ownership` |
| Administrative language policy | Administrative, Legal/Governance, Localization | Docs exist | Runtime validation binding missing. | `card.department.localization_ownership` |
| Surface term permission matrix | Legal/Governance, Localization, all departments | Docs exist | Enforcement registry missing. | `card.registry.localization_department` |
| Surface language validation rules | Legal/Governance, Localization | Docs exist | Runtime validator missing. | `card.registry.localization_department` |
| Hardcoded strings | Technical, Localization, all UI departments | Incomplete inventory | Hardcoded string registry missing. | `card.department.localization_ownership` |
| Mojibake/string drift | Technical, Localization | Observed drift | Drift owner and remediation process missing. | `card.department.localization_ownership` |

## 16. UI Freeze

UI freeze maps what exists to departments and identifies missing card/registry ownership. It does not change widgets.

| UI Freeze ID | UI Area | Department | Existing | Missing |
|---|---|---|---|---|
| `ui.freeze.client_dashboard` | Client dashboard cards/tools | Residential | Active | Department UI registry, full card ownership. |
| `ui.freeze.personal_space` | Personal space and signal board | Residential/Monitoring | Active | Signal board ownership and persistent summary mapping. |
| `ui.freeze.commercial_registration` | Web clinician/center registration | Commercial/Public Portal | Active | Registration card lifecycle and readiness registry. |
| `ui.freeze.commercial_discovery` | Specialists and centers modules | Commercial/Residential | Active | Marketplace governance card and commercial signal ownership. |
| `ui.freeze.registry_room` | Registry room | Administrative | Active | Registry card lifecycle and admin workflow. |
| `ui.freeze.declaration_review` | Declaration review room | Administrative/Legal | Active | Declaration signal ownership and legal authority card. |
| `ui.freeze.support_room` | Support room and support module | Support/Admin/Residential | Active | Support signal registry and support ownership card. |
| `ui.freeze.owner_district` | Owner district and capsules | Owner/Archive | Active/transitional | Owner action ledger and archive integration cards. |
| `ui.freeze.capital_monitoring` | Capital and signal monitoring room | Monitoring/Owner | Active/transitional | Alert lifecycle and monitoring report cards. |
| `ui.freeze.public_portal` | Public portal screens | Public Portal | Active | Public request lifecycle and surface ownership cards. |
| `ui.freeze.localization` | Language page/localized strings | Localization | Active/transitional | Localization ownership and drift cards. |
| `ui.freeze.technical_core` | Splash/login/menu/router | Technical/Public/Core | Active | Technical lifecycle and route authority cards. |

## 17. Phase 1 Workflow Cards

| Workflow Card ID | Name | Purpose | Inputs | Outputs | Missing / Gap |
|---|---|---|---|---|---|
| `card.workflow.phase1.department_logic` | Department Logic Workflow Card | Explains how Phase 1 maps objects to departments. | Snapshot, Phase 1 doctrine | Department freeze logic | Needs future registry implementation. |
| `card.workflow.phase1.surface_mapping` | Surface Mapping Workflow Card | Maps every surface to a department. | Surface topology | Surface department matrix | Surface authority registry missing. |
| `card.workflow.phase1.route_mapping` | Route Mapping Workflow Card | Maps every route to a department. | Route topology | Route department matrix | Route metadata registry missing. |
| `card.workflow.phase1.collection_mapping` | Collection Mapping Workflow Card | Maps collections/Firebase objects to departments. | Collection inventory | Collection department matrix | Retention and data owner registry incomplete. |
| `card.workflow.phase1.ui_freeze` | UI Freeze Workflow Card | Maps screens/cards/UI units to departments. | Card/UI topology | UI freeze matrix | Runtime card registry missing. |
| `card.workflow.phase1.localization_freeze` | Localization Freeze Workflow Card | Maps localization/policies/drift to departments. | Localization inventory, policy docs | Localization freeze matrix | Ownership registry and validation runtime missing. |
| `card.workflow.phase1.rules_freeze` | Rules Freeze Workflow Card | Maps route gates/custom claims/Firestore rules to departments. | Router/rules inventory | Rules freeze matrix | Authority registry missing. |
| `card.workflow.phase1.gap_ledger` | Department Gap Ledger Workflow Card | Records all missing/incomplete Phase 1 objects. | Gap analysis | Gap ledger | Compliance runtime missing. |
| `card.workflow.phase1.freeze` | Phase 1 Freeze Workflow Card | Freezes final Phase 1 package and hands to Phase 2. | All Phase 1 matrices/cards/signals | Phase 2 handoff package | Archive runtime missing. |

## 18. Phase 1 Gap Ledger

| Gap ID | Department | Gap | Existing Evidence | Needed In Phase 1 Freeze |
|---|---|---|---|---|
| `gap.phase1.department_registry_missing` | All | Department registry missing. | Departments listed in docs only. | `registry.department` card and schema freeze. |
| `gap.phase1.route_metadata_missing` | All | Routes have no department metadata registry. | `Routes`/`AppRouter` active. | Route-department matrix. |
| `gap.phase1.ownership_missing` | All | Owners inferred, not complete. | Snapshot owners partial. | Department owner fields and missing-owner gaps. |
| `gap.phase1.card_runtime_registry_missing` | All | Runtime card registry missing. | Card-like widgets exist. | Department UI/card freeze and card gap ledger. |
| `gap.phase1.tool_registry_missing` | Technical/Residential | Runtime tool registry missing. | Local `_ToolSpec`, frozen legacy registry. | Tool department ownership gap. |
| `gap.phase1.localization_ownership_missing` | Localization/Legal | Localization ownership registry missing. | Generated localization and policy docs exist. | Localization freeze and ownership card. |
| `gap.phase1.rules_authority_missing` | Technical/Legal/All | Rule authority map incomplete. | Firestore rules and route gates exist. | Rules freeze matrix. |
| `gap.phase1.archive_runtime_missing` | Archive/Owner | Archive runtime missing. | Git/docs and owner memory naming exist. | Archive department card gap. |
| `gap.phase1.legal_runtime_missing` | Legal & Governance | Runtime legal role missing. | Docs/policies exist. | Legal governance department gap. |
| `gap.phase1.compliance_runtime_missing` | Legal/Compliance | Compliance runtime missing. | Compliance docs exist. | Compliance handoff gap to Phase 2. |
| `gap.phase1.monitoring_alert_lifecycle_missing` | Monitoring | Alert lifecycle missing. | Monitoring surfaces exist. | Monitoring alert lifecycle gap card. |
| `gap.phase1.persistent_aggregate_writer_missing` | Monitoring | Aggregate writer incomplete. | `signal_aggregates` read-only/writer unclear. | Monitoring gap record. |
| `gap.phase1.marketplace_governance_missing` | Commercial | Marketplace governance missing. | Marketplace placeholder exists. | Commercial marketplace gap card. |
| `gap.phase1.owner_action_ledger_missing` | Owner | Owner action ledger missing. | Owner routes exist. | Owner department gap card. |
| `gap.phase1.public_request_lifecycle_missing` | Public Portal | Public request lifecycle incomplete. | Request routes exist. | Public portal gap card. |

## 19. Phase 1 Freeze Package

Phase 1 freeze package must contain:

| Freeze Object | Required Contents | Status |
|---|---|---|
| `freeze.phase1.department_map` | Ten department IDs, names, purpose, owners, status, gaps. | Generated in this document. |
| `freeze.phase1.surface_matrix` | Surface-to-department binding. | Generated in this document. |
| `freeze.phase1.route_matrix` | Route-to-department binding. | Generated in this document. |
| `freeze.phase1.collection_matrix` | Collection-to-department binding. | Generated in this document. |
| `freeze.phase1.ui_matrix` | UI/screen/card-to-department binding. | Generated in this document. |
| `freeze.phase1.localization_matrix` | Localization/policy/drift-to-department binding. | Generated in this document. |
| `freeze.phase1.rules_matrix` | Rule/gate/claim-to-department binding. | Generated in this document. |
| `freeze.phase1.department_cards` | Required department cards and missing department cards. | Generated in this document. |
| `freeze.phase1.signal_cards` | Required Phase 1 signal cards. | Generated in this document. |
| `freeze.phase1.registry_cards` | Required Phase 1 registry cards. | Generated in this document. |
| `freeze.phase1.workflow_cards` | Required Phase 1 workflow/logic cards. | Generated in this document. |
| `freeze.phase1.gap_ledger` | Missing cards, signals, registries, roles, UI, localization, rules, archive records. | Generated in this document. |
| `freeze.phase1.phase2_handoff` | Outputs required by Workforce Structure. | Generated below. |

## 20. Phase 1 to Phase 2 Handoff

Phase 2 cannot safely define workforce authority until Phase 1 gives it frozen department boundaries.

| Phase 1 Output | Phase 2 Consumer | Why It Connects |
|---|---|---|
| Department map | Workforce role taxonomy | Workforce roles need department scopes. |
| Surface department matrix | Authority scope matrix | Role authority must know which surfaces it covers. |
| Route department matrix | Runtime role alignment | Role-to-route mapping depends on department ownership. |
| Collection department matrix | Permission and authority registry | Collection access requires department/data owner. |
| UI freeze matrix | Employee cards and card ownership | Workforce roles need to know which UI/cards they own or observe. |
| Localization freeze matrix | Legal & Governance workforce definition | Language authority needs department-localization boundaries. |
| Rules freeze matrix | Technical and legal workforce definitions | Technical execution and legal interpretation depend on rule ownership. |
| Department cards | Employee cards | Employee/workforce cards consume department cards. |
| Missing department card ledger | Compliance workforce definition | Compliance role must know what gaps it detects. |
| Phase 1 signal cards | Workforce signals | Workforce phase consumes department creation/binding/gap signals. |
| Phase 1 registry cards | Workforce authority registries | Workforce roles need registry ownership targets. |
| Phase 1 workflow cards | Phase 2 construction workflow | Workforce workflow starts after department freeze completes. |

## 21. Phase 2 Start Gate

Phase 2 may start only when these Phase 1 objects are locally frozen:

| Gate ID | Gate | Required State |
|---|---|---|
| `gate.phase1.department_map_frozen` | Department map frozen | All ten departments listed with current status and gaps. |
| `gate.phase1.surfaces_bound` | Surfaces bound | Every current surface has department assignment. |
| `gate.phase1.routes_bound` | Routes bound | Every current route family has department assignment. |
| `gate.phase1.collections_bound` | Collections bound | Every observed collection/Firebase object has department assignment or gap. |
| `gate.phase1.ui_bound` | UI bound | Screens/card-like units are mapped to departments or gaps. |
| `gate.phase1.localization_bound` | Localization bound | Localization docs/runtime/drift mapped to departments. |
| `gate.phase1.rules_bound` | Rules bound | Route gates, claims, Firestore rules mapped to departments. |
| `gate.phase1.department_cards_ready` | Department cards ready | Department card set and missing department card ledger exist. |
| `gate.phase1.signals_ready` | Phase 1 signals ready | Phase 1 signal cards exist. |
| `gate.phase1.registries_ready_as_requirements` | Registry cards ready as requirements | Required Phase 1 registry cards exist as governance requirements. |
| `gate.phase1.gaps_visible` | Gaps visible | Missing/transitional objects are not hidden. |
| `gate.phase1.no_runtime_change` | No runtime change | Phase 1 remains local documentation freeze only. |

## 22. Final Phase 1 Freeze Status

| Area | Status | Notes |
|---|---|---|
| Department structure | Frozen locally | Ten departments mapped from current project reality. |
| Department cards | Present plus missing-card ledger | Future card package compatible. |
| Signal cards | Phase 1 signal cards defined | Runtime signal implementation not changed. |
| Registry cards | Required registries defined as cards | Runtime registries not implemented. |
| Workflow cards | Phase 1 logic and freeze workflows defined | Includes department logic card. |
| Localization freeze | Complete as ownership/gap map | No ARB edits. |
| Rules freeze | Complete as authority/gap map | No Firebase/rules edits. |
| UI freeze | Complete as department UI map | No widget edits. |
| Existing objects | Preserved | Active/transitional/missing states visible. |
| Missing objects | Recorded | Gaps are explicit Phase 1 outputs. |
| Phase 2 link | Defined | Department freeze feeds workforce structure. |

