# Mental Smile Master Constitutional Snapshot Report

Snapshot ID: `constitutional.snapshot.current`
Snapshot Type: `DISCOVERY_ONLY`
Generated From: current workspace state, `PROJECT_REALITY_SNAPSHOT.md`, existing policy/topology/registry documents, Flutter source inventory
Runtime Changes: `NONE`
Guide Generation: `NONE`
Card Generation: `NONE`
Design Changes: `NONE`

## 0. Audit Boundary

This report is a constitutional current-state snapshot only. It records what exists, what is transitional, what is missing, and what is unknown. It does not propose solutions, create guides, create cards, redesign systems, modify app logic, modify Firebase, modify ARB files, or edit routes.

Classification vocabulary:

| Classification | Meaning |
|---|---|
| `ACTIVE` | Implemented or materially present in the current project state. |
| `TRANSITIONAL` | Partially implemented, split between old and new structures, or present as a bridge. |
| `LEGACY` | Older structure still visible in docs, deleted paths, or historical references. |
| `FROZEN` | Removed, intentionally paused, or preserved as non-runtime history. |
| `ORPHANED` | Exists without a clear consumer, owner, registry, or active route. |
| `UNKNOWN` | Insufficient evidence in the current snapshot to classify fully. |
| `MISSING` | Required by the constitutional map but not observed as implemented. |

## 1. Current Strategic Identity

### 1.1 What Mental Smile Currently Is

| ID | Name | Type | Current State | Classification |
|---|---|---|---|---|
| `identity.platform.flutter_firebase` | Mental Smile Flutter/Firebase App | Product identity | A Flutter application backed by Firebase Auth, Firestore, Analytics, and Cloud Functions. | `ACTIVE` |
| `identity.support_discovery` | Support and Discovery Platform | Strategic identity | Provides residential/client discovery, support entry, library access, provider/center profiles, and contact request flows. | `ACTIVE` |
| `identity.signal_first_ecosystem` | Signal-First Ecosystem | Strategic doctrine | Captures selected interests, goals, saved destinations, contact starts, support starts, and profile/library opens as signals. | `ACTIVE` |
| `identity.s_surface_architecture` | S Surface Architecture | Strategic structure | Organizes personal, city, capital, owner, support, registry, and declaration review rooms under `/s` routes. | `TRANSITIONAL` |
| `identity.federation_marketplace` | Federation Marketplace Direction | Product evolution | The codebase and docs point toward a governed federation of residential, commercial, administrative, monitoring, and owner surfaces. | `TRANSITIONAL` |
| `identity.constitutional_governance` | Constitutional Governance Direction | Governance evolution | Existing policy, language, registry, and guide documents indicate movement toward formal governance and snapshot/card control. | `TRANSITIONAL` |

### 1.2 What It Is Evolving Into

| ID | Name | Type | Evidence | Current Status | Classification |
|---|---|---|---|---|---|
| `evolution.federated_surfaces` | Federated Surface System | Strategic evolution | `/s/*` route family, federation topology docs, S rooms, city/capital/owner districts. | Partially routed and partially placeholder-backed. | `TRANSITIONAL` |
| `evolution.governed_marketplace` | Governed Marketplace | Strategic evolution | Provider/center registration, commercial profiles, marketplace placeholders, contact requests. | Commercial discovery exists; marketplace governance is incomplete. | `TRANSITIONAL` |
| `evolution.monitoring_system` | Monitoring System | Strategic evolution | Signal monitoring room, signal events, analytics summaries, monitoring operator role. | Monitoring surfaces and signals exist, but aggregation/persistence is partial. | `TRANSITIONAL` |
| `evolution.owner_constitutional_layer` | Owner Constitutional Layer | Strategic evolution | Owner district route family, owner role, owner-only gates, owner card-like units. | Surface exists; operational authority model is partial. | `TRANSITIONAL` |
| `evolution.archive_memory_layer` | Archive and Memory Layer | Strategic evolution | Owner strategic memory, sovereign vault, constitutional memory, archive doctrine references. | Mostly conceptual/static in current runtime. | `TRANSITIONAL` |

### 1.3 Existing Strategic Doctrines

| ID | Doctrine | Type | Observed Expression | Status | Classification |
|---|---|---|---|---|---|
| `doctrine.no_diagnosis` | No Diagnosis | Safety doctrine | Mental health support framing; app avoids diagnosis as operational output. | Present in product posture and policy direction. | `ACTIVE` |
| `doctrine.no_treatment_assignment` | No Treatment Assignment | Safety doctrine | Provider/center contact and discovery do not assign treatment. | Present by workflow design. | `ACTIVE` |
| `doctrine.no_booking_claim` | Contact, Not Booking | Marketplace doctrine | Contact started signals and contact request collections are present; booking system not observed. | Present by absence of booking runtime. | `ACTIVE` |
| `doctrine.readiness_visibility` | Readiness Before Visibility | Commercial doctrine | Clinician/center room routing checks visibility readiness. | Present in route gate behavior. | `ACTIVE` |
| `doctrine.signal_first` | Signal-First Operation | System doctrine | Runtime signal registry and signal package model exist. | Present, with partial persistence/aggregation. | `ACTIVE` |
| `doctrine.monitoring_observes` | Monitoring Observes | Governance doctrine | Monitoring room and analytics summaries observe events; no approval/execution behavior observed. | Partial implementation. | `TRANSITIONAL` |
| `doctrine.owner_sovereignty` | Owner Sovereignty | Governance doctrine | Owner-only routes and owner district exist. | Surface exists; full authority workflow not implemented. | `TRANSITIONAL` |
| `doctrine.archive_preservation` | Archive Preservation | Governance doctrine | Guide/archive docs and owner memory naming exist. | Mostly documentation/static surface. | `TRANSITIONAL` |

### 1.4 Existing Marketplace Doctrines

| ID | Doctrine | Surface | Observed State | Classification |
|---|---|---|---|---|
| `marketplace.provider_declaration` | Providers declare profile information | Commercial | Clinician registration and profile edit request flows exist. | `ACTIVE` |
| `marketplace.center_declaration` | Centers declare profile information | Commercial | Center registration and profile edit request flows exist. | `ACTIVE` |
| `marketplace.contact_signal` | Contact starts are signals | Commercial/Residential | Provider and center contact started signal types exist. | `ACTIVE` |
| `marketplace.marketplace_placeholder` | Marketplace district placeholder | City/Commercial | `/s/city/marketplace` routes to placeholder web surface. | `TRANSITIONAL` |
| `marketplace.no_endorsement_runtime` | No observed endorsement engine | Commercial | No ranking/endorsement runtime observed in snapshot. | `MISSING` |

### 1.5 Existing Federation Doctrines

| ID | Doctrine | Observed State | Classification |
|---|---|---|---|
| `federation.s_routes` | Federation surfaces use `/s` route family | `/s`, `/s/city`, `/s/capital`, `/s/owner`, and rooms exist. | `ACTIVE` |
| `federation.room_model` | Operational domains appear as rooms | Support room, registry room, declaration review room, signal monitoring room exist. | `ACTIVE` |
| `federation.city_capital_owner` | City/Capital/Owner district split | City, capital, and owner route families exist. | `ACTIVE` |
| `federation.placeholder_expansion` | Future surfaces can exist as placeholders | Many city/capital routes use `SWebSurfacePage`. | `TRANSITIONAL` |
| `federation.legacy_registries` | Earlier federation registries existed | Snapshot records many deleted federation/navigation/tool/signal registries. | `FROZEN` |

## 2. Current Surface Topology

### 2.1 Surface Summary

| Surface ID | Surface | Purpose | Owner | Current Status | Existing Components | Missing Components | Classification |
|---|---|---|---|---|---|---|---|
| `surface.residential` | Residential | Client personal space, dashboard, discovery, saved destinations, support entry, library access. | Client/Product, runtime authority through auth role. | Implemented across client dashboard and personal S space. | `/client/dashboard`, `/s/personal-space`, library, saved destinations, client signal tools. | Residential ownership registry, complete residential card registry, persistent signal summaries. | `ACTIVE` |
| `surface.commercial` | Commercial | Clinician and center registration, profile readiness, discovery, contact requests. | Clinician/Center/Product. | Implemented with route gates and profile edit request flows. | Provider/center registration, clinician/center rooms, specialist/center lists/details, contact request collections. | Runtime marketplace registry, commercial ownership registry, endorsement/marketplace governance registry. | `ACTIVE` |
| `surface.administrative` | Administrative | Registry stewardship, declaration review, support administration, operational control. | Owner plus specialized admin-like roles. | Split into S rooms and legacy admin deletions. | `/s/registry-room`, `/s/declaration-review-room`, `/chat/escalations`, `/chat/escalation/report`, support room. | Unified administrative surface registry, full role workflow model. | `TRANSITIONAL` |
| `surface.owner` | Owner | Sovereign owner district, owner memory, recovery, capsules, regeneration, strategic control. | Owner. | Owner route family exists. | `/s/owner/*`, owner district page, owner-only route gates, owner capsule cards. | Operational owner workflow registry, archive integration, owner action ledger. | `TRANSITIONAL` |
| `surface.monitoring` | Monitoring | Signal monitoring, analytics observation, capital operations. | Monitoring operator and owner. | Implemented partially. | `/s/capital/*`, `/s/capital/signal-monitoring-room`, signal events, analytics summaries, signal routing targets. | Persistent aggregate writer, monitoring registry, alert lifecycle registry. | `TRANSITIONAL` |
| `surface.legal_governance` | Legal Governance | Interpret policy, language, compliance, constitutional constraints. | Legal/Governance, owner. | Strong documentation presence; limited runtime role presence. | Language policy docs, surface permission matrix, guide docs, compliance lifecycle docs. | Runtime legal role, legal review route, governance action registry. | `TRANSITIONAL` |
| `surface.archive` | Archive | Preserve previous versions, memory, historical governance artifacts. | Archive/Owner. | Present mostly as doctrine and owner-memory naming. | Git history, docs, owner strategic memory naming, guide snapshot/card pack docs. | Runtime archive service, archive owner role, archive registry. | `TRANSITIONAL` |
| `surface.technical` | Technical | Build, route, deploy, integrate Firebase, maintain code and tools. | Technical/Product. | Active through repo, Flutter app, Firebase config, Cloud Functions, rules. | Flutter, Firebase, Firestore rules, Cloud Functions, Git. | Technical ownership registry, technical change lifecycle registry. | `ACTIVE` |
| `surface.public_portal` | Public Portal | Public entry, about, library, provider registration, service/package requests, contact. | Product/Public. | Active route family. | `/`, `/about`, `/library`, `/register/provider`, `/request/service`, `/request/package`, `/contact`. | Public surface registry and ownership map. | `ACTIVE` |
| `surface.city` | City | Public/commercial ecosystem district. | Product/Commercial. | Mostly placeholder routed. | `/s/city/*`, city district cards, city web surface placeholders. | Implemented city tools/services/providers marketplace content. | `TRANSITIONAL` |
| `surface.capital` | Capital | Operations, incidents, maintenance, broadcasts, emergency brief, trust/safety/reports placeholders. | Monitoring/Owner. | Mixed concrete and placeholder pages. | Capital operations office, signal monitoring room, capital route focuses. | Complete capital workflow registry and persistent monitoring actions. | `TRANSITIONAL` |
| `surface.support` | Support | Support paths, request cards, chat escalation support. | Support observer, owner. | Active, with room and support module. | `/s/support-room`, support request cards, support issue selector, chat/escalations. | Complete support signal registry and support ownership registry. | `ACTIVE` |
| `surface.localization` | Localization | Runtime app strings and surface language control. | Product/Legal/Governance. | Runtime generated localization exists; policy docs exist; drift observed. | ARB/generated localizations, language page, language policy documents. | Localization ownership registry, hardcoded string registry, full term validation runtime. | `TRANSITIONAL` |

