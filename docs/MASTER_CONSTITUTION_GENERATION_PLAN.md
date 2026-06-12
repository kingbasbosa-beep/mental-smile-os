# Mental Smile Master Constitution Generation Plan

Plan ID: `constitution.generation.plan.v1`
Input: `docs/MASTER_CONSTITUTIONAL_SNAPSHOT_REPORT.md`
Output Type: `CONSTRUCTION_ROADMAP_ONLY`
Constitution Written: `NO`
Runtime Code Changes: `NO`
Firebase Changes: `NO`
ARB Changes: `NO`
Route Changes: `NO`

## 0. Plan Boundary

This document is a build plan for future constitutional generation. It does not write the constitution, create runtime registries, create cards, implement auditors, or redesign app logic. It defines the construction order, dependencies, required inputs, and generated outputs needed to produce a complete Mental Smile constitutional system later.

The plan is based on the current constitutional snapshot, which classifies the project as:

| Area | Current Constitutional State |
|---|---|
| Strategic identity | Present and transitional. |
| Surface topology | Present, with active residential/commercial/technical/support routes and transitional owner/monitoring/legal/archive structures. |
| Route topology | Active, with missing route ownership metadata. |
| Role topology | Active for runtime app roles, missing or transitional for legal, compliance, archive, and complete authority boundaries. |
| Signal topology | Active runtime foundation, incomplete domain ownership and aggregation. |
| Card topology | Many card-like widgets exist, no runtime card registry. |
| Tool topology | Platform tools active, runtime tool registry missing. |
| Registry readiness | Route and signal foundations exist, ownership/card/tool/compliance registries incomplete or missing. |
| Workforce readiness | Owner, technical, support active; legal, compliance, archive transitional. |

## 1. Construction Order

| Order | Phase | Name | Primary Purpose | Must Precede | Reason |
|---|---|---|---|---|---|
| 0 | `PHASE_0` | Master Constitution Structure | Establish the supreme constitutional frame, doctrine hierarchy, domains, authority model, and generation rules. | All other phases | Every department, registry, card, auditor, and archive object must inherit from the master structure. |
| 1 | `PHASE_1` | Department Constitution Structure | Define constitutional domains for residential, commercial, administrative, owner, monitoring, legal governance, archive, and technical areas. | Workforce, cards, registries, auditors, archive | Workforce and artifacts need department ownership before lifecycle rules can be assigned. |
| 2 | `PHASE_2` | Workforce Structure | Define authorities, responsibilities, permissions, escalation paths, and workforce boundaries. | Cards, registries, auditors, archive | Cards and registries need owners, consumers, approvers, observers, and executors. |
| 3 | `PHASE_3` | Card Constitution Structure | Define card classes, card lifecycle, card ownership, card-to-signal relationships, and card approval rules. | Registries, auditors, archive | Registries must know what card records contain; auditors must know what card states mean. |
| 4 | `PHASE_4` | Registry Structure | Define source-of-truth registries for routes, cards, signals, tools, assets, localization, collections, ownership, and compliance. | Auditors, archive | Auditors compare actual state against registry state; archive preserves registry versions. |
| 5 | `PHASE_5` | Auditor Structure | Define observer/auditor duties, mismatch detection, escalation, and non-execution limits. | Archive | Audits produce records that must be archived and versioned. |
| 6 | `PHASE_6` | Archive Structure | Define preservation, version history, supersession, freeze, legacy, and recovery rules. | Final constitutional release | Archive completes the governance cycle and preserves old constitutional states. |

## 2. Global Construction Dependencies

| Dependency ID | Dependency | Required By | Current Status From Snapshot |
|---|---|---|---|
| `dep.snapshot` | Master Constitutional Snapshot Report | All phases | Present. |
| `dep.project_reality` | Project Reality Snapshot | All phases | Present. |
| `dep.surface_inventory` | Current surface inventory | Phases 0, 1, 2, 3, 4 | Present, transitional. |
| `dep.route_inventory` | Current route inventory | Phases 1, 3, 4, 5 | Present, active. |
| `dep.role_inventory` | Current role inventory | Phases 1, 2, 3, 4, 5 | Present, incomplete for legal/compliance/archive. |
| `dep.signal_inventory` | Current signal inventory | Phases 3, 4, 5 | Present, transitional. |
| `dep.card_inventory` | Current card-like widget inventory | Phases 3, 4, 5 | Present, no runtime registry. |
| `dep.tool_inventory` | Current platform/product tool inventory | Phases 1, 4, 5 | Present, transitional. |
| `dep.collection_inventory` | Firestore/Firebase collection inventory | Phases 1, 4, 5, 6 | Present, ownership incomplete. |
| `dep.language_policy` | Residential, Commercial, Administrative language policies and validation matrix | Phases 0, 1, 3, 4, 5 | Present as docs. |
| `dep.existing_guides` | Existing guide docs and guide reports | Phases 0, 3, 4, 5, 6 | Present as docs, not complete runtime binding. |

## 3. PHASE 0 - Master Constitution Structure

### 3.1 Purpose

Define the supreme constitutional architecture for Mental Smile. This phase establishes the hierarchy that all future department constitutions, workforce definitions, cards, registries, auditors, archives, guides, and signals must obey.

### 3.2 Dependencies

| Dependency | Source | Status |
|---|---|---|
| Current strategic identity | Constitutional Snapshot Report sections 1 and 15 | Available |
| Existing doctrines | Snapshot strategic, marketplace, federation doctrines | Available |
| Current surfaces | Snapshot surface topology | Available |
| Current governance gaps | Snapshot gap analysis | Available |
| Existing policy docs | Language and surface policy documents | Available |

### 3.3 Required Inputs

| Input ID | Input Name | Purpose |
|---|---|---|
| `input.phase0.snapshot` | Master Constitutional Snapshot Report | Establish current-state baseline. |
| `input.phase0.reality_snapshot` | Project Reality Snapshot | Provide exhaustive route/surface/card/signal evidence. |
| `input.phase0.language_policies` | Language policy files | Preserve existing term and surface language constraints. |
| `input.phase0.existing_guides` | Existing guide documents | Identify existing governance doctrine without rewriting it. |
| `input.phase0.firestore_inventory` | Firestore/Firebase inventory | Identify system-level data surfaces. |

### 3.4 Generated Outputs

| Output ID | Output Name | Output Type | Description |
|---|---|---|---|
| `output.phase0.master_constitution_outline` | Master Constitution Outline | Constitution scaffold | Defines top-level sections, authority hierarchy, doctrine order, and constitutional domains. |
| `output.phase0.constitution_scope_matrix` | Constitution Scope Matrix | Governance matrix | Defines which objects are governed: surfaces, routes, roles, cards, signals, tools, assets, collections, language, registries, auditors, archives. |
| `output.phase0.doctrine_hierarchy` | Doctrine Hierarchy | Doctrine map | Orders strategic, marketplace, federation, safety, owner, monitoring, and archive doctrines. |
| `output.phase0.authority_principles` | Authority Principles | Governance rules | Defines Legal & Governance interpretation, Owner authorization, Technical execution, Monitoring verification, Archive preservation. |
| `output.phase0.generation_rules` | Constitution Generation Rules | Process rules | Defines how later constitutional artifacts are generated, versioned, reviewed, and superseded. |

### 3.5 Required Cards

| Card ID | Card Name | Purpose | Source State |
|---|---|---|---|
| `card.master.identity` | Master Identity Card | Captures what Mental Smile is and is becoming. | Future constitutional card. |
| `card.master.doctrine` | Master Doctrine Card | Captures non-negotiable doctrines and hierarchy. | Future constitutional card. |
| `card.master.authority` | Master Authority Card | Captures top-level authority model. | Future constitutional card. |
| `card.master.scope` | Master Scope Card | Captures governed object classes. | Future constitutional card. |

### 3.6 Required Guides

| Guide ID | Guide Name | Purpose |
|---|---|---|
| `guide.master.constitution` | Master Constitution Guide | Explains the master constitutional structure and object hierarchy. |
| `guide.master.doctrine` | Master Doctrine Guide | Explains doctrine priority and conflict interpretation. |
| `guide.master.generation` | Constitution Generation Guide | Explains how constitution artifacts are generated from snapshots. |
| `guide.master.authority` | Master Authority Guide | Explains owner, legal, technical, monitoring, compliance, and archive authority. |

### 3.7 Required Registries

| Registry ID | Registry Name | Purpose |
|---|---|---|
| `registry.constitution.domain` | Constitutional Domain Registry | Registers all constitutional domains. |
| `registry.constitution.doctrine` | Doctrine Registry | Registers doctrines, sources, precedence, and owners. |
| `registry.constitution.object_class` | Governed Object Class Registry | Registers object classes: surface, route, role, card, signal, tool, asset, collection, localization, guide, auditor, archive. |
| `registry.constitution.version` | Constitution Version Registry | Registers constitution versions and snapshot source. |

### 3.8 Required Signals

| Signal ID | Signal Name | Purpose |
|---|---|---|
| `signal.constitution.snapshot_ingested` | Snapshot Ingested | Marks a snapshot as source material for constitutional generation. |
| `signal.constitution.phase_started` | Constitution Phase Started | Records start of a constitutional build phase. |
| `signal.constitution.phase_completed` | Constitution Phase Completed | Records completion of a build phase. |
| `signal.constitution.scope_changed` | Constitution Scope Changed | Records any change in governed object scope. |

### 3.9 Required Workforce Definitions

| Workforce ID | Workforce Name | Definition Needed |
|---|---|---|
| `workforce.owner` | Owner | Supreme authorization and constitutional acceptance authority. |
| `workforce.legal_governance` | Legal & Governance | Doctrine interpretation and policy conflict authority. |
| `workforce.technical` | Technical | Execution authority and runtime feasibility boundary. |
| `workforce.monitoring` | Monitoring | Verification and observation authority. |
| `workforce.compliance` | Compliance | Mismatch detection and escalation authority. |
| `workforce.archive` | Archive | Preservation and supersession authority. |

### 3.10 Phase 0 Construction Order

| Step | Construction Action | Depends On | Produces |
|---|---|---|---|
| 0.1 | Freeze snapshot input references. | Snapshot report | Source input list. |
| 0.2 | Define master constitutional scope. | Source input list | Scope matrix. |
| 0.3 | Define doctrine hierarchy. | Strategic and policy docs | Doctrine hierarchy. |
| 0.4 | Define authority principles. | Role/workforce snapshot | Authority principles. |
| 0.5 | Define object class taxonomy. | Surface/route/card/signal/tool inventories | Object class registry requirements. |
| 0.6 | Define generation and versioning rules. | Existing guide/archive docs | Generation rules. |
| 0.7 | Issue Phase 0 output package. | Steps 0.1-0.6 | Master constitution structure package. |

## 4. PHASE 1 - Department Constitution Structure

### 4.1 Purpose

Define each constitutional department as a governed domain with purpose, authority, surfaces, routes, roles, cards, tools, registries, signals, collections, assets, language rules, and lifecycle boundaries.

### 4.2 Dependencies

| Dependency | Source | Status |
|---|---|---|
| Master Constitution Structure | Phase 0 | Required before Phase 1 |
| Surface topology | Snapshot section 2 | Available |
| Route topology | Snapshot section 3 | Available |
| Collection inventory | Snapshot section 11 | Available |
| Asset/localization inventory | Snapshot section 12 | Available |

### 4.3 Required Inputs

| Input ID | Input Name | Purpose |
|---|---|---|
| `input.phase1.master_structure` | Master Constitution Structure | Defines department inheritance. |
| `input.phase1.surface_inventory` | Surface topology | Defines department surface membership. |
| `input.phase1.route_inventory` | Route topology | Defines route-to-department mapping. |
| `input.phase1.collection_inventory` | Firestore/Firebase inventory | Defines data objects per department. |
| `input.phase1.localization_policies` | Language policies and matrix | Defines surface language boundaries. |

### 4.4 Generated Outputs

| Output ID | Output Name | Output Type | Description |
|---|---|---|---|
| `output.phase1.department_map` | Department Constitution Map | Domain map | Defines all constitutional departments and their boundaries. |
| `output.phase1.surface_department_matrix` | Surface to Department Matrix | Governance matrix | Maps every current surface to a department. |
| `output.phase1.route_department_matrix` | Route to Department Matrix | Governance matrix | Maps every current route to a department and authority surface. |
| `output.phase1.collection_department_matrix` | Collection to Department Matrix | Data governance matrix | Maps Firestore collections to departments. |
| `output.phase1.department_gap_ledger` | Department Gap Ledger | Gap ledger | Records missing department structures without implementing them. |

### 4.5 Department Set