## 3. Current Route Topology

### 3.1 Route Registry Object

| ID | Name | Type | Owner | Consumers | Dependencies | Produces | Consumes | Surface | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `registry.routes.runtime` | `Routes` | Runtime route constants | Technical | `AppRouter`, screens, navigation helpers | Flutter, route files | Route paths | Screen classes, auth state | All routed surfaces | Present and used | `ACTIVE` |
| `router.app_router` | `AppRouter` | Runtime route gate | Technical | App runtime | `Routes`, Firebase Auth, role claims, readiness checks | Screen selection and redirects | User roles, custom claims, route path | All routed surfaces | Present and central | `ACTIVE` |

### 3.2 Public Portal Routes

| Route Path | Screen | Surface | Purpose | Consumers | Dependencies | Current Status | Classification |
|---|---|---|---|---|---|---|---|
| `/` | `PortalHomePage` | Public Portal | Public landing. | Public users. | Flutter navigation, portal widgets. | Routed. | `ACTIVE` |
| `/about` | `PortalAboutPage` | Public Portal | Public about page. | Public users. | Portal widgets. | Routed. | `ACTIVE` |
| `/library` | `LibraryPage` | Public/Residential | Library access. | Public users, clients. | Library feature. | Routed. | `ACTIVE` |
| `/register/provider` | `WebClinicianRegisterPortalPage` | Commercial/Public | Provider registration entry. | Clinicians/providers. | Web registration feature. | Routed. | `ACTIVE` |
| `/request/service` | `PortalServiceRequestPage` | Public/Support | Service request entry. | Public users. | Portal request screen. | Routed. | `ACTIVE` |
| `/request/package` | `PortalPackageRequestPage` | Public/Commercial | Package request entry. | Public/commercial users. | Portal request screen. | Routed. | `ACTIVE` |
| `/contact` | `PortalContactPage` | Public/Support | Public contact. | Public users. | Portal contact screen. | Routed. | `ACTIVE` |
| `/splash` | `SplashPage` | Technical/Public | App startup splash. | App runtime. | Firebase initialization/navigation. | Routed. | `ACTIVE` |

### 3.3 S Surface Routes

| Route Path | Screen | Surface | Purpose | Consumers | Dependencies | Current Status | Classification |
|---|---|---|---|---|---|---|---|
| `/s` | `SSurfaceIndexPage` | S Index | Index for S surfaces. | Authenticated/navigation users. | S feature. | Routed. | `ACTIVE` |
| `/s/personal-space` | `SPersonalSpacePage` | Residential | Personal district and residential signal view. | Clients/residential users. | Signals, personal space widgets. | Routed. | `ACTIVE` |
| `/s/support-room` | `SSupportRoomPage` | Support/Admin | Support room overview. | Support observer, owner. | Support room feature, role gate. | Routed with authority. | `ACTIVE` |
| `/s/registry-room` | `SRegistryRoomPage` | Administrative | Registry stewardship view. | Registry steward, owner. | Registry room feature, role gate. | Routed with authority. | `ACTIVE` |
| `/s/declaration-review-room` | `SDeclarationReviewRoomPage` | Administrative/Legal | Declaration review view. | Declaration reviewer, owner. | Declaration readiness service, role gate. | Routed with authority. | `ACTIVE` |

### 3.4 City Routes

| Route Path | Screen | Surface | Purpose | Consumers | Dependencies | Current Status | Classification |
|---|---|---|---|---|---|---|---|
| `/s/city` | `SCityDistrictPage` | City | City district overview. | Public/commercial/residential ecosystem users. | City feature. | Routed. | `ACTIVE` |
| `/s/city/services` | `SWebSurfacePage` | City | Services placeholder. | City users. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |
| `/s/city/tools` | `SWebSurfacePage` | City | Tools placeholder. | City users. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |
| `/s/city/library` | `SWebSurfacePage` | City/Library | Library placeholder. | City users. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |
| `/s/city/providers` | `SWebSurfacePage` | City/Commercial | Providers placeholder. | Clients/public. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |
| `/s/city/centers` | `SWebSurfacePage` | City/Commercial | Centers placeholder. | Clients/public. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |
| `/s/city/organizations` | `SWebSurfacePage` | City/Commercial | Organizations placeholder. | City users. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |
| `/s/city/programs` | `SWebSurfacePage` | City/Commercial | Programs placeholder. | City users. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |
| `/s/city/marketplace` | `SWebSurfacePage` | City/Commercial | Marketplace placeholder. | City/commercial users. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |

### 3.5 Capital Routes

| Route Path | Screen | Surface | Purpose | Consumers | Dependencies | Current Status | Classification |
|---|---|---|---|---|---|---|---|
| `/s/capital` | `SCapitalOperationsOfficePage` | Capital/Monitoring | Capital overview. | Monitoring operator, owner. | Capital feature, role gate. | Routed with authority. | `ACTIVE` |
| `/s/capital/operations-office` | `SCapitalOperationsOfficePage` | Capital/Monitoring | Operations focus. | Monitoring operator, owner. | Capital feature. | Routed. | `ACTIVE` |
| `/s/capital/incidents` | `SCapitalOperationsOfficePage` | Capital/Monitoring | Incidents focus. | Monitoring operator, owner. | Capital feature. | Routed focus. | `TRANSITIONAL` |
| `/s/capital/maintenance` | `SCapitalOperationsOfficePage` | Capital/Technical | Maintenance focus. | Monitoring operator, owner. | Capital feature. | Routed focus. | `TRANSITIONAL` |
| `/s/capital/broadcasts` | `SCapitalOperationsOfficePage` | Capital/Administrative | Broadcasts focus. | Monitoring operator, owner. | Capital feature. | Routed focus. | `TRANSITIONAL` |
| `/s/capital/emergency-brief` | `SCapitalOperationsOfficePage` | Capital/Monitoring | Emergency brief focus. | Monitoring operator, owner. | Capital feature. | Routed focus. | `TRANSITIONAL` |
| `/s/capital/signal-monitoring-room` | `SSignalMonitoringRoomPage` | Monitoring | Signal observation room. | Monitoring operator, owner. | Signals, analytics summaries, role gate. | Routed with authority. | `ACTIVE` |
| `/s/capital/departments` | `SWebSurfacePage` | Capital/Admin | Departments placeholder. | Monitoring/operator users. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |
| `/s/capital/trust-safety` | `SWebSurfacePage` | Capital/Legal | Trust and safety placeholder. | Legal/governance/monitoring users. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |
| `/s/capital/reports` | `SWebSurfacePage` | Capital/Monitoring | Reports placeholder. | Monitoring users. | Placeholder surface. | Routed placeholder. | `TRANSITIONAL` |

### 3.6 Owner Routes

| Route Path | Screen | Surface | Purpose | Consumers | Dependencies | Current Status | Classification |
|---|---|---|---|---|---|---|---|
| `/s/owner` | `SOwnerDistrictPage` | Owner | Owner district overview. | Owner. | Owner role gate. | Routed owner-only. | `ACTIVE` |
| `/s/owner/room` | `SOwnerDistrictPage` | Owner | Owner room focus. | Owner. | Owner feature. | Routed focus. | `ACTIVE` |
| `/s/owner/sovereign-intelligence` | `SOwnerDistrictPage` | Owner | Sovereign intelligence focus. | Owner. | Owner feature. | Routed focus. | `TRANSITIONAL` |
| `/s/owner/strategic-memory` | `SOwnerDistrictPage` | Owner/Archive | Strategic memory focus. | Owner. | Owner feature. | Routed focus. | `TRANSITIONAL` |
| `/s/owner/sovereign-vault` | `SOwnerDistrictPage` | Owner/Archive | Sovereign vault focus. | Owner. | Owner feature. | Routed focus. | `TRANSITIONAL` |
| `/s/owner/constitutional-memory` | `SOwnerDistrictPage` | Owner/Archive | Constitutional memory focus. | Owner. | Owner feature. | Routed focus. | `TRANSITIONAL` |
| `/s/owner/recovery-console` | `SOwnerDistrictPage` | Owner/Technical | Recovery console focus. | Owner. | Owner feature. | Routed focus. | `TRANSITIONAL` |
| `/s/owner/capsules` | `SOwnerDistrictPage` | Owner/Archive | Capsules focus. | Owner. | Owner capsule cards. | Routed focus. | `TRANSITIONAL` |
| `/s/owner/regeneration` | `SOwnerDistrictPage` | Owner/Technical | Regeneration focus. | Owner. | Owner feature. | Routed focus. | `TRANSITIONAL` |

### 3.7 Web Registration and Library Routes

| Route Path | Screen | Surface | Purpose | Consumers | Dependencies | Current Status | Classification |
|---|---|---|---|---|---|---|---|
| `/web/center/register` | Web center registration screen | Commercial | Center registration start. | Centers. | Web registration feature. | Routed. | `ACTIVE` |
| `/web/center/register/profile` | Web center profile screen | Commercial | Center profile data. | Centers. | Firestore registration data. | Routed. | `ACTIVE` |
| `/web/center/register/media` | Web center media screen | Commercial | Center media data. | Centers. | Assets/media registration flow. | Routed. | `ACTIVE` |
| `/web/center/register/pricing` | Web center pricing screen | Commercial | Center pricing/package data. | Centers. | Web registration feature. | Routed. | `ACTIVE` |
| `/web/center/register/documents` | Web center documents screen | Commercial/Compliance | Center documents. | Centers. | Web registration feature. | Routed. | `ACTIVE` |
| `/web/clinician/register` | Web clinician registration screen | Commercial | Clinician registration start. | Clinicians. | Web registration feature. | Routed. | `ACTIVE` |
| `/web/clinician/register/profile` | Web clinician profile screen | Commercial | Clinician profile data. | Clinicians. | Web registration feature. | Routed. | `ACTIVE` |
| `/web/clinician/register/documents` | Web clinician documents screen | Commercial/Compliance | Clinician documents. | Clinicians. | Web registration feature. | Routed. | `ACTIVE` |
| `/web/library` | Web library screen | Library/Public | Web library. | Public/users. | Library feature. | Routed. | `ACTIVE` |
| `/web/library/policy` | Web library policy screen | Legal/Public | Policy display. | Public/users. | Policy content. | Routed. | `ACTIVE` |
| `/web/register/success` | Registration success screen | Commercial/Public | Registration completion. | Centers/clinicians. | Web registration feature. | Routed. | `ACTIVE` |

### 3.8 Core and Role Room Routes

| Route Path | Screen | Surface | Purpose | Consumers | Dependencies | Current Status | Classification |
|---|---|---|---|---|---|---|---|
| `/language` | `MkLanguagePage` | Localization | Language selection. | All users. | App localization. | Routed. | `ACTIVE` |
| `/home` | `MenuPage` | Core | Main menu. | Authenticated users. | Auth/router. | Routed. | `ACTIVE` |
| `/login` | `LoginPage` | Auth | Authentication. | All users. | Firebase Auth. | Routed. | `ACTIVE` |
| `/account-blocked` | `AccountBlockedPage` | Auth/Admin | Blocked account state. | Blocked users. | Auth status. | Routed. | `ACTIVE` |
| `/menu` | `MenuPage` | Core | Menu alias. | Authenticated users. | Auth/router. | Routed. | `ACTIVE` |
| `/register/client` | `ClientRegisterPage` | Residential/Auth | Client registration. | Clients. | Firebase Auth/Firestore. | Routed. | `ACTIVE` |
| `/register/clinician` | `WebClinicianRegisterPortalPage` | Commercial/Auth | Clinician registration alias. | Clinicians. | Web registration. | Routed. | `ACTIVE` |
| `/register/center` | `WebCenterRegisterPortalPage` | Commercial/Auth | Center registration alias. | Centers. | Web registration. | Routed. | `ACTIVE` |
| `/clinician/room` | Clinician room screen | Commercial | Clinician role room. | Clinicians. | Role gate, visibility readiness. | Routed with role/readiness gate. | `ACTIVE` |
| `/clinician/profile-edit-request` | Clinician profile edit request screen | Commercial/Compliance | Profile edit request. | Clinicians. | Firestore request collection. | Routed. | `ACTIVE` |
| `/clinician/chat-inbox` | Clinician chat inbox screen | Commercial/Support | Chat inbox. | Clinicians. | Chat feature. | Routed. | `ACTIVE` |
| `/client/dashboard` | `ClientDashboardPage` | Residential | Client dashboard. | Clients. | Role gate, signals, saved destinations. | Routed. | `ACTIVE` |
| `/center/dashboard` | Center dashboard screen | Commercial | Center dashboard. | Centers. | Role gate. | Routed. | `ACTIVE` |
| `/center/room` | Center room screen | Commercial | Center role room. | Centers. | Role gate, visibility readiness. | Routed with role/readiness gate. | `ACTIVE` |
| `/center/profile-edit-request` | Center profile edit request screen | Commercial/Compliance | Center edit request. | Centers. | Firestore request collection. | Routed. | `ACTIVE` |

### 3.9 Chat, Support, and Module Routes

| Route Path | Screen | Surface | Purpose | Consumers | Dependencies | Current Status | Classification |
|---|---|---|---|---|---|---|---|
| `/chat` | Chat screen | Support | Chat entry. | Users. | Chat feature, Firestore. | Routed. | `ACTIVE` |
| `/chat/escalations` | Chat escalations screen | Support/Admin | Escalation list. | Support/admin roles. | Chat escalation collections. | Routed. | `ACTIVE` |
| `/chat/escalation/report` | Chat escalation report screen | Support/Admin | Escalation report. | Support/admin roles. | Chat escalation reports. | Routed. | `ACTIVE` |
| `/module/addiction` | Addiction module screen | Residential/Support | Addiction support module. | Clients/users. | Module feature. | Routed. | `ACTIVE` |
| `/module/special_needs` | Special needs module screen | Residential/Support | Special needs support module. | Clients/users. | Module feature. | Routed. | `ACTIVE` |
| `/module/support-issue-selector` | Support issue selector screen | Support | Support path selection. | Users. | Support module. | Routed. | `ACTIVE` |
| `/module/specialists` | Specialists module screen | Commercial/Residential | Specialist discovery. | Clients/users. | Specialists feature. | Routed. | `ACTIVE` |
| `/module/specialists/list` | Specialists list screen | Commercial/Residential | Specialist listing. | Clients/users. | Specialists feature. | Routed. | `ACTIVE` |
| `/module/specialists/details` | Specialist details screen | Commercial/Residential | Specialist profile detail. | Clients/users. | Specialists feature, contact signals. | Routed. | `ACTIVE` |
| `/module/centers` | Centers module screen | Commercial/Residential | Center discovery. | Clients/users. | Centers feature. | Routed. | `ACTIVE` |
| `/module/centers/list` | Centers list screen | Commercial/Residential | Center listing. | Clients/users. | Centers feature. | Routed. | `ACTIVE` |
| `/module/centers/details` | Center details screen | Commercial/Residential | Center profile detail. | Clients/users. | Centers feature, contact signals. | Routed. | `ACTIVE` |
| `/module/library` | Module library screen | Library/Residential | Library module. | Clients/users. | Library feature. | Routed. | `ACTIVE` |

## 4. Current Role Topology

| Role ID | Role Name | Responsibilities | Permissions | Dependencies | Authority Scope | Current Status | Classification |
|---|---|---|---|---|---|---|---|
| `role.owner` | Owner | Access owner district, owner-only surfaces, capital/admin authority where permitted. | Owner custom claim/role gate; access to owner routes and selected admin rooms. | Firebase Auth custom claims, AppRouter, Firestore rules. | Sovereign/owner scope. | Runtime role present. | `ACTIVE` |
| `role.monitoring_operator` | Monitoring Operator | Observe monitoring/capital/signal surfaces. | Access capital and signal monitoring routes. | Role claims, signal events, analytics summaries. | Monitoring scope. | Runtime role present. | `ACTIVE` |
| `role.registry_steward` | Registry Steward | View registry room and registry domain cards. | Access registry room with owner/role gate. | AppRouter, S registry room. | Registry scope. | Runtime role present. | `ACTIVE` |
| `role.declaration_reviewer` | Declaration Reviewer | Review readiness/declaration records. | Access declaration review room with owner/role gate. | Declaration readiness service, AppRouter. | Declaration/compliance scope. | Runtime role present. | `ACTIVE` |
| `role.support_observer` | Support Observer | Observe support requests and support room. | Access support room with owner/role gate. | Support request collection, AppRouter. | Support observation scope. | Runtime role present. | `ACTIVE` |
| `role.client` | Client | Use residential dashboard, personal space, saved destinations, support/library/discovery tools. | Client route access and client Firestore permissions. | Firebase Auth, clients collection, AppRouter. | Residential user scope. | Runtime role present. | `ACTIVE` |
| `role.center` | Center | Manage center profile/room/dashboard and contact readiness. | Center route access when role/readiness permit. | Firebase Auth, centers collection, visibility readiness. | Commercial center scope. | Runtime role present. | `ACTIVE` |
| `role.clinician` | Clinician | Manage clinician profile/room/inbox and contact readiness. | Clinician route access when role/readiness permit. | Firebase Auth, clinicians collection, visibility readiness. | Commercial clinician scope. | Runtime role present. | `ACTIVE` |
| `role.legal_governance` | Legal & Governance | Interpret policy, language, compliance, authority. | No dedicated runtime role observed. | Policy docs, language docs, guide docs. | Governance interpretation scope. | Documented/conceptual only. | `TRANSITIONAL` |
| `role.technical` | Technical | Build, route, integrate, maintain app/Firebase. | Repository and Firebase project access outside app runtime. | Flutter, Firebase, Git, Codex/IDE. | Technical execution scope. | Operational role exists outside runtime. | `ACTIVE` |
| `role.compliance_agent` | Compliance Agent | Observe guide/card mismatch and unclosed operations. | No runtime modify/approve/execute authority observed. | Guide docs/card pack docs from existing docs. | Compliance observation scope. | Documentation presence only. | `TRANSITIONAL` |
| `role.archive` | Archive | Preserve previous versions and historical records. | No runtime archive authority observed. | Git, docs, owner memory naming. | Archive preservation scope. | Mostly conceptual/documentary. | `TRANSITIONAL` |