| Department ID | Department Name | Based On Snapshot Surface(s) | Current State |
|---|---|---|---|
| `department.residential` | Residential Department | Residential, personal space, client dashboard, library/support intersections | Active |
| `department.commercial` | Commercial Department | Clinician, center, provider discovery, center discovery, marketplace placeholder | Active/transitional |
| `department.administrative` | Administrative Department | Registry room, declaration review room, support admin, chat escalations | Transitional |
| `department.owner` | Owner Department | Owner district and owner route family | Transitional |
| `department.monitoring` | Monitoring Department | Capital, signal monitoring, analytics summaries, signal events | Transitional |
| `department.legal_governance` | Legal & Governance Department | Policy docs, language matrix, declaration review, compliance docs | Transitional |
| `department.archive` | Archive Department | Git/docs, owner strategic memory/vault/capsules naming | Transitional |
| `department.technical` | Technical Department | Flutter, Firebase, Firestore rules, Cloud Functions, Git, route architecture | Active |
| `department.public_portal` | Public Portal Department | Public portal, contact, public library, registration entry | Active |
| `department.localization` | Localization Department | Generated localization, language page, policy docs | Transitional |

### 4.6 Required Cards

| Card ID | Card Name | Department |
|---|---|---|
| `card.department.residential` | Residential Department Card | Residential |
| `card.department.commercial` | Commercial Department Card | Commercial |
| `card.department.administrative` | Administrative Department Card | Administrative |
| `card.department.owner` | Owner Department Card | Owner |
| `card.department.monitoring` | Monitoring Department Card | Monitoring |
| `card.department.legal_governance` | Legal Governance Department Card | Legal & Governance |
| `card.department.archive` | Archive Department Card | Archive |
| `card.department.technical` | Technical Department Card | Technical |
| `card.department.public_portal` | Public Portal Department Card | Public Portal |
| `card.department.localization` | Localization Department Card | Localization |

### 4.7 Required Guides

| Guide ID | Guide Name | Purpose |
|---|---|---|
| `guide.department.structure` | Department Constitution Structure Guide | Defines how departments are created and bounded. |
| `guide.department.surface_mapping` | Department Surface Mapping Guide | Defines surface-to-department mapping. |
| `guide.department.route_mapping` | Department Route Mapping Guide | Defines route-to-department mapping. |
| `guide.department.collection_mapping` | Department Collection Mapping Guide | Defines data ownership by department. |
| `guide.department.language_mapping` | Department Language Mapping Guide | Defines language authority per department. |

### 4.8 Required Registries

| Registry ID | Registry Name | Purpose |
|---|---|---|
| `registry.department` | Department Registry | Registers department ID, purpose, owner, surfaces, routes, collections, cards, signals, tools. |
| `registry.surface_department` | Surface Department Registry | Maps surfaces to departments. |
| `registry.route_department` | Route Department Registry | Maps routes to departments. |
| `registry.collection_department` | Collection Department Registry | Maps collections to departments. |
| `registry.department_language` | Department Language Registry | Maps language rules to departments. |

### 4.9 Required Signals

| Signal ID | Signal Name | Purpose |
|---|---|---|
| `signal.department.created` | Department Created | Records creation of a department constitution. |
| `signal.department.surface_bound` | Surface Bound to Department | Records surface assignment. |
| `signal.department.route_bound` | Route Bound to Department | Records route assignment. |
| `signal.department.collection_bound` | Collection Bound to Department | Records collection assignment. |
| `signal.department.gap_recorded` | Department Gap Recorded | Records missing department components. |

### 4.10 Required Workforce Definitions

| Workforce Definition ID | Name | Purpose |
|---|---|---|
| `workforce.department.owner` | Department Owner | Defines authority for each department. |
| `workforce.department.steward` | Department Steward | Defines operational maintenance role. |
| `workforce.department.observer` | Department Observer | Defines monitoring/audit observer role. |
| `workforce.department.legal_interpreter` | Department Legal Interpreter | Defines language/policy review authority. |
| `workforce.department.technical_executor` | Department Technical Executor | Defines implementation boundary by department. |

### 4.11 Phase 1 Construction Order

| Step | Construction Action | Depends On | Produces |
|---|---|---|---|
| 1.1 | Import master scope and doctrine hierarchy. | Phase 0 | Department inheritance base. |
| 1.2 | Define department list and IDs. | Surface inventory | Department registry draft. |
| 1.3 | Map surfaces to departments. | Surface topology | Surface department matrix. |
| 1.4 | Map routes to departments. | Route topology | Route department matrix. |
| 1.5 | Map collections and assets to departments. | Firestore/asset inventory | Collection and asset department matrices. |
| 1.6 | Map language rules to departments. | Language policy docs | Department language matrix. |
| 1.7 | Record department gaps. | Snapshot gap analysis | Department gap ledger. |
| 1.8 | Issue Phase 1 output package. | Steps 1.1-1.7 | Department constitution structure package. |

## 5. PHASE 2 - Workforce Structure

### 5.1 Purpose

Define all constitutional workforce roles, authority scopes, responsibilities, permissions, dependencies, escalation boundaries, and non-authority limits.

### 5.2 Dependencies

| Dependency | Source | Status |
|---|---|---|
| Master Constitution Structure | Phase 0 | Required |
| Department Constitution Structure | Phase 1 | Required |
| Role topology | Snapshot section 4 | Available |
| Workforce readiness | Snapshot section 9 | Available |
| Missing workforce definitions | Snapshot section 10.5 | Available |

### 5.3 Required Inputs

| Input ID | Input Name | Purpose |
|---|---|---|
| `input.phase2.department_map` | Department Constitution Map | Assign workforce to departments. |
| `input.phase2.role_inventory` | Current role inventory | Preserve implemented runtime roles. |
| `input.phase2.workforce_readiness` | Workforce readiness table | Identify active/transitional/missing workforce areas. |
| `input.phase2.firestore_rules` | Firestore rules/custom claims model | Align runtime authority evidence. |
| `input.phase2.route_gates` | Route gates and role checks | Align workforce with actual access surfaces. |

### 5.4 Generated Outputs

| Output ID | Output Name | Output Type | Description |
|---|---|---|---|
| `output.phase2.workforce_constitution_map` | Workforce Constitution Map | Authority map | Defines each workforce role and its department scope. |
| `output.phase2.authority_scope_matrix` | Authority Scope Matrix | Permission matrix | Defines who interprets, authorizes, executes, observes, audits, archives. |
| `output.phase2.escalation_matrix` | Escalation Matrix | Process matrix | Defines escalation paths between compliance, legal, owner, technical, monitoring, archive. |
| `output.phase2.non_authority_matrix` | Non-Authority Matrix | Constraint matrix | Defines what each workforce role may not do. |
| `output.phase2.runtime_role_alignment` | Runtime Role Alignment | Alignment report | Maps current runtime roles to constitutional workforce roles. |

### 5.5 Required Cards