## 5. Current Signal Topology

### 5.1 Runtime Signal Model

| Signal Object ID | Name | Type | Owner | Consumers | Dependencies | Produces | Consumes | Surface | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `signal.model.package` | `SignalPackage` | Data model | Technical/Monitoring | Signal storage, aggregation, monitoring | Signal registry, actor/session data | Structured signal event | User action metadata | Cross-surface | Present | `ACTIVE` |
| `signal.registry.type` | `SignalTypeRegistry` | Runtime signal registry | Technical/Monitoring | Signal factories, storage, monitoring | Signal definitions | Type metadata and routing | Signal type IDs | Cross-surface | Present | `ACTIVE` |
| `signal.storage.events` | `SignalStorageService` | Persistence service | Technical/Monitoring | Firestore, monitoring | Firebase Firestore | `signal_events` writes | Signal packages | Monitoring | Present | `ACTIVE` |
| `signal.aggregation.memory` | `SignalAggregationEngine` | Aggregation engine | Monitoring/Technical | Dashboard/monitoring summaries | Signal events | In-memory aggregates | Runtime signals | Monitoring | Present but not fully persistent | `TRANSITIONAL` |
| `signal.firestore.aggregates` | `signal_aggregates` | Firestore collection | Monitoring | Monitoring reads | Firestore rules | Aggregate read model | Aggregate writes from unknown source | Monitoring | Read-only in rules; writer not fully observed | `TRANSITIONAL` |

### 5.2 Implemented Signal Types

| Signal ID | Name | Category | Domain | Producer | Consumer | Routing Target | Privacy | Retention | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `goal_selected` | Goal Selected | Goal | Residential | Client dashboard/register flows | Residential monitoring/owner summary | `residential_monitoring` | Internal/public aggregate depending context | Aggregate/summary | Implemented | `ACTIVE` |
| `interest_selected` | Interest Selected | Interest | Residential | Client option selections | Residential monitoring | `residential_monitoring` | Aggregate | Aggregate | Implemented | `ACTIVE` |
| `accessibility_interest` | Accessibility Interest | Accessibility | Residential | Client accessibility options | Residential monitoring | `residential_monitoring` | Restricted/internal aggregate | Aggregate | Implemented | `ACTIVE` |
| `communication_preference_selected` | Communication Preference Selected | Communication | Residential | Client communication options | Residential monitoring | `residential_monitoring` | Internal aggregate | Aggregate | Implemented | `ACTIVE` |
| `destination_saved` | Destination Saved | Destination | Residential/Commercial | Saved destination service | Residential/commercial monitoring | `residential_monitoring` | Internal aggregate | Aggregate | Implemented | `ACTIVE` |
| `provider_contact_started` | Provider Contact Started | Contact | Commercial | Specialist/provider detail contact action | Commercial monitoring | `commercial_monitoring` | Internal aggregate | Aggregate | Implemented | `ACTIVE` |
| `center_contact_started` | Center Contact Started | Contact | Commercial | Center detail contact action | Commercial monitoring | `commercial_monitoring` | Internal aggregate | Aggregate | Implemented | `ACTIVE` |
| `support_started` | Support Started | Support | Support/Residential | Support entry/action | Support monitoring | `support_monitoring` | Restricted/internal | Short term/aggregate | Implemented | `ACTIVE` |
| `library_category_opened` | Library Category Opened | Library | Library/Residential | Library category open | Residential/library monitoring | `residential_monitoring` | Public/internal aggregate | Aggregate | Implemented | `ACTIVE` |
| `provider_profile_opened` | Provider Profile Opened | Capability/Commercial | Commercial | Provider profile open | Commercial monitoring | `commercial_monitoring` | Public/internal aggregate | Aggregate | Implemented | `ACTIVE` |
| `center_profile_opened` | Center Profile Opened | Capability/Commercial | Commercial | Center profile open | Commercial monitoring | `commercial_monitoring` | Public/internal aggregate | Aggregate | Implemented | `ACTIVE` |

### 5.3 Conceptual, Missing, Legacy, and Frozen Signals

| Signal Area ID | Name | Type | Current State | Classification |
|---|---|---|---|---|
| `signal.declaration_readiness` | Declaration Readiness Signals | Conceptual/partial | Declaration readiness records exist, but no complete signal registry was observed. | `TRANSITIONAL` |
| `signal.provider_capabilities` | Provider Capability Signals | Conceptual/partial | Provider/center capabilities influence readiness and profiles; complete signal ownership is not observed. | `TRANSITIONAL` |
| `signal.chat_safety` | Chat Safety Signals | Conceptual/partial | Chat escalations and reports exist; unified safety signal registry is not observed. | `TRANSITIONAL` |
| `signal.recommendation_magnet` | Recommendation Signal Magnet | Conceptual | Recommendation signal magnet registries are mentioned as transitional. | `TRANSITIONAL` |
| `signal.option_registries` | Client/Provider Option Signals | Missing runtime registry | Client/provider option selections exist in UI, but ownership/registry completeness is missing. | `MISSING` |
| `signal.persistent_aggregate_writer` | Persistent Aggregate Writer | Missing runtime service | `signal_aggregates` exists as read model but complete writer path is not observed. | `MISSING` |
| `signal.legacy_federation_registries` | Legacy Federation Signal Registries | Legacy/frozen | Deleted launch/readiness/surfaces/tool meter/observatory/provider/client registries are recorded in snapshot. | `FROZEN` |

## 6. Current Card Topology

### 6.1 Runtime Card Registry State

| ID | Name | Type | Owner | Consumers | Dependencies | Produces | Consumes | Surface | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `card.registry.runtime` | Runtime Card Registry | Registry | Unknown | Screens/cards | None observed | Card ownership/metadata | Card definitions | Cross-surface | Not observed | `MISSING` |
| `card.registry.docs` | `docs/registry/S_CARD_REGISTRY_V1.md` | Documentation registry | Governance/Technical | Docs/process | Docs | Card inventory | Current card observations | Cross-surface | Present as docs | `TRANSITIONAL` |

### 6.2 Existing Card-Like Units and Operational Units