| Card ID | Card Name | Purpose |
|---|---|---|
| `card.workforce.owner` | Owner Workforce Card | Captures owner authority and limits. |
| `card.workforce.legal_governance` | Legal Governance Workforce Card | Captures interpretation authority and limits. |
| `card.workforce.technical` | Technical Workforce Card | Captures execution authority and limits. |
| `card.workforce.monitoring` | Monitoring Workforce Card | Captures observation and verification authority. |
| `card.workforce.compliance` | Compliance Workforce Card | Captures mismatch detection and escalation authority. |
| `card.workforce.archive` | Archive Workforce Card | Captures preservation and supersession authority. |
| `card.workforce.support` | Support Workforce Card | Captures support observation and escalation scope. |
| `card.workforce.registry` | Registry Steward Workforce Card | Captures registry stewardship scope. |
| `card.workforce.declaration_review` | Declaration Review Workforce Card | Captures declaration review authority. |

### 5.6 Required Guides

| Guide ID | Guide Name | Purpose |
|---|---|---|
| `guide.workforce.authority` | Workforce Authority Guide | Defines workforce authorities and hierarchy. |
| `guide.workforce.permissions` | Workforce Permission Guide | Defines permitted actions and denied actions. |
| `guide.workforce.escalation` | Workforce Escalation Guide | Defines escalation between departments and roles. |
| `guide.workforce.runtime_alignment` | Runtime Role Alignment Guide | Defines how constitutional workforce maps to current app roles. |

### 5.7 Required Registries

| Registry ID | Registry Name | Purpose |
|---|---|---|
| `registry.workforce` | Workforce Registry | Registers workforce roles, owners, departments, scopes, status. |
| `registry.authority` | Authority Registry | Registers interpretation, authorization, execution, observation, audit, archive powers. |
| `registry.permission` | Permission Registry | Registers allowed and denied operations. |
| `registry.escalation` | Escalation Registry | Registers escalation path and response deadlines. |
| `registry.runtime_role_alignment` | Runtime Role Alignment Registry | Maps Firebase/custom claim roles to workforce roles. |

### 5.8 Required Signals

| Signal ID | Signal Name | Purpose |
|---|---|---|
| `signal.workforce.role_defined` | Workforce Role Defined | Records creation of a workforce role. |
| `signal.workforce.authority_assigned` | Authority Assigned | Records authority assignment. |
| `signal.workforce.permission_changed` | Permission Changed | Records change in permissions. |
| `signal.workforce.escalation_opened` | Escalation Opened | Records workforce escalation. |
| `signal.workforce.escalation_closed` | Escalation Closed | Records escalation closure. |

### 5.9 Required Workforce Definitions

| Workforce ID | Name | Current Snapshot State | Constitution Definition Needed |
|---|---|---|---|
| `workforce.owner` | Owner | Active | Supreme authorization, override boundaries, acceptance criteria. |
| `workforce.legal_governance` | Legal & Governance | Transitional | Interpretation authority, policy conflict process, language authority. |
| `workforce.technical` | Technical | Active | Execution authority, implementation limits, release obligations. |
| `workforce.monitoring` | Monitoring | Transitional | Observation, verification, alert scope, non-execution limits. |
| `workforce.compliance` | Compliance | Transitional | Detection, mismatch reporting, escalation, non-approval limits. |
| `workforce.archive` | Archive | Transitional | Preservation, version control, supersession, recovery. |
| `workforce.support` | Support | Active | Support observation and escalation boundaries. |
| `workforce.registry_steward` | Registry Steward | Transitional | Registry maintenance and evidence boundaries. |
| `workforce.declaration_reviewer` | Declaration Reviewer | Transitional | Declaration review authority and evidence boundaries. |

### 5.10 Phase 2 Construction Order

| Step | Construction Action | Depends On | Produces |
|---|---|---|---|
| 2.1 | Import department map and route/role alignment. | Phase 1 | Workforce domain base. |
| 2.2 | Define workforce role taxonomy. | Role topology | Workforce registry draft. |
| 2.3 | Define authority verbs. | Phase 0 authority principles | Authority matrix. |
| 2.4 | Assign authorities to workforce roles. | Department map | Authority scope matrix. |
| 2.5 | Define non-authority boundaries. | Snapshot role gaps | Non-authority matrix. |
| 2.6 | Define escalation paths. | Compliance/legal/owner/monitoring gaps | Escalation matrix. |
| 2.7 | Align runtime roles with constitutional roles. | Firebase roles/route gates | Runtime role alignment. |
| 2.8 | Issue Phase 2 output package. | Steps 2.1-2.7 | Workforce structure package. |

## 6. PHASE 3 - Card Constitution Structure

### 6.1 Purpose

Define card classes, card ownership, card lifecycle, card-to-surface relationships, card-to-signal relationships, card-to-registry requirements, and card approval/suspension states.

### 6.2 Dependencies

| Dependency | Source | Status |
|---|---|---|
| Master Constitution Structure | Phase 0 | Required |
| Department Structure | Phase 1 | Required |
| Workforce Structure | Phase 2 | Required |
| Card topology | Snapshot section 6 | Available |
| Route-to-screen-to-card graph | Snapshot section 14.2 | Available |

### 6.3 Required Inputs

| Input ID | Input Name | Purpose |
|---|---|---|
| `input.phase3.card_inventory` | Current card-like unit inventory | Establish observed cards and card candidates. |
| `input.phase3.screen_card_graph` | Route to screen to card relationship | Bind cards to surfaces/routes. |
| `input.phase3.workforce_authority` | Workforce authority matrix | Assign card owners, approvers, observers. |
| `input.phase3.signal_inventory` | Signal topology | Bind cards to produced/consumed signals. |
| `input.phase3.language_policy` | Language policies | Bind card copy to surface language rules. |

### 6.4 Generated Outputs

| Output ID | Output Name | Output Type | Description |
|---|---|---|---|
| `output.phase3.card_class_model` | Card Class Model | Card taxonomy | Defines operational, governance, signal, monitoring, owner, archive, registry, support, commercial, residential card classes. |
| `output.phase3.card_lifecycle_model` | Card Lifecycle Model | Lifecycle model | Defines draft, sync, suspended, deployed, validation, approved, blocked, archived states. |
| `output.phase3.card_ownership_matrix` | Card Ownership Matrix | Ownership matrix | Maps cards to departments and workforce owners. |
| `output.phase3.card_signal_matrix` | Card to Signal Matrix | Relationship matrix | Maps card producers/consumers to signals. |
| `output.phase3.card_route_surface_matrix` | Card Route Surface Matrix | Relationship matrix | Maps cards to screens, routes, and surfaces. |
| `output.phase3.card_gap_ledger` | Card Gap Ledger | Gap ledger | Records missing governance, compliance, archive, monitoring, and marketplace cards. |

### 6.5 Required Cards

| Card Group ID | Required Card Group | Source Basis |
|---|---|---|
| `cards.residential` | Residential cards | Client dashboard, personal space, saved destinations, library, support entry. |
| `cards.commercial` | Commercial cards | Provider/center registration, profiles, contact, specialists, centers. |
| `cards.monitoring` | Monitoring cards | Signal monitoring room, capital office, analytics summaries. |
| `cards.owner` | Owner cards | Owner district, capsules, owner memory route family. |
| `cards.administrative` | Administrative cards | Registry room, declaration review room, support room, chat escalations. |
| `cards.legal_governance` | Legal governance cards | Policy docs, language matrix, declaration review, compliance docs. |
| `cards.technical` | Technical cards | Routes, Firebase, functions, tools, registries, assets, collections. |
| `cards.archive` | Archive cards | Snapshot versions, superseded cards, frozen/legacy systems. |
| `cards.public_portal` | Public portal cards | Home, about, contact, public library, service/package request, provider registration. |
| `cards.localization` | Localization cards | Language page, ARB/generated strings, term matrix, hardcoded string drift. |

### 6.6 Required Guides

| Guide ID | Guide Name | Purpose |
|---|---|---|
| `guide.card.classification` | Card Classification Guide | Defines card types and boundaries. |
| `guide.card.lifecycle` | Card Lifecycle Guide | Defines card states and transitions. |
| `guide.card.ownership` | Card Ownership Guide | Defines ownership and authority over card content. |
| `guide.card.signal_binding` | Card Signal Binding Guide | Defines how cards produce/consume signals. |
| `guide.card.language` | Card Language Guide | Defines card copy and localization requirements. |

### 6.7 Required Registries

| Registry ID | Registry Name | Purpose |
|---|---|---|
| `registry.card` | Card Registry | Registers all cards, owners, surfaces, status, version, dependencies. |
| `registry.card_lifecycle` | Card Lifecycle Registry | Registers allowed states and transitions. |
| `registry.card_signal` | Card Signal Registry | Registers card-to-signal relationships. |
| `registry.card_route_surface` | Card Route Surface Registry | Registers card-to-screen-route-surface relationships. |
| `registry.card_language` | Card Language Registry | Registers card copy ownership and language constraints. |

### 6.8 Required Signals

| Signal ID | Signal Name | Purpose |
|---|---|---|
| `signal.card.created` | Card Created | Records new card definition. |
| `signal.card.updated` | Card Updated | Records card definition update. |
| `signal.card.sync_pending` | Card Sync Pending | Records card/system mismatch. |
| `signal.card.suspended` | Card Suspended | Records card suspension. |
| `signal.card.deployed` | Card Deployed | Records deployment of a new card version. |
| `signal.card.validation_pending` | Card Validation Pending | Records validation state. |
| `signal.card.approved` | Card Approved | Records approval. |
| `signal.card.approval_blocked` | Card Approval Blocked | Records approval block. |
| `signal.card.archived` | Card Archived | Records archival. |

### 6.9 Required Workforce Definitions

| Workforce Role | Card Responsibility |
|---|---|
| Owner | Authorizes constitutional card acceptance. |
| Legal & Governance | Interprets card language, policy, authority. |
| Technical | Executes card-system binding where runtime implementation is required. |
| Monitoring | Verifies active card state and signal behavior. |
| Compliance | Detects outdated, missing, mismatched, or ownerless cards. |
| Archive | Preserves previous card versions and card lifecycle history. |
| Department Owner | Owns department-specific cards. |

### 6.10 Phase 3 Construction Order

| Step | Construction Action | Depends On | Produces |
|---|---|---|---|
| 3.1 | Import card inventory and screen-card graph. | Snapshot card topology | Card source ledger. |
| 3.2 | Define card class taxonomy. | Phase 0 and Phase 1 | Card class model. |
| 3.3 | Define card lifecycle states. | Phase 0 authority and existing guide doctrine | Card lifecycle model. |
| 3.4 | Map observed cards to departments and owners. | Phase 1 and Phase 2 | Card ownership matrix. |
| 3.5 | Map cards to routes, screens, and surfaces. | Route/screen/card graph | Card route surface matrix. |
| 3.6 | Map cards to produced/consumed signals. | Signal topology | Card signal matrix. |
| 3.7 | Record missing card groups. | Snapshot card gaps | Card gap ledger. |
| 3.8 | Issue Phase 3 output package. | Steps 3.1-3.7 | Card constitution structure package. |

## 7. PHASE 4 - Registry Structure

### 7.1 Purpose

Define the source-of-truth registry system required to govern all constitutional objects, including routes, surfaces, roles, cards, signals, tools, assets, localization, Firestore collections, ownership, compliance, workforce, departments, and archive records.

### 7.2 Dependencies

| Dependency | Source | Status |
|---|---|---|
| Master Constitution Structure | Phase 0 | Required |
| Department Structure | Phase 1 | Required |
| Workforce Structure | Phase 2 | Required |
| Card Constitution Structure | Phase 3 | Required |
| Registry readiness inventory | Snapshot section 8 | Available |
| Firestore/Firebase inventory | Snapshot section 11 | Available |
| Asset/localization inventory | Snapshot section 12 | Available |

### 7.3 Required Inputs

| Input ID | Input Name | Purpose |
|---|---|---|
| `input.phase4.registry_readiness` | Current registry readiness | Establish active, transitional, missing registries. |
| `input.phase4.route_registry_object` | Runtime `Routes` and `AppRouter` evidence | Ground route registry structure. |
| `input.phase4.signal_registry_object` | Runtime `SignalTypeRegistry` evidence | Ground signal registry structure. |
| `input.phase4.card_model` | Card constitution structure | Define card registry fields. |
| `input.phase4.workforce_authority` | Workforce authority matrix | Define ownership and permissions for registries. |

### 7.4 Generated Outputs

| Output ID | Output Name | Output Type | Description |
|---|---|---|---|
| `output.phase4.registry_architecture` | Registry Architecture | Registry map | Defines every registry and its relationships. |
| `output.phase4.registry_schema_catalog` | Registry Schema Catalog | Schema catalog | Defines required fields for each registry type. |
| `output.phase4.registry_ownership_matrix` | Registry Ownership Matrix | Ownership matrix | Maps registries to workforce owners and departments. |
| `output.phase4.registry_dependency_graph` | Registry Dependency Graph | Dependency graph | Defines registry dependencies and build order. |
| `output.phase4.registry_gap_ledger` | Registry Gap Ledger | Gap ledger | Records missing/transitional registries. |

### 7.5 Required Cards