| Card/Object ID | Name | Type | Owner | Consumers | Dependencies | Produces | Consumes | Surface | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `card.menu.data` | `_MenuCardData` | UI card data | Technical/Product | `MenuPage` | Menu feature | Menu card model | Route/label/icon data | Core | Implemented | `ACTIVE` |
| `card.menu.circle_button` | `_MenuCircleButton` | UI card/button | Technical/Product | `MenuPage` | Flutter widgets | Navigation action | Route data | Core | Implemented | `ACTIVE` |
| `card.menu.library_teaser_hearts` | Library teaser hearts | UI card-like unit | Product | Menu users | Library feature | Library teaser | Library content | Core/Library | Implemented | `ACTIVE` |
| `card.menu.role_shortcut` | Role shortcut | UI operational unit | Product/Technical | Authenticated users | Role state/routes | Role navigation | Role/route data | Core | Implemented | `ACTIVE` |
| `card.client.theme_catalog` | `_ThemeCatalogCard` | UI card | Residential/Product | Client dashboard | Client dashboard | Theme catalog display | Theme data | Residential | Implemented | `ACTIVE` |
| `card.client.tool` | `_ToolCard` | UI card | Residential/Product | Client dashboard | Tool specs | Tool navigation/action | Local tool data | Residential | Implemented | `ACTIVE` |
| `card.client.signal_summary` | `_SignalSummaryCard` | UI card | Monitoring/Residential | Client dashboard | Signal aggregate data | Signal summary | Signal data | Residential/Monitoring | Implemented | `ACTIVE` |
| `card.client.saved_summary` | `_SavedSummaryCard` | UI card | Residential | Client dashboard | Saved destinations | Saved item summary | Saved destination data | Residential | Implemented | `ACTIVE` |
| `card.client.next_steps` | `_NextStepsCard` | UI card | Residential/Product | Client dashboard | Dashboard content | Next steps display | Static/dynamic guidance | Residential | Implemented | `ACTIVE` |
| `card.client.guidance` | `_GuidanceCard` | UI card | Residential/Product | Client dashboard | Dashboard content | Guidance display | Guidance data | Residential | Implemented | `ACTIVE` |
| `card.client.panel` | `_Panel` | UI layout card | Technical/Product | Client dashboard | Flutter UI | Panel container | Child widgets | Residential | Implemented | `ACTIVE` |
| `card.client.signal_chip` | `_SignalChip` | UI chip/card fragment | Monitoring/Residential | Client dashboard | Signal data | Signal indicator | Signal metadata | Residential | Implemented | `ACTIVE` |
| `card.client.step_tile` | `_StepTile` | UI tile/card fragment | Residential/Product | Client dashboard | Dashboard content | Step display | Step data | Residential | Implemented | `ACTIVE` |
| `card.personal.overview` | `_PersonalSpaceOverviewCard` | UI card | Residential | Personal space | Personal space feature | Overview | Personal surface data | Residential | Implemented | `ACTIVE` |
| `card.personal.signal_summary` | `_SignalSummaryCard` | UI card | Monitoring/Residential | Personal space | Signals | Signal summary | Signal data | Residential/Monitoring | Implemented | `ACTIVE` |
| `card.personal.signal_health` | `_SignalHealthCard` | UI card | Monitoring/Residential | Personal space | Signals | Signal health view | Signal data | Residential/Monitoring | Implemented | `ACTIVE` |
| `card.personal.district` | `_PersonalDistrictCard` | UI card | Residential | Personal space | Route data | District navigation | District metadata | Residential | Implemented | `ACTIVE` |
| `card.personal.placeholder_district` | `_PlaceholderDistrictCard` | UI card | Residential/Product | Personal space | Placeholder metadata | Placeholder district | Static metadata | Residential | Implemented | `TRANSITIONAL` |
| `card.personal.surface` | `_SurfaceCard` | UI card | Residential/Product | Personal space | Surface metadata | Surface navigation/display | Surface data | Residential | Implemented | `ACTIVE` |
| `card.signal.board` | `SignalCommunicationBoard` | Operational UI card set | Monitoring/Residential | Personal space/client surfaces | Signals/content lanes | Signal communication board | Notices/recommendations/resources | Residential/Monitoring | Implemented | `ACTIVE` |
| `card.signal.notes_lane` | Signal Notes Lane | Board lane | Monitoring | Signal board consumers | SignalCommunicationBoard | Notes display | Signal notes | Monitoring | Implemented | `ACTIVE` |
| `card.signal.safety_notices_lane` | Safety Notices Lane | Board lane | Monitoring/Legal | Signal board consumers | SignalCommunicationBoard | Safety notices | Safety notice content | Monitoring/Support | Implemented | `ACTIVE` |
| `card.signal.recommendations_lane` | Recommendations Lane | Board lane | Product/Monitoring | Signal board consumers | SignalCommunicationBoard | Recommendations display | Recommendation content | Residential | Implemented | `TRANSITIONAL` |
| `card.signal.resource_updates_lane` | Resource Updates Lane | Board lane | Product/Monitoring | Signal board consumers | SignalCommunicationBoard | Resource updates | Resource content | Residential/Library | Implemented | `ACTIVE` |
| `card.capital.overview` | `_CapitalOverviewCard` | UI card | Monitoring/Owner | Capital office | Capital feature | Capital overview | Capital metadata | Capital | Implemented | `ACTIVE` |
| `card.capital.card` | `_CapitalCard` | UI card | Monitoring | Capital office | Capital feature | Operational display | Capital item data | Capital | Implemented | `ACTIVE` |
| `card.capital.district` | `_DistrictCard` | UI card | Monitoring | Capital office | Route metadata | District navigation | District data | Capital | Implemented | `ACTIVE` |
| `card.monitoring.control` | `_ControlCard` | UI card | Monitoring | Signal monitoring room | Monitoring feature | Control display | Control metadata | Monitoring | Implemented | `ACTIVE` |
| `card.monitoring.section` | `_SectionCard` | UI card | Monitoring | Signal monitoring room | Monitoring feature | Section display | Monitoring data | Monitoring | Implemented | `ACTIVE` |
| `card.city.overview` | `_CityOverviewCard` | UI card | City/Product | City district | City feature | City overview | City metadata | City | Implemented | `ACTIVE` |
| `card.city.card` | `_CityCard` | UI card | City/Product | City district | City feature | City item display | City item data | City | Implemented | `ACTIVE` |
| `card.city.district` | `_DistrictCard` | UI card | City/Product | City district | Route metadata | District navigation | District data | City | Implemented | `ACTIVE` |
| `card.owner.overview` | `_OwnerOverviewCard` | UI card | Owner | Owner district | Owner feature | Owner overview | Owner metadata | Owner | Implemented | `ACTIVE` |
| `card.owner.card` | `_OwnerCard` | UI card | Owner | Owner district | Owner feature | Owner item display | Owner item data | Owner | Implemented | `ACTIVE` |
| `card.owner.district` | `_DistrictCard` | UI card | Owner | Owner district | Route metadata | Owner district navigation | District data | Owner | Implemented | `ACTIVE` |
| `card.owner.capsule` | `_CapsuleCard` | UI card | Owner/Archive | Owner district | Owner capsule metadata | Capsule display | Capsule data | Owner/Archive | Implemented static | `TRANSITIONAL` |
| `card.registry.domain` | `_RegistryDomainCard` | UI card | Registry Steward/Owner | Registry room | Registry room feature | Registry domain display | Domain metadata | Administrative | Implemented | `ACTIVE` |
| `card.support.request` | `_SupportRequestCard` | UI card | Support | Support room | Support requests | Support request display | Support request data | Support | Implemented | `ACTIVE` |
| `card.declaration.record` | `_DeclarationRecordCard` | UI card | Declaration Reviewer/Legal | Declaration review room | Declaration readiness | Declaration record display | Declaration data | Administrative/Legal | Implemented | `ACTIVE` |
| `card.declaration.summary` | `_SummaryCard` | UI card | Declaration Reviewer/Legal | Declaration review room | Declaration readiness | Summary display | Declaration summary data | Administrative/Legal | Implemented | `ACTIVE` |
| `card.web_surface.navigation` | `_SurfaceNavigationCard` | UI card | Product | S web surface pages | Route metadata | Placeholder navigation | Surface metadata | City/Capital | Implemented | `TRANSITIONAL` |
| `card.library.featured_heart` | `_LibraryFeaturedHeartCard` | UI card | Library/Product | Library page | Library content | Featured library display | Library content | Library | Implemented | `ACTIVE` |
| `card.library.carousel` | `_LibraryCarouselCard` | UI card | Library/Product | Library page | Library content | Carousel display | Library items | Library | Implemented | `ACTIVE` |
| `card.library.policy` | `_PolicyCard` | UI card | Legal/Library | Library policy page | Policy content | Policy display | Policy text | Legal/Public | Implemented | `ACTIVE` |
| `card.support.path` | `_SupportPathCard` | UI card | Support | Support entry | Support module | Support path display | Support path data | Support | Implemented | `ACTIVE` |
| `card.support.addiction` | `_AddictionCard` | UI card | Support/Residential | Addiction module | Module content | Addiction support display | Module data | Support | Implemented | `ACTIVE` |
| `card.centers.category` | `_CenterCategoryCard` | UI card | Commercial | Centers module | Centers feature | Center category display | Category data | Commercial | Implemented | `ACTIVE` |
| `card.centers.section` | `_sectionCard` / `_SectionCard` | UI card | Commercial | Center screens | Centers feature | Section display | Center data | Commercial | Implemented | `ACTIVE` |
| `card.centers.mini_contact` | `_MiniContactCard` | UI card | Commercial | Center details | Contact request/signal | Contact action display | Center contact data | Commercial | Implemented | `ACTIVE` |
| `card.centers.grid_info` | `_GridInfoCard` | UI card | Commercial | Center details | Center data | Grid info display | Center metadata | Commercial | Implemented | `ACTIVE` |
| `card.centers.gallery` | `_CenterGalleryCard` | UI card | Commercial | Center details | Center media | Gallery display | Center media | Commercial | Implemented | `ACTIVE` |
| `card.specialists.category` | `_SpecialistCategoryCard` | UI card | Commercial | Specialists module | Specialists feature | Specialist category display | Category data | Commercial | Implemented | `ACTIVE` |
| `card.specialists.info_mini` | `_InfoMiniCard` | UI card | Commercial | Specialist details | Specialist data | Info display | Specialist metadata | Commercial | Implemented | `ACTIVE` |
| `card.registration.client_signal_option` | `_ClientSignalOption` | UI card/input | Residential/Auth | Client registration | Signal option data | Client option selection | Option metadata | Residential/Auth | Implemented | `ACTIVE` |
| `card.registration.client_signal_section` | `_ClientSignalSection` | UI card/input group | Residential/Auth | Client registration | Signal option data | Client signal section | Option metadata | Residential/Auth | Implemented | `ACTIVE` |
| `card.registration.provider_signal_option` | `_ProviderSignalOption` | UI card/input | Commercial/Auth | Provider registration | Provider option data | Provider option selection | Option metadata | Commercial/Auth | Implemented | `ACTIVE` |
| `card.registration.web_center_steps` | Web center step cards/forms | Workflow cards | Commercial/Auth | Center registration | Web registration feature | Center registration steps | Form data | Commercial/Auth | Implemented | `ACTIVE` |

## 7. Current Tool Topology

### 7.1 Platform and Development Tools

| Tool ID | Name | Type | Owner | Consumers | Dependencies | Produces | Consumes | Surface | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `tool.flutter` | Flutter | Runtime framework | Technical | App runtime, screens, widgets | Dart, packages | Mobile/web UI | App source | Technical | Active project framework | `ACTIVE` |
| `tool.firebase` | Firebase | Backend platform | Technical | Auth, Firestore, Analytics, Functions | Firebase config | Backend services | App/backend calls | Technical | Configured | `ACTIVE` |
| `tool.firestore` | Firestore | Database | Technical | App features, rules, functions | Firebase | Collections/read models | Documents, rules | Technical/Cross-surface | Active | `ACTIVE` |
| `tool.cloud_functions` | Cloud Functions | Backend compute | Technical/Monitoring | Analytics summaries | Firebase Functions, Firestore | Scheduled summaries | Signal/analytics data | Monitoring | Present | `ACTIVE` |
| `tool.git` | Git | Version control | Technical/Archive | Developers/archive | Repository | History/diffs | Source changes | Technical/Archive | Active; dirty tree noted in snapshot | `ACTIVE` |
| `tool.codex` | Codex | Development/audit tool | Technical | Current workspace operations | Repo access | Documentation/audit artifacts | Source/docs | Technical | External to runtime | `ACTIVE` |
| `tool.gpt` | GPT | AI assistant/tooling concept | Technical/Product | Chat/assistant concepts, development | Unknown runtime integration | AI assistance where configured | Prompts/policies | Technical/Support | Runtime integration not fully established | `UNKNOWN` |
| `tool.android_studio` | Android Studio | IDE/toolchain | Technical | Developers | Flutter/Android SDK | Builds/debugging | Source/project config | Technical | External tool; repo evidence indirect | `UNKNOWN` |
| `tool.monitoring_tools` | Monitoring Tools | Runtime/admin tools | Monitoring/Technical | Monitoring operator, owner | Signal events, analytics summaries, monitoring room | Monitoring views | Signals/summaries | Monitoring | Partial runtime tools exist | `TRANSITIONAL` |

### 7.2 Product Runtime Tools