| Card ID | Card Name | Registry Area |
|---|---|---|
| `card.registry.route` | Route Registry Card | Routes |
| `card.registry.surface` | Surface Registry Card | Surfaces |
| `card.registry.role` | Role Registry Card | Roles |
| `card.registry.card` | Card Registry Card | Cards |
| `card.registry.signal` | Signal Registry Card | Signals |
| `card.registry.tool` | Tool Registry Card | Tools |
| `card.registry.asset` | Asset Registry Card | Assets |
| `card.registry.localization` | Localization Registry Card | Localization |
| `card.registry.collection` | Collection Registry Card | Firestore/Firebase |
| `card.registry.ownership` | Ownership Registry Card | Ownership |
| `card.registry.compliance` | Compliance Registry Card | Compliance |
| `card.registry.archive` | Archive Registry Card | Archive |

### 7.6 Required Guides

| Guide ID | Guide Name | Purpose |
|---|---|---|
| `guide.registry.architecture` | Registry Architecture Guide | Defines registry hierarchy and relationships. |
| `guide.registry.schema` | Registry Schema Guide | Defines fields and required metadata. |
| `guide.registry.ownership` | Registry Ownership Guide | Defines registry owner and steward rules. |
| `guide.registry.status` | Registry Status Guide | Defines active, transitional, legacy, frozen, orphaned, unknown, missing status handling. |
| `guide.registry.validation` | Registry Validation Guide | Defines validation and drift checks. |

### 7.7 Required Registries

| Registry ID | Registry Name | Purpose |
|---|---|---|
| `registry.route` | Route Registry | Source of truth for route path, screen, surface, owner, status. |
| `registry.surface` | Surface Registry | Source of truth for surfaces and surface authority. |
| `registry.role` | Role Registry | Source of truth for roles and permissions. |
| `registry.card` | Card Registry | Source of truth for cards and lifecycle states. |
| `registry.signal` | Signal Registry | Source of truth for signal type, producer, consumer, routing, privacy, retention. |
| `registry.tool` | Tool Registry | Source of truth for platform and product tools. |
| `registry.asset` | Asset Registry | Source of truth for assets, owners, consumers, status. |
| `registry.localization` | Localization Registry | Source of truth for language strings, policies, ownership, drift. |
| `registry.collection` | Collection Registry | Source of truth for Firestore/Firebase objects. |
| `registry.ownership` | Ownership Registry | Source of truth for owner assignment across objects. |
| `registry.compliance` | Compliance Registry | Source of truth for audit findings, mismatches, open operations. |
| `registry.archive` | Archive Registry | Source of truth for preserved and superseded versions. |
| `registry.workforce` | Workforce Registry | Source of truth for workforce roles and authority. |
| `registry.department` | Department Registry | Source of truth for constitutional departments. |

### 7.8 Required Signals

| Signal ID | Signal Name | Purpose |
|---|---|---|
| `signal.registry.created` | Registry Created | Records registry creation. |
| `signal.registry.updated` | Registry Updated | Records registry update. |
| `signal.registry.owner_missing` | Registry Owner Missing | Records missing ownership. |
| `signal.registry.drift_detected` | Registry Drift Detected | Records registry/system mismatch. |
| `signal.registry.validation_passed` | Registry Validation Passed | Records successful validation. |
| `signal.registry.validation_failed` | Registry Validation Failed | Records failed validation. |

### 7.9 Required Workforce Definitions

| Workforce Role | Registry Responsibility |
|---|---|
| Owner | Authorizes registry authority model. |
| Legal & Governance | Interprets registry policy and language constraints. |
| Technical | Executes registry-system binding if implementation is authorized later. |
| Monitoring | Verifies registry status and drift signals. |
| Compliance | Detects missing, outdated, orphaned, ownerless, or inconsistent registry entries. |
| Archive | Preserves registry versions. |
| Registry Steward | Maintains registry completeness and evidence links. |

### 7.10 Phase 4 Construction Order

| Step | Construction Action | Depends On | Produces |
|---|---|---|---|
| 4.1 | Import Phase 0-3 structures. | Phases 0-3 | Registry object requirements. |
| 4.2 | Define registry taxonomy. | Registry readiness snapshot | Registry architecture. |
| 4.3 | Define schema fields per registry. | Card/workforce/department models | Registry schema catalog. |
| 4.4 | Assign registry ownership. | Workforce authority matrix | Registry ownership matrix. |
| 4.5 | Define registry dependencies. | Registry architecture | Registry dependency graph. |
| 4.6 | Map current missing/transitional registries. | Snapshot gap analysis | Registry gap ledger. |
| 4.7 | Issue Phase 4 output package. | Steps 4.1-4.6 | Registry structure package. |

## 8. PHASE 5 - Auditor Structure

### 8.1 Purpose

Define constitutional auditors and compliance observers that detect mismatches, missing ownership, outdated cards, stale registries, missing signals, language drift, collection ownership gaps, and archive gaps without modifying, approving, or executing changes.

### 8.2 Dependencies

| Dependency | Source | Status |
|---|---|---|
| Master Constitution Structure | Phase 0 | Required |
| Department Structure | Phase 1 | Required |
| Workforce Structure | Phase 2 | Required |
| Card Constitution Structure | Phase 3 | Required |
| Registry Structure | Phase 4 | Required |
| Gap analysis | Snapshot section 10 | Available |

### 8.3 Required Inputs

| Input ID | Input Name | Purpose |
|---|---|---|
| `input.phase5.registry_architecture` | Registry architecture | Defines auditor comparison targets. |
| `input.phase5.card_lifecycle` | Card lifecycle model | Defines card audit states. |
| `input.phase5.workforce_authority` | Workforce authority matrix | Defines auditor limits and escalation paths. |
| `input.phase5.gap_ledger` | Gap ledgers from prior phases | Defines known audit targets. |
| `input.phase5.language_policy` | Language policies and validation rules | Defines localization/language audit rules. |

### 8.4 Generated Outputs

| Output ID | Output Name | Output Type | Description |
|---|---|---|---|
| `output.phase5.auditor_taxonomy` | Auditor Taxonomy | Auditor model | Defines auditor classes and scopes. |
| `output.phase5.audit_rule_catalog` | Audit Rule Catalog | Rule catalog | Defines what each auditor checks. |
| `output.phase5.audit_signal_matrix` | Audit Signal Matrix | Signal matrix | Defines auditor-produced signals. |
| `output.phase5.audit_escalation_model` | Audit Escalation Model | Escalation model | Defines escalation paths and criticality. |
| `output.phase5.audit_report_model` | Audit Report Model | Report model | Defines required audit reports and fields. |

### 8.5 Required Cards

| Card ID | Card Name | Auditor Area |
|---|---|---|
| `card.auditor.master` | Master Constitutional Auditor Card | Overall constitutional consistency. |
| `card.auditor.card` | Card Auditor Card | Card lifecycle, ownership, drift. |
| `card.auditor.registry` | Registry Auditor Card | Registry completeness and mismatch. |
| `card.auditor.signal` | Signal Auditor Card | Signal ownership, producer/consumer, routing. |
| `card.auditor.route` | Route Auditor Card | Route ownership and surface alignment. |
| `card.auditor.localization` | Localization Auditor Card | Language policy and string ownership. |
| `card.auditor.collection` | Collection Auditor Card | Firestore collection ownership and retention. |
| `card.auditor.archive` | Archive Auditor Card | Preservation and supersession state. |
| `card.auditor.workforce` | Workforce Auditor Card | Authority and permission alignment. |

### 8.6 Required Guides

| Guide ID | Guide Name | Purpose |
|---|---|---|
| `guide.auditor.doctrine` | Auditor Doctrine Guide | Defines observe-only auditor behavior. |
| `guide.auditor.rules` | Audit Rule Guide | Defines checks by object class. |
| `guide.auditor.escalation` | Audit Escalation Guide | Defines mismatch and critical escalation flow. |
| `guide.auditor.reporting` | Audit Reporting Guide | Defines report format and required fields. |
| `guide.auditor.non_authority` | Auditor Non-Authority Guide | Defines no-modify, no-approve, no-execute limits. |

### 8.7 Required Registries

| Registry ID | Registry Name | Purpose |
|---|---|---|
| `registry.auditor` | Auditor Registry | Registers auditors, scopes, owners, limits. |
| `registry.audit_rule` | Audit Rule Registry | Registers checks and expected evidence. |
| `registry.audit_report` | Audit Report Registry | Registers audit reports and status. |
| `registry.audit_signal` | Audit Signal Registry | Registers auditor-produced signals. |
| `registry.audit_escalation` | Audit Escalation Registry | Registers escalation thresholds and recipients. |

### 8.8 Required Signals

| Signal ID | Signal Name | Purpose |
|---|---|---|
| `signal.audit.started` | Audit Started | Records auditor run start. |
| `signal.audit.completed` | Audit Completed | Records auditor run completion. |
| `signal.audit.mismatch_detected` | Mismatch Detected | Records registry/system mismatch. |
| `signal.audit.owner_missing` | Owner Missing | Records missing owner. |
| `signal.audit.card_outdated` | Card Outdated | Records outdated card. |
| `signal.audit.registry_missing` | Registry Missing | Records missing registry. |
| `signal.audit.language_drift` | Language Drift | Records localization/language drift. |
| `signal.audit.critical` | Critical Audit Signal | Records critical mismatch. |
| `signal.audit.escalated` | Audit Escalated | Records escalation. |

### 8.9 Required Workforce Definitions

| Workforce Role | Auditor Responsibility |
|---|---|
| Compliance | Owns mismatch detection and report generation. |
| Legal & Governance | Receives and interprets policy/legal/language mismatches. |
| Owner | Receives unresolved, critical, or authority-level escalations. |
| Monitoring | Verifies active process impact and operational criticality. |
| Technical | Receives implementation-impact findings without auditor execution authority. |
| Archive | Preserves audit reports and superseded states. |

### 8.10 Phase 5 Construction Order

| Step | Construction Action | Depends On | Produces |
|---|---|---|---|
| 5.1 | Import registry architecture and card lifecycle. | Phases 3-4 | Auditor comparison base. |
| 5.2 | Define auditor classes. | Workforce and registry structures | Auditor taxonomy. |
| 5.3 | Define audit rules per object class. | Registry schemas | Audit rule catalog. |
| 5.4 | Define audit signals. | Signal registry requirements | Audit signal matrix. |
| 5.5 | Define audit reports. | Compliance registry requirements | Audit report model. |
| 5.6 | Define escalation paths and criticality. | Workforce escalation matrix | Audit escalation model. |
| 5.7 | Define auditor non-authority limits. | Workforce non-authority matrix | Auditor doctrine. |
| 5.8 | Issue Phase 5 output package. | Steps 5.1-5.7 | Auditor structure package. |

## 9. PHASE 6 - Archive Structure

### 9.1 Purpose

Define the constitutional archive system for preserving snapshots, constitution versions, department versions, card versions, registry versions, audit reports, frozen systems, legacy systems, superseded states, and recovery references.

### 9.2 Dependencies

| Dependency | Source | Status |
|---|---|---|
| Master Constitution Structure | Phase 0 | Required |
| Department Structure | Phase 1 | Required |
| Workforce Structure | Phase 2 | Required |
| Card Constitution Structure | Phase 3 | Required |
| Registry Structure | Phase 4 | Required |
| Auditor Structure | Phase 5 | Required |
| Legacy/frozen/transitional inventory | Snapshot section 13 | Available |

### 9.3 Required Inputs

| Input ID | Input Name | Purpose |
|---|---|---|
| `input.phase6.constitution_versions` | Constitution version model | Defines what gets archived. |
| `input.phase6.card_lifecycle` | Card lifecycle model | Defines archived/suspended/superseded cards. |
| `input.phase6.registry_versions` | Registry structure | Defines registry archival. |
| `input.phase6.audit_reports` | Audit report model | Defines report preservation. |
| `input.phase6.legacy_inventory` | Legacy/frozen/transitional systems inventory | Defines preserved historical systems. |
| `input.phase6.git_docs_history` | Git/docs history | Provides current archive substrate. |

### 9.4 Generated Outputs

| Output ID | Output Name | Output Type | Description |
|---|---|---|---|
| `output.phase6.archive_taxonomy` | Archive Taxonomy | Archive model | Defines archive object classes and status types. |
| `output.phase6.version_preservation_model` | Version Preservation Model | Version model | Defines how versions are preserved and superseded. |
| `output.phase6.archive_registry_schema` | Archive Registry Schema | Schema model | Defines archive registry fields. |
| `output.phase6.supersession_model` | Supersession Model | Lifecycle model | Defines replaced, frozen, legacy, archived, restored states. |
| `output.phase6.recovery_reference_model` | Recovery Reference Model | Recovery model | Defines how recovery references are recorded. |
| `output.phase6.final_constitution_build_sequence` | Final Constitution Build Sequence | Release sequence | Defines final order for writing the actual constitution after this plan. |

### 9.5 Required Cards