| Tool ID | Name | Type | Owner | Consumers | Dependencies | Produces | Consumes | Surface | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `tool.client.local_specs` | Client dashboard tools | UI-local tool specs | Residential/Product | Client dashboard | `_ToolSpec`, routes | Tool cards/navigation | Local config | Residential | Present without runtime registry | `TRANSITIONAL` |
| `tool.add_tool_placeholder` | Add Tool Placeholder | Placeholder tool | Residential/Product | Client dashboard | UI-local spec | Placeholder action | None/static | Residential | Present as placeholder | `TRANSITIONAL` |
| `tool.library` | Library Tool | Content/discovery tool | Library/Product | Public/residential users | Library feature | Library access and signals | Library content | Library/Residential | Active | `ACTIVE` |
| `tool.saved_destinations` | Saved Destinations Tool | Residential tool/service | Residential | Clients | Firestore, saved destination repository | Saved destinations and signals | Destination metadata | Residential | Active | `ACTIVE` |
| `tool.support_selector` | Support Issue Selector | Support tool | Support | Users | Support module | Support path selection | User issue choice | Support | Active | `ACTIVE` |
| `tool.city_explore` | City Explore Tool | Discovery/navigation tool | City/Product | City users | City route/surface data | Navigation to city surfaces | Surface metadata | City | Partial | `TRANSITIONAL` |
| `tool.signal_communication_board` | Signal Communication Board | Monitoring/communication tool | Monitoring/Product | Residential/personal space | Board lanes, signal content | Notes/notices/recommendations/resources | Signal/content data | Monitoring/Residential | Active | `ACTIVE` |
| `tool.analytics_summary_writer` | Analytics Summary Writer | Cloud Function | Technical/Monitoring | Monitoring summaries | Cloud Functions, Firestore | `analytics_summaries` | Events/metrics | Monitoring | Active | `ACTIVE` |
| `tool.domain_status_seeder` | Domain Status Seeder | Dev/admin tool | Technical/Admin | Developers/admin setup | Firestore | `system_domains` seed data | Domain metadata | Technical/Admin | Present | `ACTIVE` |
| `tool.ai_policy_seeder` | AI Policy Seeder | Dev/admin tool | Technical/Legal | Developers/admin setup | Firestore | `ai_policies` seed data | Policy metadata | Legal/Technical | Present | `ACTIVE` |
| `tool.legacy_tool_registry` | Legacy Tool Registry | Removed/frozen registry | Technical | None active observed | Deleted legacy files | None | None | Technical | Deleted/frozen | `FROZEN` |
| `tool.legacy_tool_meter` | Tool Meter Federation | Removed/frozen system | Monitoring/Technical | None active observed | Deleted legacy files | None | None | Monitoring | Deleted/frozen | `FROZEN` |

## 8. Current Registry Readiness

| Registry ID | Registry Name | Current Object | Readiness | Owner | Consumers | Missing Elements | Classification |
|---|---|---|---|---|---|---|---|
| `registry.route` | Route Registry | `Routes` and `AppRouter` | Runtime-ready for path constants and route gates. | Technical | App runtime | Route metadata registry, route ownership registry, route surface classification registry. | `ACTIVE` |
| `registry.card` | Card Registry | Docs registry only; runtime registry not observed. | Documentation-ready; runtime-not-ready. | Governance/Technical | Docs/process | Runtime card IDs, ownership, consumers, status, lifecycle. | `TRANSITIONAL` |
| `registry.signal` | Signal Registry | `SignalTypeRegistry` plus signal model/services. | Runtime base ready; domain coverage incomplete. | Monitoring/Technical | Signal storage, monitoring, dashboards | Option registries, support safety registry, declaration signal registry, persistent aggregate writer. | `TRANSITIONAL` |
| `registry.tool` | Tool Registry | No active runtime registry; local tool specs and frozen legacy registry. | Not runtime-ready. | Technical/Product | Client dashboard/tools | Runtime tool IDs, owners, surfaces, permissions. | `MISSING` |
| `registry.localization` | Localization Registry | Generated localizations plus docs/policies. | Runtime strings active; governance registry partial. | Legal/Product/Technical | App UI, language page | Ownership registry, hardcoded string inventory, runtime term validation. | `TRANSITIONAL` |
| `registry.ownership` | Ownership Registry | Roles and partial domain ownership in docs/surfaces. | Partial. | Owner/Governance | Routes, surfaces, cards, signals | Explicit owners for many cards, assets, tools, localization strings, collections. | `MISSING` |
| `registry.compliance` | Compliance Registry | Compliance docs/guides exist; runtime registry not observed. | Documentation presence; runtime-not-ready. | Legal/Governance/Compliance | Governance process | Runtime compliance objects, issue lifecycle, enforcement states. | `TRANSITIONAL` |
| `registry.asset` | Asset Registry | `AppAssets` partial root logo registry plus asset folders. | Partial. | Product/Technical | UI/screens | Complete asset IDs, owner mapping, surface mapping, unused asset audit. | `TRANSITIONAL` |
| `registry.collection` | Firestore Collection Registry | Firestore rules and usage paths. | Operational collections exist; registry form partial. | Technical | App/Firebase | Collection ownership map, lifecycle classification, compliance mapping. | `TRANSITIONAL` |

## 9. Current Workforce Readiness

| Workforce ID | Workforce Area | Responsibilities | Observed Runtime/Docs | Current Readiness | Missing Workforce Definitions | Classification |
|---|---|---|---|---|---|---|
| `workforce.owner` | Owner | Sovereign authority, owner district, selected admin/monitoring authority. | Owner role and owner route family exist. | High runtime presence, partial operational model. | Owner action lifecycle, owner authorization ledger. | `ACTIVE` |
| `workforce.legal` | Legal & Governance | Interpret policy, language, compliance, permissions. | Policy docs, permission matrix, language validation docs, guide docs. | Strong docs presence, weak runtime presence. | Dedicated runtime role, review queue, legal authority boundaries in app. | `TRANSITIONAL` |
| `workforce.technical` | Technical | Implement app, Firebase, routes, tools, rules, functions. | Flutter/Firebase repo, Firestore rules, Cloud Functions, Git. | Active and operational. | Explicit technical ownership registry and change authority registry. | `ACTIVE` |
| `workforce.monitoring` | Monitoring | Observe signals, summaries, incidents, capital surfaces. | Monitoring operator role, capital/signal monitoring rooms, analytics summaries. | Partial runtime presence. | Alert lifecycle, persistent aggregate writer, monitoring report registry. | `TRANSITIONAL` |
| `workforce.compliance` | Compliance | Compare governance state, detect mismatch, escalate without modifying. | Compliance docs/guides exist; no runtime compliance agent observed. | Documentation-only/partial. | Runtime compliance registry, compliance role, open operation tracker. | `TRANSITIONAL` |
| `workforce.archive` | Archive | Preserve previous versions and historical governance artifacts. | Git history, docs, owner memory route names. | Mostly documentary/static. | Archive role, archive registry, archive runtime surface. | `TRANSITIONAL` |
| `workforce.support` | Support | Observe/support requests and escalations. | Support observer role, support room, chat escalations. | Active surface presence. | Support ownership registry and support signal registry. | `ACTIVE` |
| `workforce.registry` | Registry Stewardship | Observe registry domains and readiness. | Registry steward role and registry room. | Active surface presence. | Complete registry lifecycle and ownership map. | `TRANSITIONAL` |
| `workforce.declaration_review` | Declaration Review | Review declaration/readiness records. | Declaration reviewer role and declaration review room. | Active surface presence. | Complete declaration registry and signal ownership. | `TRANSITIONAL` |

## 10. Gap Analysis

This section records missing or incomplete constitutional elements only. It does not recommend implementation steps.

### 10.1 Missing Constitutional Elements

| Gap ID | Element | Current Evidence | Affected Surfaces | Classification |
|---|---|---|---|---|
| `gap.constitution.runtime_authority_model` | Runtime authority model for Legal/Governance, Compliance, Archive | Roles exist for owner/monitoring/registry/declaration/support/client/center/clinician; legal/compliance/archive are mostly documentary. | Legal Governance, Compliance, Archive | `MISSING` |
| `gap.constitution.ownership_map` | Complete ownership map | Many cards/assets/tools/routes have inferred owners only. | All surfaces | `MISSING` |
| `gap.constitution.lifecycle_states` | Unified lifecycle state model for cards/signals/tools/routes | Docs describe states, runtime objects do not expose full lifecycle. | Governance/Technical | `TRANSITIONAL` |
| `gap.constitution.archive_runtime` | Runtime archive/memory preservation surface | Owner memory route names exist; archive service/registry not observed. | Archive/Owner | `MISSING` |
| `gap.constitution.compliance_runtime` | Runtime compliance tracking | Compliance docs exist; no runtime compliance registry/agent observed. | Compliance/Legal | `MISSING` |

### 10.2 Missing Guides

| Gap ID | Guide Domain | Current Evidence | Classification |
|---|---|---|---|
| `gap.guide.runtime_binding` | Runtime binding guide between docs and code objects | Existing docs/guides are present, but binding to runtime IDs is incomplete. | `TRANSITIONAL` |
| `gap.guide.owner_action` | Owner action authority guide | Owner surface exists; action lifecycle is not fully mapped. | `MISSING` |
| `gap.guide.archive` | Archive runtime guide | Archive doctrine exists; runtime archive surface is not implemented. | `MISSING` |
| `gap.guide.monitoring_alerts` | Monitoring alert lifecycle guide | Monitoring surfaces exist; alert lifecycle is incomplete. | `MISSING` |
| `gap.guide.marketplace_governance` | Marketplace governance guide | Marketplace/commercial flows exist; full marketplace governance not observed. | `MISSING` |

### 10.3 Missing Registries

| Gap ID | Registry | Current Evidence | Classification |
|---|---|---|---|
| `gap.registry.card_runtime` | Runtime card registry | Card-like widgets exist; no runtime registry observed. | `MISSING` |
| `gap.registry.tool_runtime` | Runtime tool registry | Local tool specs and frozen legacy registry; no active central registry. | `MISSING` |
| `gap.registry.ownership` | Ownership registry | Owners are inferred from roles/surfaces; not complete. | `MISSING` |
| `gap.registry.localization_ownership` | Localization ownership registry | Generated localizations and docs exist; ownership map missing. | `MISSING` |
| `gap.registry.compliance_runtime` | Compliance registry | Docs exist; runtime registry missing. | `MISSING` |
| `gap.registry.asset_complete` | Complete asset registry | `AppAssets` is partial. | `TRANSITIONAL` |
| `gap.registry.collection_ownership` | Firestore collection ownership registry | Collections/rules exist; full ownership/lifecycle map not complete. | `TRANSITIONAL` |