| Card ID | Card Name | Purpose |
|---|---|---|
| `card.archive.snapshot` | Snapshot Archive Card | Preserves constitutional snapshots. |
| `card.archive.constitution_version` | Constitution Version Archive Card | Preserves constitution versions. |
| `card.archive.department_version` | Department Version Archive Card | Preserves department constitution versions. |
| `card.archive.card_version` | Card Version Archive Card | Preserves card versions. |
| `card.archive.registry_version` | Registry Version Archive Card | Preserves registry versions. |
| `card.archive.audit_report` | Audit Report Archive Card | Preserves audit reports. |
| `card.archive.legacy_system` | Legacy System Archive Card | Preserves legacy/frozen systems. |
| `card.archive.recovery` | Recovery Reference Card | Preserves recovery references. |

### 9.6 Required Guides

| Guide ID | Guide Name | Purpose |
|---|---|---|
| `guide.archive.doctrine` | Archive Doctrine Guide | Defines preservation authority and rules. |
| `guide.archive.versioning` | Archive Versioning Guide | Defines version retention and supersession. |
| `guide.archive.legacy_frozen` | Legacy and Frozen Systems Guide | Defines legacy/frozen classification handling. |
| `guide.archive.recovery` | Recovery Reference Guide | Defines recovery references and restoration boundaries. |
| `guide.archive.audit_preservation` | Audit Preservation Guide | Defines audit report archival. |

### 9.7 Required Registries

| Registry ID | Registry Name | Purpose |
|---|---|---|
| `registry.archive` | Archive Registry | Registers archived objects and versions. |
| `registry.archive_snapshot` | Snapshot Archive Registry | Registers snapshot versions. |
| `registry.archive_constitution` | Constitution Archive Registry | Registers constitution versions. |
| `registry.archive_card` | Card Archive Registry | Registers card versions and supersession. |
| `registry.archive_registry` | Registry Archive Registry | Registers registry versions. |
| `registry.archive_audit` | Audit Archive Registry | Registers audit reports. |
| `registry.legacy_frozen` | Legacy/Frozen Registry | Registers legacy, frozen, orphaned, unknown, transitional systems. |
| `registry.recovery_reference` | Recovery Reference Registry | Registers recovery references. |

### 9.8 Required Signals

| Signal ID | Signal Name | Purpose |
|---|---|---|
| `signal.archive.created` | Archive Record Created | Records archive record creation. |
| `signal.archive.version_preserved` | Version Preserved | Records preserved version. |
| `signal.archive.superseded` | Object Superseded | Records supersession. |
| `signal.archive.frozen` | Object Frozen | Records frozen state. |
| `signal.archive.legacy_recorded` | Legacy Recorded | Records legacy state. |
| `signal.archive.recovery_reference_created` | Recovery Reference Created | Records recovery reference. |
| `signal.archive.restore_requested` | Restore Requested | Records restoration request. |
| `signal.archive.restore_denied` | Restore Denied | Records denied restoration. |
| `signal.archive.restore_authorized` | Restore Authorized | Records authorized restoration. |

### 9.9 Required Workforce Definitions

| Workforce Role | Archive Responsibility |
|---|---|
| Archive | Owns preservation, version retention, supersession records, recovery references. |
| Owner | Authorizes recovery and final archival acceptance. |
| Legal & Governance | Interprets legal/policy constraints over archives. |
| Compliance | Detects missing archive records and unpreserved supersessions. |
| Monitoring | Verifies active system impact of frozen/superseded objects. |
| Technical | Executes authorized archival tooling only when later implementation is approved. |

### 9.10 Phase 6 Construction Order

| Step | Construction Action | Depends On | Produces |
|---|---|---|---|
| 6.1 | Import all prior phase outputs. | Phases 0-5 | Archive source base. |
| 6.2 | Define archive object taxonomy. | Registry/card/auditor structures | Archive taxonomy. |
| 6.3 | Define version preservation model. | Constitution and registry version requirements | Version preservation model. |
| 6.4 | Define supersession and frozen/legacy rules. | Legacy/frozen inventory | Supersession model. |
| 6.5 | Define archive registry schemas. | Registry structure | Archive registry schema. |
| 6.6 | Define recovery reference model. | Owner/archive workforce definitions | Recovery reference model. |
| 6.7 | Define final constitution build sequence. | All phase outputs | Final constitution build sequence. |
| 6.8 | Issue Phase 6 output package. | Steps 6.1-6.7 | Archive structure package. |

## 10. Final Build Sequence After This Plan

The constitution itself is not written by this plan. The future build sequence implied by this plan is:

| Order | Future Artifact Package | Requires |
|---|---|---|
| 1 | Master Constitution Package | Phase 0 outputs |
| 2 | Department Constitution Package | Phase 1 outputs |
| 3 | Workforce Constitution Package | Phase 2 outputs |
| 4 | Card Constitution Package | Phase 3 outputs |
| 5 | Registry Constitution Package | Phase 4 outputs |
| 6 | Auditor Constitution Package | Phase 5 outputs |
| 7 | Archive Constitution Package | Phase 6 outputs |
| 8 | Constitutional Integration Index | All constitution packages |
| 9 | Constitutional Review Packet | Integration index, audit rules, workforce authority matrix |
| 10 | Constitutional Archive Packet | Final reviewed constitution packages |

## 11. Readiness Gate Before Constitution Writing

| Gate ID | Gate | Must Be Available Before Writing Constitution |
|---|---|---|
| `gate.phase0.complete` | Phase 0 package complete | Master structure, scope, doctrine hierarchy, authority principles, generation rules. |
| `gate.phase1.complete` | Phase 1 package complete | Department map, surface/route/collection matrices, department gap ledger. |
| `gate.phase2.complete` | Phase 2 package complete | Workforce map, authority matrix, escalation matrix, runtime role alignment. |
| `gate.phase3.complete` | Phase 3 package complete | Card class model, lifecycle model, ownership/signal/surface matrices. |
| `gate.phase4.complete` | Phase 4 package complete | Registry architecture, schemas, ownership, dependency graph, gap ledger. |
| `gate.phase5.complete` | Phase 5 package complete | Auditor taxonomy, audit rules, signals, reports, escalation model. |
| `gate.phase6.complete` | Phase 6 package complete | Archive taxonomy, version model, supersession model, recovery model. |
| `gate.no_runtime_change` | No runtime change during planning | Constitution planning remains documentation-only. |

## 12. Plan Status

| Item | Status |
|---|---|
| Constitutional Snapshot Report input | Present |
| Build plan created | Present |
| Constitution written | Not started |
| Department constitutions written | Not started |
| Workforce constitutions written | Not started |
| Card constitutions written | Not started |
| Registries implemented | Not started |
| Auditors implemented | Not started |
| Archive implemented | Not started |
| Runtime app modified | No |
| Firebase modified | No |
| ARB modified | No |
| Routes modified | No |