### 10.4 Missing Cards

| Gap ID | Card Area | Current Evidence | Classification |
|---|---|---|---|
| `gap.card.governance_cards_runtime` | Governance cards as runtime-managed objects | Governance docs exist; no runtime governance card system observed. | `MISSING` |
| `gap.card.compliance_cards_runtime` | Compliance cards | Compliance lifecycle docs exist; runtime compliance cards not observed. | `MISSING` |
| `gap.card.archive_cards_runtime` | Archive cards | Owner capsule cards exist static; archive card lifecycle not observed. | `TRANSITIONAL` |
| `gap.card.monitoring_alert_cards` | Monitoring alert cards | Monitoring room has control/section cards; alert card lifecycle not observed. | `TRANSITIONAL` |
| `gap.card.marketplace_governance_cards` | Marketplace governance cards | Commercial profile/contact cards exist; governance cards not observed. | `MISSING` |

### 10.5 Missing Workforce Definitions

| Gap ID | Workforce Definition | Current Evidence | Classification |
|---|---|---|---|
| `gap.workforce.legal_runtime` | Legal/Governance runtime role and authority | Docs/policies exist; no dedicated runtime role observed. | `MISSING` |
| `gap.workforce.compliance_runtime` | Compliance runtime role and limits | Compliance doctrine exists; no runtime role/queue observed. | `MISSING` |
| `gap.workforce.archive_runtime` | Archive runtime role and authority | Archive concept exists; no runtime role observed. | `MISSING` |
| `gap.workforce.monitoring_lifecycle` | Monitoring escalation/alert workforce lifecycle | Monitoring role exists; lifecycle incomplete. | `TRANSITIONAL` |
| `gap.workforce.technical_authority` | Explicit technical authority boundaries | Technical work exists through repo/tools; authority registry missing. | `TRANSITIONAL` |

### 10.6 Missing Governance Structures

| Gap ID | Governance Structure | Current Evidence | Classification |
|---|---|---|---|
| `gap.governance.route_ownership` | Route to owner mapping | Routes exist; ownership mostly inferred. | `MISSING` |
| `gap.governance.surface_authority` | Surface to authority mapping | Surfaces exist; authority map incomplete. | `TRANSITIONAL` |
| `gap.governance.signal_authority` | Signal ownership and consumer authority | Signal registry exists; ownership/consumer governance incomplete. | `TRANSITIONAL` |
| `gap.governance.card_lifecycle` | Card lifecycle governance | Card-like widgets exist; runtime card lifecycle missing. | `MISSING` |
| `gap.governance.asset_authority` | Asset ownership governance | Assets exist; full ownership unknown. | `MISSING` |
| `gap.governance.firestore_collection_authority` | Collection owner and retention governance | Collections/rules exist; full authority/retention map incomplete. | `TRANSITIONAL` |
| `gap.governance.localization_enforcement` | Runtime language policy enforcement | Policy docs exist; runtime enforcement and hardcoded string audit incomplete. | `TRANSITIONAL` |

## 11. Firestore and Firebase Constitutional Inventory

| Object ID | Name | Type | Owner | Consumers | Dependencies | Produces | Consumes | Surface | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `collection.clients` | `clients` | Firestore collection | Residential/Technical | Client dashboard, auth/profile flows | Firebase Auth, Firestore rules | Client records | Client registration/profile data | Residential | Present | `ACTIVE` |
| `collection.clinicians` | `clinicians` | Firestore collection | Commercial/Technical | Clinician rooms/profiles/discovery | Firebase Auth, Firestore rules | Clinician records | Clinician registration/profile data | Commercial | Present | `ACTIVE` |
| `collection.centers` | `centers` | Firestore collection | Commercial/Technical | Center rooms/profiles/discovery | Firebase Auth, Firestore rules | Center records | Center registration/profile data | Commercial | Present | `ACTIVE` |
| `collection.clinician_profile_change_requests` | `clinician_profile_change_requests` | Firestore collection | Commercial/Compliance | Clinician edit request flow | Firestore | Change request records | Profile edit submissions | Commercial/Compliance | Present | `ACTIVE` |
| `collection.center_profile_change_requests` | `center_profile_change_requests` | Firestore collection | Commercial/Compliance | Center edit request flow | Firestore | Change request records | Profile edit submissions | Commercial/Compliance | Present | `ACTIVE` |
| `collection.support_requests` | `support_requests` | Firestore collection | Support | Support room | Firestore | Support request records | Support submissions | Support | Present | `ACTIVE` |
| `collection.provider_contact_requests` | `provider_contact_requests` | Firestore collection | Commercial | Provider contact flow | Firestore, signal service | Contact request records | Contact form/action data | Commercial | Present | `ACTIVE` |
| `collection.center_contact_requests` | `center_contact_requests` | Firestore collection | Commercial | Center contact flow | Firestore, signal service | Contact request records | Contact form/action data | Commercial | Present | `ACTIVE` |
| `collection.saved_destinations` | `saved_destinations` | Firestore collection | Residential | Saved destinations repository/dashboard | Firestore, signal service | Saved destination records | Destination metadata | Residential | Present | `ACTIVE` |
| `collection.chat_threads` | `chat_threads` | Firestore collection | Support | Chat feature | Firestore | Chat thread records | Chat data | Support | Present | `ACTIVE` |
| `collection.chat_messages` | `chat_threads/{threadId}/messages` | Firestore subcollection | Support | Chat feature | Firestore | Chat messages | Message data | Support | Present | `ACTIVE` |
| `collection.chat_escalations` | `chat_escalations` | Firestore collection | Support/Admin | Escalation screens | Firestore | Escalation records | Chat/report data | Support/Admin | Present | `ACTIVE` |
| `collection.chat_escalation_reports` | `chat_escalations/{id}/reports` | Firestore subcollection | Support/Admin | Escalation report screen | Firestore | Escalation reports | Report data | Support/Admin | Present | `ACTIVE` |
| `collection.system_domains` | `system_domains` | Firestore collection | Technical/Admin | Registry/domain status surfaces | Firestore, seeder | Domain status records | Seed/domain data | Admin/Technical | Present | `ACTIVE` |
| `collection.signal_events` | `signal_events` | Firestore collection | Monitoring/Technical | Signal monitoring/storage | SignalStorageService | Raw signal events | Signal packages | Monitoring | Present | `ACTIVE` |
| `collection.signal_aggregates` | `signal_aggregates` | Firestore collection | Monitoring/Technical | Monitoring/dashboard summaries | Firestore rules | Aggregate read model | Aggregate writes from unknown source | Monitoring | Present but writer unclear | `TRANSITIONAL` |
| `collection.analytics_summaries` | `analytics_summaries` | Firestore collection | Monitoring/Technical | Monitoring summaries | Cloud Functions | Scheduled analytics summaries | Events/metrics | Monitoring | Present | `ACTIVE` |
| `collection.ai_policies` | `ai_policies` | Firestore collection | Legal/Technical | AI policy surfaces/services | Seeder/Firestore | AI policy records | Policy seed data | Legal/Technical | Present | `ACTIVE` |
| `firebase.auth` | Firebase Auth | Auth service | Technical | AppRouter, role gates, Firestore rules | Firebase | User identity/custom claims | Auth credentials/claims | Cross-surface | Present | `ACTIVE` |
| `firebase.analytics` | Firebase Analytics | Analytics service | Technical/Monitoring | Analytics summaries | Firebase | Analytics events | Runtime telemetry | Monitoring | Present | `ACTIVE` |
| `firebase.functions` | Cloud Functions | Backend functions | Technical/Monitoring | Scheduled summaries | Firebase | Summary docs | Firestore/analytics data | Monitoring | Present | `ACTIVE` |
| `firebase.bigquery` | BigQuery integration | Analytics export | Technical/Monitoring | Analytics/monitoring | Firebase | Exported analytics data | Analytics events | Monitoring | Referenced/configured | `TRANSITIONAL` |
| `firebase.storage_rules` | `storage.rules` | Firebase Storage rules | Technical | Firebase config | Firebase config | Storage policy | Storage assets | Technical | Referenced by config; file not observed in snapshot | `UNKNOWN` |

## 12. Asset and Localization Constitutional Inventory

### 12.1 Asset Areas

| Asset ID | Name | Type | Owner | Consumers | Dependencies | Produces | Consumes | Surface | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `asset.registry.app_assets` | `AppAssets` | Asset constants registry | Technical/Product | UI widgets | Asset files | Asset paths | Static assets | Cross-surface | Partial root/logo registry | `TRANSITIONAL` |
| `asset.logo_root` | Root logo assets | Image assets | Product | Public/core UI | Asset bundle | Brand visuals | Image files | Public/Core | Present | `ACTIVE` |
| `asset.web_registration` | Web registration assets | Asset folder | Commercial/Product | Web registration flows | Asset bundle | Registration visuals/docs | Asset files | Commercial | Present with path duplication risk | `TRANSITIONAL` |
| `asset.library` | Library assets | Asset folder | Library/Product | Library pages/cards | Asset bundle | Library visuals/content | Asset files | Library | Present with duplication risk | `TRANSITIONAL` |
| `asset.animations` | Animations folder | Asset folder | Unknown | Unknown | Asset bundle | Unknown | Unknown | Unknown | Empty/orphaned in snapshot | `ORPHANED` |
| `asset.icons` | Icons folder | Asset folder | Unknown | Unknown | Asset bundle | Unknown | Unknown | Unknown | Empty/orphaned in snapshot | `ORPHANED` |

### 12.2 Localization Areas

| Localization ID | Name | Type | Owner | Consumers | Dependencies | Produces | Consumes | Surface | Status | Classification |
|---|---|---|---|---|---|---|---|---|---|---|
| `localization.generated` | `AppLocalizations` | Generated localization runtime | Technical/Product | Flutter UI | ARB files, Flutter gen-l10n | Localized strings | ARB content | Cross-surface | Active | `ACTIVE` |
| `localization.language_page` | Language page | Runtime screen | Product/Technical | Users | App localization | Language selection | Locale choices | Localization | Active | `ACTIVE` |
| `localization.policy_docs` | Language policy documents | Governance docs | Legal/Governance | Governance/process | Docs | Policy constraints | Surface terms | Legal/Localization | Present | `ACTIVE` |
| `localization.term_matrix` | Surface term permission matrix | Governance docs | Legal/Governance | Governance/process | Docs | Term permissions | Surface language terms | Legal/Localization | Present | `ACTIVE` |
| `localization.validation_rules` | Surface language validation rules | Governance docs | Legal/Governance | Governance/process | Docs | Validation rules | Term policy | Legal/Localization | Present | `ACTIVE` |
| `localization.ownership_registry` | Localization ownership registry | Registry | Legal/Product | Localization governance | Not observed | Owner map | Strings/surfaces | Localization | Missing | `MISSING` |
| `localization.hardcoded_strings` | Hardcoded string inventory | Registry/audit object | Technical/Legal | Governance/process | Source scan | String drift inventory | Source strings | Cross-surface | Incomplete | `TRANSITIONAL` |
| `localization.mojibake_drift` | Mojibake/string encoding drift | Drift object | Technical/Legal | Localization audit | Source text | Drift evidence | Localized text | Localization | Observed in snapshot | `TRANSITIONAL` |

## 13. Legacy, Frozen, Transitional, Orphaned, and Unknown Systems

| Object ID | Name | Type | Current State | Classification |
|---|---|---|---|---|
| `legacy.admin_surface` | Legacy Admin Surface | Surface/system | Deleted/admin-era structure replaced or split by S rooms. | `LEGACY` |
| `legacy.navigation_federation_registries` | Navigation Federation Registries | Registry/system | Deleted legacy route/navigation registry structures recorded in snapshot. | `FROZEN` |
| `legacy.monitoring_storage` | Monitoring Storage | Storage/system | Deleted monitoring storage path noted; current signal aggregates read-only/writer unclear. | `FROZEN` |
| `legacy.tool_registry` | Legacy Tool Registry | Registry | Deleted/frozen, replaced by local UI specs and docs. | `FROZEN` |
| `legacy.owner_capsule_package` | Owner Capsule Package | Runtime package | Deleted package noted; owner static capsule cards remain. | `FROZEN` |
| `transitional.localization_federation` | Localization Federation Contracts | Contract/docs/runtime split | Docs and runtime localization both exist; ownership/enforcement incomplete. | `TRANSITIONAL` |
| `transitional.monitoring_dual_path` | Monitoring Dual Path | Monitoring system | Operational monitoring deleted, residential/commercial/generic monitoring remain. | `TRANSITIONAL` |
| `transitional.recommendation_signal_magnet` | Recommendation Signal Magnet | Signal system | Mentioned as transitional; full runtime ownership not observed. | `TRANSITIONAL` |
| `transitional.s_web_surfaces` | S Web Surface Placeholders | Surface system | City/capital placeholder routes are active but not fully implemented. | `TRANSITIONAL` |
| `transitional.trust_read_model` | Trust Read Model | Read model | Trust/safety/report placeholders exist; full model incomplete. | `TRANSITIONAL` |
| `transitional.web_portal_skeleton` | Web Portal Skeleton | Surface system | Public portal routes exist; some request/package/contact surfaces are basic. | `TRANSITIONAL` |
| `orphan.assistant_bounded_panel` | Assistant Bounded Panel | UI object | Orphaned in snapshot. | `ORPHANED` |
| `orphan.assets_animations` | Empty animation assets | Asset folder | Empty/orphaned. | `ORPHANED` |
| `orphan.assets_icons` | Empty icon assets | Asset folder | Empty/orphaned. | `ORPHANED` |
| `unknown.gpt_runtime` | GPT Runtime Integration | AI integration | GPT named as tool area; concrete runtime integration not fully established in snapshot. | `UNKNOWN` |
| `unknown.android_studio_state` | Android Studio Project State | IDE/tooling | External tool, not directly evidenced as runtime object. | `UNKNOWN` |

## 14. Dependency Graph Snapshot

### 14.1 High-Level Graph

| From | Relationship | To | Status | Classification |
|---|---|---|---|---|
| `Flutter app` | uses | `AppRouter` | Active | `ACTIVE` |
| `AppRouter` | consumes | `Routes` | Active | `ACTIVE` |
| `AppRouter` | consumes | `Firebase Auth/custom claims` | Active | `ACTIVE` |
| `Routes` | maps to | `Screens` | Active | `ACTIVE` |
| `Screens` | render | `Card-like widgets` | Active | `ACTIVE` |
| `Card-like widgets` | may emit/use | `Signals` | Partial | `TRANSITIONAL` |
| `Signal factories` | consume | `SignalTypeRegistry` | Active | `ACTIVE` |
| `SignalStorageService` | writes | `signal_events` | Active | `ACTIVE` |
| `Cloud Functions` | writes | `analytics_summaries` | Active | `ACTIVE` |
| `Monitoring rooms` | consume | `signal_events`, `signal_aggregates`, `analytics_summaries` | Partial | `TRANSITIONAL` |
| `Firestore rules` | enforce | `Custom claims and collection access` | Active | `ACTIVE` |
| `Localization runtime` | consumes | `ARB/generated localizations` | Active | `ACTIVE` |
| `Language policy docs` | constrain | `Surface terminology` | Documentation | `ACTIVE` |

### 14.2 Route to Screen to Card Relationship

| Route/Surface | Screen | Primary Cards/Units | Status |
|---|---|---|---|
| `/client/dashboard` | `ClientDashboardPage` | Theme catalog, tool cards, signal summary, saved summary, next steps, guidance, signal chips. | `ACTIVE` |
| `/s/personal-space` | `SPersonalSpacePage` | Personal overview, signal summary, signal health, personal district, placeholder district, surface card, signal board. | `ACTIVE` |
| `/s/capital` and focus routes | `SCapitalOperationsOfficePage` | Capital overview, capital cards, district cards. | `ACTIVE/TRANSITIONAL` |
| `/s/capital/signal-monitoring-room` | `SSignalMonitoringRoomPage` | Control cards, section cards. | `ACTIVE` |
| `/s/city` | `SCityDistrictPage` | City overview, city cards, district cards. | `ACTIVE` |
| `/s/city/*` placeholder routes | `SWebSurfacePage` | Surface navigation cards. | `TRANSITIONAL` |
| `/s/owner/*` | `SOwnerDistrictPage` | Owner overview, owner cards, district cards, capsule cards. | `ACTIVE/TRANSITIONAL` |
| `/s/registry-room` | `SRegistryRoomPage` | Registry domain cards. | `ACTIVE` |
| `/s/support-room` | `SSupportRoomPage` | Support request cards. | `ACTIVE` |
| `/s/declaration-review-room` | `SDeclarationReviewRoomPage` | Declaration record cards, summary cards. | `ACTIVE` |
| `/library` and `/module/library` | `LibraryPage` / module library | Featured heart cards, carousel cards, policy cards. | `ACTIVE` |
| `/module/specialists/*` | Specialist screens | Specialist category cards, info mini cards. | `ACTIVE` |
| `/module/centers/*` | Center screens | Center category, mini contact, grid info, gallery, section cards. | `ACTIVE` |
| `/register/client` | `ClientRegisterPage` | Client signal options and sections. | `ACTIVE` |
| `/register/provider` and web clinician routes | Web clinician registration screens | Provider signal options/forms. | `ACTIVE` |
| `/web/center/register/*` | Web center registration screens | Step cards/forms. | `ACTIVE` |

### 14.3 Signal to Consumer Relationship

| Signal | Producer | Consumer | Status |
|---|---|---|---|
| `goal_selected` | Client option flows | Residential monitoring, owner summary | `ACTIVE` |
| `interest_selected` | Client option flows | Residential monitoring | `ACTIVE` |
| `accessibility_interest` | Client option flows | Residential monitoring | `ACTIVE` |
| `communication_preference_selected` | Client option flows | Residential monitoring | `ACTIVE` |
| `destination_saved` | Saved destination repository/tool | Residential/commercial monitoring | `ACTIVE` |
| `provider_contact_started` | Specialist/provider detail contact action | Commercial monitoring | `ACTIVE` |
| `center_contact_started` | Center detail contact action | Commercial monitoring | `ACTIVE` |
| `support_started` | Support entry/action | Support monitoring | `ACTIVE` |
| `library_category_opened` | Library category open | Library/residential monitoring | `ACTIVE` |
| `provider_profile_opened` | Provider profile open | Commercial monitoring | `ACTIVE` |
| `center_profile_opened` | Center profile open | Commercial monitoring | `ACTIVE` |
| Declaration readiness signals | Declaration readiness surfaces | Declaration review/monitoring | `TRANSITIONAL` |
| Chat safety signals | Chat/escalation surfaces | Support/monitoring/legal | `TRANSITIONAL` |

## 15. Constitutional Snapshot Status

| Area | Snapshot Status | Classification |
|---|---|---|
| Strategic identity | Established with active product and transitional federation/governance direction. | `TRANSITIONAL` |
| Surface topology | Broadly discoverable; several surfaces active; governance/archive/legal runtime layers incomplete. | `TRANSITIONAL` |
| Route topology | Active and extensive; route metadata ownership registry missing. | `ACTIVE` |
| Role topology | Runtime roles exist for main app operations; legal/compliance/archive runtime roles missing. | `TRANSITIONAL` |
| Signal topology | Runtime foundation active; domain completeness and persistence incomplete. | `TRANSITIONAL` |
| Card topology | Many card-like widgets exist; runtime card registry missing. | `TRANSITIONAL` |
| Tool topology | Platform tools active; runtime tool registry missing; some external tools unknown. | `TRANSITIONAL` |
| Registry readiness | Route and signal foundations exist; ownership/card/tool/compliance registries incomplete or missing. | `TRANSITIONAL` |
| Workforce readiness | Owner/technical/support roles active; legal/compliance/archive mostly documentary. | `TRANSITIONAL` |
| Constitutional generation readiness | Current state can be audited; runtime governance bindings are incomplete. | `TRANSITIONAL` |

