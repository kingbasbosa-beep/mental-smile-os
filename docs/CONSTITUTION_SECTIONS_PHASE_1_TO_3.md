# Mental Smile Constitution Sections - Phases 1 to 3

Document ID: `constitution.sections.phase_1_to_3.v1`
Selected Scope: `PHASE_1`, `PHASE_2`, `PHASE_3`
Excluded Scope: `PHASE_0_MASTER`, `PHASE_4_REGISTRY`, `PHASE_5_AUDITOR`, `PHASE_6_ARCHIVE`
Source Plan: `docs/MASTER_CONSTITUTION_GENERATION_PLAN.md`
Source Snapshot: `docs/MASTER_CONSTITUTIONAL_SNAPSHOT_REPORT.md`
Runtime Changes: `NONE`
Firebase Changes: `NONE`
ARB Changes: `NONE`
Route Changes: `NONE`

## 0. Generation Boundary

This document generates the selected constitutional sections only:

| Selected Section | Name | Generated Here |
|---|---|---|
| `PHASE_1` | Department Constitution Structure | Yes |
| `PHASE_2` | Workforce Structure | Yes |
| `PHASE_3` | Card Constitution Structure | Yes |

The master constitution is not generated here. Phase 0 remains a required dependency and source of inherited authority, but no Phase 0 section is written in this document.

This document also generates selected-section cards only:

| Card Family | Scope |
|---|---|
| Department Cards | Generated for Phase 1 departments only. |
| Employee Cards | Generated for Phase 2 workforce roles only. |
| Signal Cards | Generated for Phase 1-3 constitutional signals only. |
| Registry Cards | Generated for Phase 1-3 required registries only. |
| Workflow Cards | Generated for Phase 1-3 construction workflows only. |

## 1. PHASE 1 - Department Constitution Structure

### 1.1 Doctrine

The Department Constitution Structure doctrine states that every Mental Smile surface, route, collection, card, signal, tool, asset, localization area, and operational responsibility must belong to a named constitutional department before it can receive stable governance, workforce ownership, registry placement, compliance checks, or archive treatment.

Departments do not replace runtime routes, app features, Firebase collections, or existing documents. Departments are constitutional ownership domains that organize the current system into governable areas.

The department structure must preserve observed reality:

| Doctrine ID | Doctrine | Constitutional Meaning |
|---|---|---|
| `doctrine.department.observed_reality_first` | Departments are derived from current observed surfaces and routes. | No department may erase or rename current reality without a later authorized constitutional change. |
| `doctrine.department.surface_bound` | Every surface must map to a department. | Residential, commercial, administrative, owner, monitoring, legal governance, archive, technical, public portal, and localization surfaces require department assignment. |
| `doctrine.department.route_bound` | Every route must map to a department. | Route ownership cannot remain implicit once the department constitution is active. |
| `doctrine.department.collection_bound` | Every Firebase/Firestore collection must map to a department. | Data authority must be department-scoped. |
| `doctrine.department.language_bound` | Every surface language rule must map to a department. | Language ownership cannot remain floating between product, legal, and technical surfaces. |
| `doctrine.department.gap_visible` | Missing department components must remain visible. | Transitional, missing, unknown, orphaned, legacy, and frozen states must not be hidden. |

### 1.2 Definitions

| Term | Definition |
|---|---|
| Department | A constitutional ownership domain that governs a coherent part of Mental Smile. |
| Department Boundary | The declared set of surfaces, routes, collections, cards, signals, assets, language rules, tools, and roles belonging to a department. |
| Department Owner | The workforce authority responsible for a department's constitutional state. |
| Department Steward | The workforce role responsible for keeping department evidence and registries complete. |
| Department Consumer | A user, role, surface, card, signal, or workflow that depends on the department. |
| Department Gap | A missing, transitional, unknown, orphaned, legacy, or frozen object affecting a department. |
| Surface Assignment | The constitutional mapping of a surface to a department. |
| Route Assignment | The constitutional mapping of a route to a department. |
| Collection Assignment | The constitutional mapping of a Firestore/Firebase collection to a department. |
| Language Assignment | The constitutional mapping of language rules, strings, and term permissions to a department. |

### 1.3 Responsibilities

| Responsibility ID | Responsibility | Required Behavior |
|---|---|---|
| `resp.department.identify` | Identify constitutional departments. | Use the snapshot surfaces and current app topology as the source of department names and boundaries. |
| `resp.department.map_surfaces` | Map surfaces to departments. | Every current surface receives one primary department and optional secondary departments. |
| `resp.department.map_routes` | Map routes to departments. | Every current route receives a department owner and surface classification. |
| `resp.department.map_collections` | Map collections to departments. | Firestore collections and Firebase integrations receive department ownership. |
| `resp.department.map_assets` | Map assets to departments. | Asset areas receive owner, consumer, and status classification. |
| `resp.department.map_language` | Map language policy to departments. | Language policies, term matrices, generated localizations, and drift areas receive department ownership. |
| `resp.department.record_gaps` | Record department gaps. | Missing registries, missing owners, missing cards, and transitional systems remain visible. |
| `resp.department.produce_cards` | Produce department cards. | Each department receives a future-compatible department card. |

### 1.4 Authority Boundaries

| Authority | May Do | Must Not Do |
|---|---|---|
| Owner | Authorize final department constitutional acceptance. | Silently override missing ownership or missing registry evidence. |
| Legal & Governance | Interpret department language, policy, and authority conflicts. | Execute technical changes or modify runtime routes. |
| Technical | Verify route, collection, asset, and runtime evidence. | Redefine department authority without owner/legal authorization. |
| Monitoring | Verify department signals and operational visibility. | Approve department doctrine. |
| Compliance | Detect unmapped surfaces, routes, collections, assets, or language rules. | Modify departments or approve closure. |
| Archive | Preserve department versions and superseded mappings. | Interpret department authority. |
| Department Steward | Maintain department evidence and mapping completeness. | Create new authority outside the constitution. |

### 1.5 Inputs

| Input ID | Input | Source | Required |
|---|---|---|---|
| `input.phase1.master_structure` | Master Constitution Structure | Phase 0 dependency | Yes |
| `input.phase1.surface_inventory` | Current Surface Topology | Snapshot section 2 | Yes |
| `input.phase1.route_inventory` | Current Route Topology | Snapshot section 3 | Yes |
| `input.phase1.role_inventory` | Current Role Topology | Snapshot section 4 | Yes |
| `input.phase1.collection_inventory` | Firestore/Firebase Inventory | Snapshot section 11 | Yes |
| `input.phase1.asset_inventory` | Asset Inventory | Snapshot section 12 | Yes |
| `input.phase1.localization_inventory` | Localization Inventory | Snapshot section 12 | Yes |
| `input.phase1.gap_analysis` | Gap Analysis | Snapshot section 10 | Yes |

### 1.6 Outputs

| Output ID | Output | Type | Consumer |
|---|---|---|---|
| `output.phase1.department_map` | Department Constitution Map | Domain map | Phase 2 workforce, Phase 3 cards, Phase 4 registries |
| `output.phase1.surface_department_matrix` | Surface to Department Matrix | Governance matrix | Workforce, card, registry, compliance |
| `output.phase1.route_department_matrix` | Route to Department Matrix | Governance matrix | Workforce, cards, registries |
| `output.phase1.collection_department_matrix` | Collection to Department Matrix | Data governance matrix | Technical, legal, compliance, registries |
| `output.phase1.asset_department_matrix` | Asset to Department Matrix | Asset governance matrix | Technical, product, localization |
| `output.phase1.language_department_matrix` | Language to Department Matrix | Language governance matrix | Legal, localization, card governance |
| `output.phase1.department_gap_ledger` | Department Gap Ledger | Gap ledger | Compliance, owner, archive |
| `output.phase1.department_cards` | Department Card Set | Card package input | Future card package generation |

### 1.7 Dependencies

| Dependency ID | Dependency | Direction | Status |
|---|---|---|---|
| `dep.phase1.phase0` | Master Constitution Structure | Consumes | Required, not generated here |
| `dep.phase1.snapshot` | Constitutional Snapshot Report | Consumes | Present |
| `dep.phase1.routes` | Current route topology | Consumes | Active |
| `dep.phase1.surfaces` | Current surface topology | Consumes | Transitional |
| `dep.phase1.collections` | Firestore/Firebase inventory | Consumes | Active/transitional |
| `dep.phase1.language` | Language policy and localization inventory | Consumes | Transitional |
| `dep.phase1.workforce` | Workforce structure | Produces dependency for Phase 2 | Generated by next selected section |
| `dep.phase1.cards` | Card structure | Produces dependency for Phase 3 | Generated by selected Phase 3 |

### 1.8 Consumed Signals

| Signal ID | Signal | Purpose |
|---|---|---|
| `signal.constitution.snapshot_ingested` | Snapshot Ingested | Confirms snapshot has been accepted as source evidence. |
| `signal.constitution.phase_started` | Constitution Phase Started | Opens Phase 1 construction. |
| `signal.registry.drift_detected` | Registry Drift Detected | Consumed if existing registries conflict with department mapping. |
| `signal.audit.owner_missing` | Owner Missing | Consumed if department ownership cannot be assigned. |

### 1.9 Produced Signals

| Signal ID | Signal | Payload Requirements |
|---|---|---|
| `signal.department.created` | Department Created | Department ID, name, owner, primary surfaces, status. |
| `signal.department.surface_bound` | Surface Bound to Department | Surface ID, department ID, primary/secondary classification. |
| `signal.department.route_bound` | Route Bound to Department | Route path, screen, department ID, surface ID. |
| `signal.department.collection_bound` | Collection Bound to Department | Collection ID, department ID, data owner. |
| `signal.department.asset_bound` | Asset Bound to Department | Asset ID, department ID, consumer, status. |
| `signal.department.language_bound` | Language Bound to Department | Language object ID, department ID, policy source. |
| `signal.department.gap_recorded` | Department Gap Recorded | Gap ID, department ID, classification, affected objects. |
| `signal.constitution.phase_completed` | Constitution Phase Completed | Phase ID, outputs generated, unresolved gaps. |

### 1.10 Consumed Cards

| Card ID | Card | Source |
|---|---|---|
| `card.master.identity` | Master Identity Card | Phase 0 dependency |
| `card.master.doctrine` | Master Doctrine Card | Phase 0 dependency |
| `card.master.scope` | Master Scope Card | Phase 0 dependency |
| `card.master.authority` | Master Authority Card | Phase 0 dependency |
| `card.snapshot.surface` | Surface Snapshot Card | Snapshot-derived input |
| `card.snapshot.route` | Route Snapshot Card | Snapshot-derived input |
| `card.snapshot.collection` | Collection Snapshot Card | Snapshot-derived input |
| `card.snapshot.localization` | Localization Snapshot Card | Snapshot-derived input |

### 1.11 Produced Cards

| Card ID | Card | Card Type |
|---|---|---|
| `card.department.residential` | Residential Department Card | Department Card |
| `card.department.commercial` | Commercial Department Card | Department Card |
| `card.department.administrative` | Administrative Department Card | Department Card |
| `card.department.owner` | Owner Department Card | Department Card |
| `card.department.monitoring` | Monitoring Department Card | Department Card |
| `card.department.legal_governance` | Legal Governance Department Card | Department Card |
| `card.department.archive` | Archive Department Card | Department Card |
| `card.department.technical` | Technical Department Card | Department Card |
| `card.department.public_portal` | Public Portal Department Card | Department Card |
| `card.department.localization` | Localization Department Card | Department Card |
| `card.workflow.phase1.department_mapping` | Phase 1 Department Mapping Workflow Card | Workflow Card |

### 1.12 Required Registries

| Registry ID | Registry | Required Fields |
|---|---|---|
| `registry.department` | Department Registry | Department ID, name, owner, status, surfaces, routes, collections, assets, signals, tools, language rules. |
| `registry.surface_department` | Surface Department Registry | Surface ID, department ID, owner, status, consumers. |
| `registry.route_department` | Route Department Registry | Route path, screen, surface, department, access role, status. |
| `registry.collection_department` | Collection Department Registry | Collection ID, department, data owner, consumers, rules source. |
| `registry.asset_department` | Asset Department Registry | Asset ID, department, owner, consumers, status. |
| `registry.department_language` | Department Language Registry | String/policy ID, department, owner, validation source. |
| `registry.department_gap` | Department Gap Registry | Gap ID, department, object, classification, open/closed status. |

### 1.13 Required Archive Records

| Archive Record ID | Archive Record | Purpose |
|---|---|---|
| `archive.phase1.source_snapshot` | Phase 1 Source Snapshot Record | Preserves snapshot used to generate department structure. |
| `archive.phase1.department_map` | Department Map Version Record | Preserves generated department map version. |
| `archive.phase1.surface_matrix` | Surface Matrix Version Record | Preserves surface-to-department mapping. |
| `archive.phase1.route_matrix` | Route Matrix Version Record | Preserves route-to-department mapping. |
| `archive.phase1.gap_ledger` | Department Gap Ledger Record | Preserves open and closed department gaps. |

### 1.14 Required Compliance Checks

| Check ID | Compliance Check | Pass Condition |
|---|---|---|
| `check.phase1.all_surfaces_mapped` | All surfaces mapped | Every current surface has a department. |
| `check.phase1.all_routes_mapped` | All routes mapped | Every current route has a department and surface. |
| `check.phase1.all_collections_mapped` | All collections mapped | Every current collection has a department owner. |
| `check.phase1.all_department_cards_exist` | Department cards exist | Every department has a generated department card. |
| `check.phase1.gaps_not_hidden` | Gaps visible | Transitional/missing/orphaned/unknown objects remain in gap ledger. |
| `check.phase1.no_runtime_change` | No runtime change | No route, Firebase, ARB, or app code is changed during section generation. |

### 1.15 Required Workforce Roles

| Role ID | Role | Phase 1 Function |
|---|---|---|
| `workforce.owner` | Owner | Accepts department authority map. |
| `workforce.legal_governance` | Legal & Governance | Interprets policy/language conflicts. |
| `workforce.technical` | Technical | Verifies route, collection, asset, and app evidence. |
| `workforce.monitoring` | Monitoring | Verifies signal and operational visibility boundaries. |
| `workforce.compliance` | Compliance | Detects missing mappings and ownership gaps. |
| `workforce.archive` | Archive | Preserves department mapping versions. |
| `workforce.department_steward` | Department Steward | Maintains department evidence completeness. |

### 1.16 Department Constitution Matrix

| Department ID | Name | Doctrine Source | Surfaces | Primary Routes | Collections | Current Status |
|---|---|---|---|---|---|---|
| `department.residential` | Residential | Client support/discovery, signal-first ecosystem | Residential, personal space, library/support intersections | `/client/dashboard`, `/s/personal-space`, `/register/client`, `/module/library`, `/module/support-issue-selector` | `clients`, `saved_destinations`, `signal_events` | Active |
| `department.commercial` | Commercial | Provider/center declaration, contact not booking | Commercial, provider discovery, center discovery, marketplace placeholder | `/register/provider`, `/register/clinician`, `/register/center`, `/clinician/room`, `/center/room`, `/module/specialists/*`, `/module/centers/*`, `/s/city/marketplace` | `clinicians`, `centers`, `provider_contact_requests`, `center_contact_requests`, profile change requests | Active/transitional |
| `department.administrative` | Administrative | Registry/declaration/support administration | Registry room, declaration review room, support admin, chat escalations | `/s/registry-room`, `/s/declaration-review-room`, `/chat/escalations`, `/chat/escalation/report` | `system_domains`, `support_requests`, `chat_escalations` | Transitional |
| `department.owner` | Owner | Owner sovereignty | Owner district | `/s/owner/*` | Owner-specific runtime collection not observed | Transitional |
| `department.monitoring` | Monitoring | Monitoring observes, signal-first ecosystem | Capital, signal monitoring | `/s/capital/*`, `/s/capital/signal-monitoring-room` | `signal_events`, `signal_aggregates`, `analytics_summaries` | Transitional |
| `department.legal_governance` | Legal & Governance | Policy interpretation, language permission, compliance | Language policy docs, declaration review, compliance docs | `/s/declaration-review-room`, `/web/library/policy` | `ai_policies`, declaration/profile request collections | Transitional |
| `department.archive` | Archive | Archive preservation | Owner memory/vault/capsules naming, docs, Git history | `/s/owner/strategic-memory`, `/s/owner/sovereign-vault`, `/s/owner/constitutional-memory`, `/s/owner/capsules` | Runtime archive collection not observed | Transitional |
| `department.technical` | Technical | Technical execution only after authorization | Flutter app, Firebase, routes, functions, rules | All technical route infrastructure, `/s/capital/maintenance` | All technical Firebase objects and rules | Active |
| `department.public_portal` | Public Portal | Public entry and public contact | Public portal | `/`, `/about`, `/library`, `/contact`, `/request/service`, `/request/package`, `/splash` | Contact/request collections where implemented | Active |
| `department.localization` | Localization | Language ownership and surface term control | Localization runtime and policy docs | `/language` | ARB/generated localizations, policy docs | Transitional |

## 2. PHASE 2 - Workforce Structure

### 2.1 Doctrine

The Workforce Structure doctrine states that every constitutional action must have a named workforce role, a bounded authority verb, an accountable department, and a defined non-authority limit. No workforce role may interpret, authorize, execute, observe, audit, archive, or close a constitutional process unless that authority is explicitly assigned.

Workforce structure must preserve the current runtime roles while also defining missing constitutional roles that are currently documentary, transitional, or absent from runtime.

| Doctrine ID | Doctrine | Constitutional Meaning |
|---|---|---|
| `doctrine.workforce.named_authority` | Authority must be named. | No action may depend on an unnamed owner or implied role. |
| `doctrine.workforce.separation_of_powers` | Interpret, authorize, execute, observe, audit, and archive are separate powers. | Legal interprets, owner authorizes, technical executes, monitoring verifies, compliance detects, archive preserves. |
| `doctrine.workforce.non_authority_visible` | Every role must define what it cannot do. | Role limits are constitutional requirements, not optional notes. |
| `doctrine.workforce.runtime_alignment` | Runtime roles must align to constitutional workforce roles. | Existing Firebase/custom claim roles remain evidence, not complete authority by themselves. |
| `doctrine.workforce.escalation_required` | Escalations must have a route. | Compliance and monitoring findings require named recipients and status. |

### 2.2 Definitions

| Term | Definition |
|---|---|
| Workforce Role | A constitutional role responsible for a defined authority scope. |
| Employee Card | A future-compatible card describing a workforce role, authority, limits, dependencies, and signals. |
| Authority Verb | A constitutional action category: interpret, authorize, execute, observe, audit, preserve, steward, review. |
| Non-Authority | A declared action a role may not perform. |
| Escalation | The formal transfer of a finding, mismatch, conflict, or blocked operation to the next responsible authority. |
| Runtime Role Alignment | The mapping between current app/Firebase roles and constitutional workforce roles. |
| Authority Scope | The surfaces, departments, registries, cards, signals, and workflows a role may affect. |

### 2.3 Responsibilities

| Responsibility ID | Responsibility | Required Behavior |
|---|---|---|
| `resp.workforce.define_roles` | Define workforce roles. | Create clear role definitions for owner, legal, technical, monitoring, compliance, archive, support, registry, declaration review, and department-specific roles. |
| `resp.workforce.assign_authority` | Assign authority verbs. | Each role receives allowed authority verbs and denied verbs. |
| `resp.workforce.align_runtime` | Align runtime roles. | Map current roles such as `owner`, `monitoring_operator`, `registry_steward`, `declaration_reviewer`, `support_observer`, `client`, `center`, and `clinician`. |
| `resp.workforce.define_escalation` | Define escalation paths. | Escalation recipients and conditions must be explicit. |
| `resp.workforce.define_non_authority` | Define limits. | Every role card must include non-authority boundaries. |
| `resp.workforce.produce_employee_cards` | Produce employee cards. | Every workforce role receives a card compatible with future card packages. |

### 2.4 Authority Boundaries

| Workforce Role | Authority | Boundary |
|---|---|---|
| Owner | Authorize | May authorize constitutional acceptance, department authority, and final ownership decisions. Must not silently close compliance gaps. |
| Legal & Governance | Interpret | May interpret doctrine, policy, language, and authority conflicts. Must not execute runtime changes. |
| Technical | Execute | May implement later authorized changes. Must not interpret legal doctrine or self-authorize governance changes. |
| Monitoring | Observe and verify | May verify active process impact and signal/monitoring behavior. Must not approve cards or registries. |
| Compliance | Audit and escalate | May detect mismatch, missing ownership, outdated cards, and registry gaps. Must not modify, approve, or execute. |
| Archive | Preserve | May preserve versions and superseded records. Must not authorize restoration alone. |
| Support | Observe support | May observe support requests and escalations within support scope. Must not alter legal/owner decisions. |
| Registry Steward | Steward registries | May maintain registry evidence and completeness. Must not create new authority. |
| Declaration Reviewer | Review declarations | May review readiness/declaration evidence. Must not approve runtime marketplace authority outside assigned process. |
| Client | Use residential surfaces | May use client dashboard, personal space, support, library, saved destinations. Must not access administrative authority. |
| Clinician | Use clinician commercial surfaces | May use clinician room, profile edit, inbox, registration. Must not access center/owner/admin authority unless separately assigned. |
| Center | Use center commercial surfaces | May use center room, dashboard, profile edit, registration. Must not access clinician/owner/admin authority unless separately assigned. |

### 2.5 Inputs

| Input ID | Input | Source | Required |
|---|---|---|---|
| `input.phase2.department_map` | Department Constitution Map | Phase 1 | Yes |
| `input.phase2.role_inventory` | Current Role Topology | Snapshot section 4 | Yes |
| `input.phase2.workforce_readiness` | Workforce Readiness | Snapshot section 9 | Yes |
| `input.phase2.missing_workforce` | Missing Workforce Definitions | Snapshot section 10.5 | Yes |
| `input.phase2.route_gates` | Current route gates and auth roles | Runtime route topology | Yes |
| `input.phase2.firestore_rules` | Firestore/custom claim authority evidence | Firebase rules inventory | Yes |

### 2.6 Outputs

| Output ID | Output | Type | Consumer |
|---|---|---|---|
| `output.phase2.workforce_constitution_map` | Workforce Constitution Map | Authority map | Cards, registries, compliance |
| `output.phase2.authority_scope_matrix` | Authority Scope Matrix | Permission matrix | Cards, registries, auditors |
| `output.phase2.non_authority_matrix` | Non-Authority Matrix | Constraint matrix | Compliance, legal, owner |
| `output.phase2.escalation_matrix` | Escalation Matrix | Workflow matrix | Compliance, monitoring, owner |
| `output.phase2.runtime_role_alignment` | Runtime Role Alignment | Alignment report | Technical, security, route governance |
| `output.phase2.employee_cards` | Employee Card Set | Card package input | Future card package generation |

### 2.7 Dependencies

| Dependency ID | Dependency | Direction | Status |
|---|---|---|---|
| `dep.phase2.phase0` | Master Constitution Structure | Consumes | Required, not generated here |
| `dep.phase2.phase1` | Department Constitution Structure | Consumes | Generated in selected Phase 1 |
| `dep.phase2.runtime_roles` | Runtime roles and custom claims | Consumes | Active/transitional |
| `dep.phase2.route_gates` | AppRouter route authority | Consumes | Active |
| `dep.phase2.cards` | Card constitution | Produces dependency for Phase 3 | Generated in selected Phase 3 |
| `dep.phase2.registries` | Workforce and authority registries | Produces future dependency | Required later by Phase 4 |

### 2.8 Consumed Signals

| Signal ID | Signal | Purpose |
|---|---|---|
| `signal.department.created` | Department Created | Confirms departments exist for workforce assignment. |
| `signal.department.gap_recorded` | Department Gap Recorded | Identifies workforce gaps by department. |
| `signal.constitution.phase_started` | Constitution Phase Started | Opens Phase 2 construction. |
| `signal.audit.owner_missing` | Owner Missing | Indicates missing workforce ownership. |

### 2.9 Produced Signals

| Signal ID | Signal | Payload Requirements |
|---|---|---|
| `signal.workforce.role_defined` | Workforce Role Defined | Role ID, role name, department, status, runtime alignment. |
| `signal.workforce.authority_assigned` | Authority Assigned | Role ID, authority verb, scope, approving authority. |
| `signal.workforce.non_authority_defined` | Non-Authority Defined | Role ID, denied action, reason, affected scope. |
| `signal.workforce.permission_changed` | Permission Changed | Role ID, previous permission, new permission, source. |
| `signal.workforce.escalation_opened` | Escalation Opened | Source role, recipient role, reason, severity. |
| `signal.workforce.escalation_closed` | Escalation Closed | Escalation ID, closing authority, result. |
| `signal.workforce.runtime_aligned` | Runtime Role Aligned | Runtime role, constitutional role, route/surface scope. |
| `signal.constitution.phase_completed` | Constitution Phase Completed | Phase ID, outputs generated, unresolved gaps. |

### 2.10 Consumed Cards

| Card ID | Card | Source |
|---|---|---|
| `card.department.residential` | Residential Department Card | Phase 1 |
| `card.department.commercial` | Commercial Department Card | Phase 1 |
| `card.department.administrative` | Administrative Department Card | Phase 1 |
| `card.department.owner` | Owner Department Card | Phase 1 |
| `card.department.monitoring` | Monitoring Department Card | Phase 1 |
| `card.department.legal_governance` | Legal Governance Department Card | Phase 1 |
| `card.department.archive` | Archive Department Card | Phase 1 |
| `card.department.technical` | Technical Department Card | Phase 1 |
| `card.department.public_portal` | Public Portal Department Card | Phase 1 |
| `card.department.localization` | Localization Department Card | Phase 1 |

### 2.11 Produced Cards

| Card ID | Card | Card Type |
|---|---|---|
| `card.employee.owner` | Owner Employee Card | Employee Card |
| `card.employee.legal_governance` | Legal Governance Employee Card | Employee Card |
| `card.employee.technical` | Technical Employee Card | Employee Card |
| `card.employee.monitoring` | Monitoring Employee Card | Employee Card |
| `card.employee.compliance` | Compliance Employee Card | Employee Card |
| `card.employee.archive` | Archive Employee Card | Employee Card |
| `card.employee.support` | Support Employee Card | Employee Card |
| `card.employee.registry_steward` | Registry Steward Employee Card | Employee Card |
| `card.employee.declaration_reviewer` | Declaration Reviewer Employee Card | Employee Card |
| `card.employee.client` | Client Employee/User Role Card | Employee/User Card |
| `card.employee.clinician` | Clinician Employee/User Role Card | Employee/User Card |
| `card.employee.center` | Center Employee/User Role Card | Employee/User Card |
| `card.workflow.phase2.workforce_authority` | Phase 2 Workforce Authority Workflow Card | Workflow Card |

### 2.12 Required Registries

| Registry ID | Registry | Required Fields |
|---|---|---|
| `registry.workforce` | Workforce Registry | Role ID, name, department, status, authority verbs, dependencies, runtime mapping. |
| `registry.authority` | Authority Registry | Authority verb, role, scope, allowed action, denied action. |
| `registry.permission` | Permission Registry | Role ID, permission ID, surface, route, collection, status. |
| `registry.non_authority` | Non-Authority Registry | Role ID, denied action, rationale, enforcement surface. |
| `registry.escalation` | Escalation Registry | Trigger, source role, recipient role, time expectation, severity. |
| `registry.runtime_role_alignment` | Runtime Role Alignment Registry | Runtime claim/role, constitutional role, route scope, Firestore rule evidence. |

### 2.13 Required Archive Records

| Archive Record ID | Archive Record | Purpose |
|---|---|---|
| `archive.phase2.source_department_map` | Source Department Map Record | Preserves department map consumed by workforce structure. |
| `archive.phase2.workforce_map` | Workforce Map Version Record | Preserves generated workforce role map. |
| `archive.phase2.authority_matrix` | Authority Matrix Version Record | Preserves assigned authorities and boundaries. |
| `archive.phase2.escalation_matrix` | Escalation Matrix Version Record | Preserves escalation paths. |
| `archive.phase2.runtime_alignment` | Runtime Role Alignment Record | Preserves runtime-to-constitutional role mapping. |

### 2.14 Required Compliance Checks

| Check ID | Compliance Check | Pass Condition |
|---|---|---|
| `check.phase2.every_department_has_owner` | Every department has owner | Department owner is assigned or gap recorded. |
| `check.phase2.every_role_has_boundary` | Every role has authority boundary | Role has allowed and denied actions. |
| `check.phase2.runtime_roles_aligned` | Runtime roles aligned | Existing runtime roles map to constitutional workforce roles. |
| `check.phase2.escalation_defined` | Escalation defined | Compliance, monitoring, legal, owner, technical, archive escalation paths are explicit. |
| `check.phase2.no_role_self_authorizes` | No role self-authorizes outside scope | Authority matrix prevents self-expanding authority. |
| `check.phase2.no_runtime_change` | No runtime change | No route, Firebase, ARB, or app code is changed during section generation. |

### 2.15 Required Workforce Roles

| Role ID | Role | Status |
|---|---|---|
| `workforce.owner` | Owner | Required active authority |
| `workforce.legal_governance` | Legal & Governance | Required transitional authority |
| `workforce.technical` | Technical | Required active authority |
| `workforce.monitoring` | Monitoring | Required transitional authority |
| `workforce.compliance` | Compliance | Required transitional authority |
| `workforce.archive` | Archive | Required transitional authority |
| `workforce.support` | Support | Required active authority |
| `workforce.registry_steward` | Registry Steward | Required transitional authority |
| `workforce.declaration_reviewer` | Declaration Reviewer | Required transitional authority |
| `workforce.client` | Client | Required runtime role |
| `workforce.clinician` | Clinician | Required runtime role |
| `workforce.center` | Center | Required runtime role |

### 2.16 Workforce Authority Matrix

| Workforce ID | Interprets | Authorizes | Executes | Observes | Audits | Archives | Runtime Alignment |
|---|---|---|---|---|---|---|---|
| `workforce.owner` | No | Yes | No | Yes | No | No | `owner` |
| `workforce.legal_governance` | Yes | No | No | Yes | No | No | No dedicated runtime role observed |
| `workforce.technical` | No | No | Yes | Yes | No | No | External/repo/Firebase authority |
| `workforce.monitoring` | No | No | No | Yes | No | No | `monitoring_operator` |
| `workforce.compliance` | No | No | No | Yes | Yes | No | No dedicated runtime role observed |
| `workforce.archive` | No | No | No | Yes | No | Yes | No dedicated runtime role observed |
| `workforce.support` | No | No | Limited support process only | Yes | No | No | `support_observer` |
| `workforce.registry_steward` | No | No | Registry stewardship only | Yes | No | No | `registry_steward` |
| `workforce.declaration_reviewer` | Limited declaration interpretation | No | Review only | Yes | No | No | `declaration_reviewer` |
| `workforce.client` | No | No | User actions only | Own account only | No | No | `client` |
| `workforce.clinician` | No | No | Own commercial profile actions only | Own account only | No | No | `clinician` |
| `workforce.center` | No | No | Own commercial profile actions only | Own account only | No | No | `center` |

## 3. PHASE 3 - Card Constitution Structure

### 3.1 Doctrine

The Card Constitution Structure doctrine states that every card is a constitutional unit of meaning, ownership, lifecycle, signal behavior, registry placement, archive preservation, and compliance verification. Cards are not only UI widgets. A card may represent a department, employee/workforce role, signal, registry, workflow, screen unit, monitoring unit, governance unit, archive unit, or operational surface unit.

All cards generated in this section must be compatible with future card package generation. Compatibility requires stable IDs, source doctrine, owner, consumers, dependencies, produced and consumed signals, produced and consumed cards, required registries, archive records, compliance checks, and lifecycle status.

| Doctrine ID | Doctrine | Constitutional Meaning |
|---|---|---|
| `doctrine.card.doctrine_source_required` | Every card must originate from doctrine. | Cards cannot be invented without a constitutional source. |
| `doctrine.card.owner_required` | Every card must have an owner or visible ownership gap. | Ownerless cards are compliance findings. |
| `doctrine.card.lifecycle_required` | Every card must have lifecycle status. | Cards must support draft, sync, suspension, validation, approval, block, and archive states. |
| `doctrine.card.signal_bound` | Cards may consume and produce signals. | Signal relationships must be explicit when present. |
| `doctrine.card.registry_bound` | Cards must be registry-compatible. | Cards must include registry fields usable by a future card package. |
| `doctrine.card.archive_bound` | Card versions must be preservable. | Previous card versions cannot be silently overwritten. |
| `doctrine.card.section_scope` | Cards generated here belong only to selected sections. | No Phase 0, Phase 4, Phase 5, or Phase 6 card package is generated here. |

### 3.2 Definitions

| Term | Definition |
|---|---|
| Card | A governed constitutional object that can represent UI, workflow, role, signal, registry, department, or operational unit. |
| Department Card | A card describing a department's purpose, boundaries, dependencies, outputs, owner, and gaps. |
| Employee Card | A card describing a workforce role, authority, limits, dependencies, and escalation behavior. |
| Signal Card | A card describing a constitutional signal, its producer, consumer, payload, routing, privacy, and retention. |
| Registry Card | A card describing a registry, required fields, owner, consumers, and validation rules. |
| Workflow Card | A card describing a constitutional process, steps, inputs, outputs, signals, cards, and compliance checks. |
| Card Package Compatibility | The condition where a card has stable metadata and can later be included in a generated card pack without reinterpretation. |
| Card Lifecycle | The status model controlling draft, update, sync, suspension, deployment, validation, approval, block, and archive states. |

### 3.3 Responsibilities

| Responsibility ID | Responsibility | Required Behavior |
|---|---|---|
| `resp.card.define_classes` | Define card classes. | Classify department, employee, signal, registry, workflow, and future operational cards. |
| `resp.card.assign_owners` | Assign card owners. | Use Phase 1 departments and Phase 2 workforce authority. |
| `resp.card.bind_signals` | Bind card signals. | Declare consumed and produced signals. |
| `resp.card.bind_registries` | Bind required registries. | Declare registry placement for each card. |
| `resp.card.bind_archive` | Bind archive records. | Declare required archive records for each card. |
| `resp.card.bind_compliance` | Bind compliance checks. | Declare validation checks for card package readiness. |
| `resp.card.produce_selected_cards` | Produce selected-section cards. | Generate only Department, Employee, Signal, Registry, and Workflow cards for Phases 1-3. |

### 3.4 Authority Boundaries

| Authority | May Do | Must Not Do |
|---|---|---|
| Owner | Authorize card acceptance and department/role ownership. | Bypass missing compliance checks. |
| Legal & Governance | Interpret card doctrine, language, and authority boundaries. | Modify runtime card implementation. |
| Technical | Bind future cards to runtime only after authorization. | Generate unrelated cards outside selected sections. |
| Monitoring | Verify signal behavior and active process impact. | Approve cards. |
| Compliance | Detect card mismatch, missing ownership, missing registries, outdated status. | Modify, approve, or execute cards. |
| Archive | Preserve card versions and superseded records. | Interpret legal meaning or approve deployment. |

### 3.5 Inputs

| Input ID | Input | Source | Required |
|---|---|---|---|
| `input.phase3.phase1_departments` | Department Cards and Department Map | Phase 1 | Yes |
| `input.phase3.phase2_workforce` | Employee Cards and Authority Matrix | Phase 2 | Yes |
| `input.phase3.card_inventory` | Current Card Topology | Snapshot section 6 | Yes |
| `input.phase3.screen_card_graph` | Route to Screen to Card Relationship | Snapshot section 14.2 | Yes |
| `input.phase3.signal_inventory` | Current Signal Topology | Snapshot section 5 | Yes |
| `input.phase3.language_policy` | Language Policy Documents | Existing policy docs | Yes |
| `input.phase3.gap_analysis` | Missing Cards and Governance Structures | Snapshot section 10 | Yes |

### 3.6 Outputs

| Output ID | Output | Type | Consumer |
|---|---|---|---|
| `output.phase3.card_class_model` | Card Class Model | Card taxonomy | Future card registry |
| `output.phase3.card_lifecycle_model` | Card Lifecycle Model | Lifecycle model | Future card package generation |
| `output.phase3.card_ownership_matrix` | Card Ownership Matrix | Ownership matrix | Compliance, registries, owner |
| `output.phase3.card_signal_matrix` | Card Signal Matrix | Signal relationship matrix | Signal registry, monitoring |
| `output.phase3.card_registry_matrix` | Card Registry Matrix | Registry relationship matrix | Future registries |
| `output.phase3.card_archive_matrix` | Card Archive Matrix | Archive relationship matrix | Future archive |
| `output.phase3.selected_card_set` | Selected Card Set | Card package input | Future card package generation |

### 3.7 Dependencies

| Dependency ID | Dependency | Direction | Status |
|---|---|---|---|
| `dep.phase3.phase0` | Master Constitution Structure | Consumes | Required, not generated here |
| `dep.phase3.phase1` | Department Constitution Structure | Consumes | Generated in this document |
| `dep.phase3.phase2` | Workforce Structure | Consumes | Generated in this document |
| `dep.phase3.current_cards` | Current card-like widget inventory | Consumes | Active/transitional |
| `dep.phase3.signals` | Signal registry and signal topology | Consumes | Active/transitional |
| `dep.phase3.future_registry` | Card registry | Produces dependency for later Phase 4 | Required later, not fully generated here |
| `dep.phase3.future_archive` | Card archive | Produces dependency for later Phase 6 | Required later, not fully generated here |

### 3.8 Consumed Signals

| Signal ID | Signal | Purpose |
|---|---|---|
| `signal.department.created` | Department Created | Confirms department cards can be generated. |
| `signal.workforce.role_defined` | Workforce Role Defined | Confirms employee cards can be generated. |
| `signal.workforce.authority_assigned` | Authority Assigned | Assigns card owner/authority. |
| `signal.constitution.phase_started` | Constitution Phase Started | Opens Phase 3 construction. |
| `signal.audit.owner_missing` | Owner Missing | Consumed when a card owner is absent. |

### 3.9 Produced Signals

| Signal ID | Signal | Payload Requirements |
|---|---|---|
| `signal.card.created` | Card Created | Card ID, card type, doctrine source, owner, status. |
| `signal.card.updated` | Card Updated | Card ID, version, update source, changed fields. |
| `signal.card.sync_pending` | Card Sync Pending | Card ID, registry/system mismatch source. |
| `signal.card.suspended` | Card Suspended | Card ID, reason, affected consumers. |
| `signal.card.deployed` | Card Deployed | Card ID, version, deployment target. |
| `signal.card.validation_pending` | Card Validation Pending | Card ID, required checks, blocking dependencies. |
| `signal.card.approved` | Card Approved | Card ID, approving authority, version. |
| `signal.card.approval_blocked` | Card Approval Blocked | Card ID, blocker, responsible authority. |
| `signal.card.archived` | Card Archived | Card ID, version, archive record. |
| `signal.card.package_compatible` | Card Package Compatible | Card ID, required fields complete. |
| `signal.constitution.phase_completed` | Constitution Phase Completed | Phase ID, outputs generated, unresolved gaps. |

### 3.10 Consumed Cards

| Card ID | Card | Source |
|---|---|---|
| `card.department.*` | All Phase 1 Department Cards | Phase 1 |
| `card.employee.*` | All Phase 2 Employee Cards | Phase 2 |
| `card.snapshot.card_topology` | Card Topology Snapshot Card | Snapshot-derived input |
| `card.snapshot.signal_topology` | Signal Topology Snapshot Card | Snapshot-derived input |
| `card.snapshot.route_screen_card_graph` | Route Screen Card Graph Card | Snapshot-derived input |

### 3.11 Produced Cards

| Card Family | Produced Cards |
|---|---|
| Department Cards | `card.department.*` from Phase 1 |
| Employee Cards | `card.employee.*` from Phase 2 |
| Signal Cards | `card.signal.department.*`, `card.signal.workforce.*`, `card.signal.card.*` |
| Registry Cards | `card.registry.department`, `card.registry.workforce`, `card.registry.authority`, `card.registry.card`, selected support registries |
| Workflow Cards | `card.workflow.phase1.department_mapping`, `card.workflow.phase2.workforce_authority`, `card.workflow.phase3.card_generation` |

### 3.12 Required Registries

| Registry ID | Registry | Required Fields |
|---|---|---|
| `registry.card` | Card Registry | Card ID, type, owner, department, consumers, dependencies, status, version. |
| `registry.card_lifecycle` | Card Lifecycle Registry | State ID, allowed transitions, authority, compliance checks. |
| `registry.card_signal` | Card Signal Registry | Card ID, consumed signals, produced signals, routing targets. |
| `registry.card_route_surface` | Card Route Surface Registry | Card ID, route, screen, surface, department. |
| `registry.card_language` | Card Language Registry | Card ID, language owner, policy source, localization status. |
| `registry.card_archive` | Card Archive Registry | Card ID, version, archive record, supersession status. |
| `registry.card_compliance` | Card Compliance Registry | Card ID, check ID, status, blocker, reviewer. |

### 3.13 Required Archive Records

| Archive Record ID | Archive Record | Purpose |
|---|---|---|
| `archive.phase3.source_card_inventory` | Source Card Inventory Record | Preserves observed card-like widget inventory. |
| `archive.phase3.card_class_model` | Card Class Model Version Record | Preserves card taxonomy version. |
| `archive.phase3.card_lifecycle_model` | Card Lifecycle Version Record | Preserves card lifecycle model. |
| `archive.phase3.card_set` | Selected Card Set Archive Record | Preserves generated selected-section cards. |
| `archive.phase3.card_compliance_results` | Card Compliance Result Record | Preserves validation status and blockers. |

### 3.14 Required Compliance Checks

| Check ID | Compliance Check | Pass Condition |
|---|---|---|
| `check.phase3.card_has_doctrine` | Card has doctrine source | Every generated card references a doctrine. |
| `check.phase3.card_has_owner` | Card has owner | Every generated card has owner or visible missing-owner gap. |
| `check.phase3.card_has_signals` | Card signal fields present | Consumed and produced signals fields exist, even if empty. |
| `check.phase3.card_has_registries` | Card registry fields present | Required registries are listed. |
| `check.phase3.card_has_archive` | Card archive records present | Required archive records are listed. |
| `check.phase3.card_has_workforce` | Card workforce roles present | Required workforce roles are listed. |
| `check.phase3.card_package_compatible` | Card package compatible | Card metadata can be consumed by future card package generation. |
| `check.phase3.no_unrelated_cards` | No unrelated cards generated | No Phase 0, Phase 4, Phase 5, or Phase 6 card package is generated. |
| `check.phase3.no_runtime_change` | No runtime change | No route, Firebase, ARB, or app code is changed during section generation. |

### 3.15 Required Workforce Roles

| Role ID | Role | Phase 3 Function |
|---|---|---|
| `workforce.owner` | Owner | Authorizes card acceptance. |
| `workforce.legal_governance` | Legal & Governance | Interprets doctrine, language, and authority fields. |
| `workforce.technical` | Technical | Verifies future runtime compatibility without changing runtime. |
| `workforce.monitoring` | Monitoring | Verifies signal relationships and operational visibility. |
| `workforce.compliance` | Compliance | Detects missing fields, missing owners, outdated cards, registry mismatch. |
| `workforce.archive` | Archive | Preserves card versions. |
| `workforce.department_owner` | Department Owner | Owns department-specific card families. |

### 3.16 Card Lifecycle Model

| Lifecycle Status | Meaning | Entry Condition | Exit Condition |
|---|---|---|---|
| `GUIDE_DRAFT` | Card is drafted from doctrine. | Doctrine exists and card fields begin. | Required fields complete. |
| `GUIDE_UPDATED` | Doctrine/card source changed. | Source doctrine or card metadata updated. | Sync state evaluated. |
| `SYSTEM_SYNC_PENDING` | Card may not match runtime/system state. | Mismatch or unknown binding exists. | Compliance validates or blocks. |
| `OLD_CARD_SUSPENDED` | Previous card is suspended. | New card supersedes old card. | New card deployed or process blocked. |
| `NEW_CARD_DEPLOYED` | New card version is installed into the card set. | Owner/legal/technical process permits deployment. | Validation begins. |
| `VALIDATION_PENDING` | Card awaits checks. | Deployment or update requires validation. | Approved or blocked. |
| `APPROVED` | Card is accepted. | Required checks pass and authority approves. | Later update or archive. |
| `APPROVAL_BLOCKED` | Card cannot be accepted. | Missing owner, missing registry, mismatch, or failed check. | Blocker resolved or card archived. |
| `ARCHIVED` | Card version is preserved. | Card superseded, frozen, rejected, or retired. | Archive remains preserved. |

## 4. Generated Department Cards

Each department card is generated from `doctrine.department.*` and must remain compatible with future card package generation.

| Card ID | Name | Owner | Consumers | Dependencies | Inputs | Outputs | Consumed Signals | Produced Signals | Required Registries | Archive Records | Compliance Checks | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `card.department.residential` | Residential Department Card | Residential Department Owner | Client, support, monitoring, technical | Phase 0, route/surface inventory | Client routes, client collections, personal space, saved destinations, residential signals | Residential department map | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.surface_bound` | `registry.department`, `registry.surface_department`, `registry.route_department`, `registry.collection_department` | `archive.phase1.department_map` | `check.phase1.all_surfaces_mapped`, `check.phase1.all_routes_mapped` | `GUIDE_DRAFT` |
| `card.department.commercial` | Commercial Department Card | Commercial Department Owner | Clinician, center, clients, monitoring | Phase 0, commercial routes, Firestore collections | Provider/center registration, discovery, contact requests | Commercial department map | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.collection_bound` | `registry.department`, `registry.route_department`, `registry.collection_department` | `archive.phase1.department_map` | `check.phase1.all_collections_mapped` | `GUIDE_DRAFT` |
| `card.department.administrative` | Administrative Department Card | Administrative Department Owner | Registry steward, declaration reviewer, support observer | Phase 0, S rooms | Registry room, declaration review room, chat escalations | Administrative department map | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.gap_recorded` | `registry.department`, `registry.surface_department`, `registry.route_department` | `archive.phase1.department_map` | `check.phase1.gaps_not_hidden` | `GUIDE_DRAFT` |
| `card.department.owner` | Owner Department Card | Owner | Owner, archive, monitoring | Phase 0, owner route family | Owner district routes and owner cards | Owner department map | `signal.constitution.snapshot_ingested` | `signal.department.created` | `registry.department`, `registry.route_department` | `archive.phase1.department_map` | `check.phase1.all_routes_mapped` | `GUIDE_DRAFT` |
| `card.department.monitoring` | Monitoring Department Card | Monitoring Department Owner | Monitoring operator, owner, compliance | Phase 0, signal topology | Capital routes, signal monitoring room, signal events, analytics summaries | Monitoring department map | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.collection_bound` | `registry.department`, `registry.collection_department`, `registry.department_gap` | `archive.phase1.department_map` | `check.phase1.all_collections_mapped` | `GUIDE_DRAFT` |
| `card.department.legal_governance` | Legal Governance Department Card | Legal & Governance | Owner, compliance, localization, declaration review | Phase 0, policy docs | Language policy, permission matrix, declaration review, AI policies | Legal governance department map | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.language_bound` | `registry.department`, `registry.department_language` | `archive.phase1.department_map` | `check.phase1.gaps_not_hidden` | `GUIDE_DRAFT` |
| `card.department.archive` | Archive Department Card | Archive Workforce | Owner, compliance, all departments | Phase 0, Git/docs history | Snapshot records, owner memory surfaces, frozen/legacy inventory | Archive department map | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.gap_recorded` | `registry.department`, `registry.department_gap` | `archive.phase1.department_map` | `check.phase1.gaps_not_hidden` | `GUIDE_DRAFT` |
| `card.department.technical` | Technical Department Card | Technical | All departments, owner, compliance | Phase 0, repo/Firebase evidence | Flutter, Firebase, routes, functions, rules, Git | Technical department map | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.collection_bound` | `registry.department`, `registry.route_department`, `registry.collection_department` | `archive.phase1.department_map` | `check.phase1.all_routes_mapped` | `GUIDE_DRAFT` |
| `card.department.public_portal` | Public Portal Department Card | Product/Public Portal Owner | Public users, commercial, support | Phase 0, public routes | Home, about, library, contact, requests, provider registration | Public portal department map | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.route_bound` | `registry.department`, `registry.route_department` | `archive.phase1.department_map` | `check.phase1.all_routes_mapped` | `GUIDE_DRAFT` |
| `card.department.localization` | Localization Department Card | Legal & Governance / Localization Owner | All UI surfaces, technical, legal | Phase 0, localization inventory | Generated localizations, language page, policies, drift evidence | Localization department map | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.language_bound` | `registry.department`, `registry.department_language` | `archive.phase1.department_map` | `check.phase1.gaps_not_hidden` | `GUIDE_DRAFT` |

## 5. Generated Employee Cards

Each employee card is generated from `doctrine.workforce.*` and must define authority and non-authority boundaries.

| Card ID | Name | Owner | Consumers | Dependencies | Inputs | Outputs | Consumed Signals | Produced Signals | Required Registries | Archive Records | Compliance Checks | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `card.employee.owner` | Owner Employee Card | Owner | All departments | Phase 0, Phase 1 | Department map, authority principles | Owner authority definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.authority_assigned` | `registry.workforce`, `registry.authority` | `archive.phase2.workforce_map` | `check.phase2.every_role_has_boundary` | `GUIDE_DRAFT` |
| `card.employee.legal_governance` | Legal Governance Employee Card | Legal & Governance | Owner, technical, compliance, localization | Phase 1 | Policy docs, department map | Interpretation authority definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.authority_assigned` | `registry.workforce`, `registry.authority`, `registry.permission` | `archive.phase2.authority_matrix` | `check.phase2.every_role_has_boundary` | `GUIDE_DRAFT` |
| `card.employee.technical` | Technical Employee Card | Technical | All departments | Phase 1 | Route/Firebase evidence, department map | Execution authority definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.non_authority_defined` | `registry.workforce`, `registry.authority`, `registry.runtime_role_alignment` | `archive.phase2.runtime_alignment` | `check.phase2.runtime_roles_aligned` | `GUIDE_DRAFT` |
| `card.employee.monitoring` | Monitoring Employee Card | Monitoring | Owner, compliance, departments | Phase 1 | Signal monitoring surfaces, signal collections | Observation authority definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.authority_assigned` | `registry.workforce`, `registry.authority`, `registry.escalation` | `archive.phase2.workforce_map` | `check.phase2.escalation_defined` | `GUIDE_DRAFT` |
| `card.employee.compliance` | Compliance Employee Card | Compliance | Legal, owner, archive, monitoring | Phase 1, Phase 2 | Gap ledgers, authority matrix | Audit/escalation authority definition | `signal.department.gap_recorded` | `signal.workforce.role_defined`, `signal.workforce.escalation_opened` | `registry.workforce`, `registry.escalation`, `registry.non_authority` | `archive.phase2.escalation_matrix` | `check.phase2.no_role_self_authorizes` | `GUIDE_DRAFT` |
| `card.employee.archive` | Archive Employee Card | Archive | Owner, compliance, all departments | Phase 1 | Snapshot records, version needs | Preservation authority definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.authority_assigned` | `registry.workforce`, `registry.authority` | `archive.phase2.workforce_map` | `check.phase2.every_role_has_boundary` | `GUIDE_DRAFT` |
| `card.employee.support` | Support Employee Card | Support | Users, administrative, monitoring | Phase 1 | Support room, support requests, chat escalations | Support observation definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.runtime_aligned` | `registry.workforce`, `registry.runtime_role_alignment` | `archive.phase2.runtime_alignment` | `check.phase2.runtime_roles_aligned` | `GUIDE_DRAFT` |
| `card.employee.registry_steward` | Registry Steward Employee Card | Registry Steward | Administrative, compliance | Phase 1 | Registry room, system domains | Registry stewardship definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.runtime_aligned` | `registry.workforce`, `registry.runtime_role_alignment` | `archive.phase2.runtime_alignment` | `check.phase2.runtime_roles_aligned` | `GUIDE_DRAFT` |
| `card.employee.declaration_reviewer` | Declaration Reviewer Employee Card | Declaration Reviewer | Legal, administrative, commercial | Phase 1 | Declaration review room, readiness records | Declaration review definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.runtime_aligned` | `registry.workforce`, `registry.permission` | `archive.phase2.workforce_map` | `check.phase2.every_role_has_boundary` | `GUIDE_DRAFT` |
| `card.employee.client` | Client Employee/User Role Card | Residential | Client surfaces | Phase 1 | Client routes and collections | Client user authority definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.runtime_aligned` | `registry.workforce`, `registry.permission` | `archive.phase2.runtime_alignment` | `check.phase2.runtime_roles_aligned` | `GUIDE_DRAFT` |
| `card.employee.clinician` | Clinician Employee/User Role Card | Commercial | Clinician surfaces | Phase 1 | Clinician routes, readiness gate | Clinician user authority definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.runtime_aligned` | `registry.workforce`, `registry.permission` | `archive.phase2.runtime_alignment` | `check.phase2.runtime_roles_aligned` | `GUIDE_DRAFT` |
| `card.employee.center` | Center Employee/User Role Card | Commercial | Center surfaces | Phase 1 | Center routes, readiness gate | Center user authority definition | `signal.department.created` | `signal.workforce.role_defined`, `signal.workforce.runtime_aligned` | `registry.workforce`, `registry.permission` | `archive.phase2.runtime_alignment` | `check.phase2.runtime_roles_aligned` | `GUIDE_DRAFT` |

## 6. Generated Signal Cards

Signal cards here are constitutional construction signals for selected Phases 1-3. They do not replace runtime signal implementation.

| Card ID | Signal ID | Name | Owner | Producer | Consumer | Dependencies | Payload | Required Registries | Archive Records | Compliance Checks | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `card.signal.department.created` | `signal.department.created` | Department Created | Department Steward | Phase 1 workflow | Workforce, registry, cards | Department doctrine | Department ID, name, owner, status | `registry.department` | `archive.phase1.department_map` | `check.phase1.all_surfaces_mapped` | `GUIDE_DRAFT` |
| `card.signal.department.surface_bound` | `signal.department.surface_bound` | Surface Bound to Department | Department Steward | Phase 1 workflow | Registry, compliance | Surface topology | Surface ID, department ID, status | `registry.surface_department` | `archive.phase1.surface_matrix` | `check.phase1.all_surfaces_mapped` | `GUIDE_DRAFT` |
| `card.signal.department.route_bound` | `signal.department.route_bound` | Route Bound to Department | Technical/Department Steward | Phase 1 workflow | Registry, compliance | Route topology | Route path, screen, department ID | `registry.route_department` | `archive.phase1.route_matrix` | `check.phase1.all_routes_mapped` | `GUIDE_DRAFT` |
| `card.signal.department.collection_bound` | `signal.department.collection_bound` | Collection Bound to Department | Technical/Department Steward | Phase 1 workflow | Registry, compliance | Firestore inventory | Collection ID, department ID, owner | `registry.collection_department` | `archive.phase1.department_map` | `check.phase1.all_collections_mapped` | `GUIDE_DRAFT` |
| `card.signal.department.gap_recorded` | `signal.department.gap_recorded` | Department Gap Recorded | Compliance | Phase 1 workflow | Owner, legal, archive | Gap analysis | Gap ID, classification, department | `registry.department_gap` | `archive.phase1.gap_ledger` | `check.phase1.gaps_not_hidden` | `GUIDE_DRAFT` |
| `card.signal.workforce.role_defined` | `signal.workforce.role_defined` | Workforce Role Defined | Workforce Steward | Phase 2 workflow | Cards, registries | Workforce doctrine | Role ID, authority, status | `registry.workforce` | `archive.phase2.workforce_map` | `check.phase2.every_role_has_boundary` | `GUIDE_DRAFT` |
| `card.signal.workforce.authority_assigned` | `signal.workforce.authority_assigned` | Authority Assigned | Owner/Legal | Phase 2 workflow | Cards, compliance | Authority matrix | Role ID, verb, scope | `registry.authority` | `archive.phase2.authority_matrix` | `check.phase2.no_role_self_authorizes` | `GUIDE_DRAFT` |
| `card.signal.workforce.runtime_aligned` | `signal.workforce.runtime_aligned` | Runtime Role Aligned | Technical | Phase 2 workflow | Security, routes, compliance | Runtime roles | Runtime role, constitutional role, routes | `registry.runtime_role_alignment` | `archive.phase2.runtime_alignment` | `check.phase2.runtime_roles_aligned` | `GUIDE_DRAFT` |
| `card.signal.card.created` | `signal.card.created` | Card Created | Card Steward | Phase 3 workflow | Card registry, compliance | Card doctrine | Card ID, type, owner, status | `registry.card` | `archive.phase3.card_set` | `check.phase3.card_has_doctrine` | `GUIDE_DRAFT` |
| `card.signal.card.package_compatible` | `signal.card.package_compatible` | Card Package Compatible | Compliance/Card Steward | Phase 3 workflow | Future card package generator | Card metadata | Card ID, required fields complete | `registry.card_compliance` | `archive.phase3.card_compliance_results` | `check.phase3.card_package_compatible` | `GUIDE_DRAFT` |

## 7. Generated Registry Cards

Registry cards here define required registries for selected sections only. Full Phase 4 registry constitution is not generated here.

| Card ID | Registry ID | Name | Owner | Consumers | Dependencies | Required Fields | Produced Signals | Archive Records | Compliance Checks | Status |
|---|---|---|---|---|---|---|---|---|---|---|
| `card.registry.department` | `registry.department` | Department Registry Card | Department Steward | Workforce, cards, compliance | Phase 1 doctrine | Department ID, owner, surfaces, routes, collections, status | `signal.department.created` | `archive.phase1.department_map` | `check.phase1.all_surfaces_mapped` | `GUIDE_DRAFT` |
| `card.registry.surface_department` | `registry.surface_department` | Surface Department Registry Card | Department Steward | Compliance, card generation | Surface topology | Surface ID, department ID, owner, status | `signal.department.surface_bound` | `archive.phase1.surface_matrix` | `check.phase1.all_surfaces_mapped` | `GUIDE_DRAFT` |
| `card.registry.route_department` | `registry.route_department` | Route Department Registry Card | Technical/Department Steward | Cards, compliance | Route topology | Route path, screen, surface, department, status | `signal.department.route_bound` | `archive.phase1.route_matrix` | `check.phase1.all_routes_mapped` | `GUIDE_DRAFT` |
| `card.registry.collection_department` | `registry.collection_department` | Collection Department Registry Card | Technical/Department Steward | Legal, compliance | Firestore inventory | Collection ID, department, owner, consumers | `signal.department.collection_bound` | `archive.phase1.department_map` | `check.phase1.all_collections_mapped` | `GUIDE_DRAFT` |
| `card.registry.workforce` | `registry.workforce` | Workforce Registry Card | Workforce Steward | Owner, legal, compliance | Phase 2 doctrine | Role ID, department, authority, status | `signal.workforce.role_defined` | `archive.phase2.workforce_map` | `check.phase2.every_role_has_boundary` | `GUIDE_DRAFT` |
| `card.registry.authority` | `registry.authority` | Authority Registry Card | Owner/Legal | Workforce, compliance | Authority matrix | Role ID, authority verb, scope, boundary | `signal.workforce.authority_assigned` | `archive.phase2.authority_matrix` | `check.phase2.no_role_self_authorizes` | `GUIDE_DRAFT` |
| `card.registry.runtime_role_alignment` | `registry.runtime_role_alignment` | Runtime Role Alignment Registry Card | Technical | Security, routes, compliance | Runtime roles and route gates | Runtime role, constitutional role, route scope | `signal.workforce.runtime_aligned` | `archive.phase2.runtime_alignment` | `check.phase2.runtime_roles_aligned` | `GUIDE_DRAFT` |
| `card.registry.card` | `registry.card` | Card Registry Card | Card Steward | Future card packages, compliance | Phase 3 doctrine | Card ID, type, owner, dependencies, status | `signal.card.created` | `archive.phase3.card_set` | `check.phase3.card_package_compatible` | `GUIDE_DRAFT` |
| `card.registry.card_lifecycle` | `registry.card_lifecycle` | Card Lifecycle Registry Card | Legal/Card Steward | Cards, compliance | Phase 3 lifecycle model | Status ID, entry, exit, authority | `signal.card.updated` | `archive.phase3.card_lifecycle_model` | `check.phase3.card_has_registries` | `GUIDE_DRAFT` |
| `card.registry.card_compliance` | `registry.card_compliance` | Card Compliance Registry Card | Compliance | Owner, archive, card steward | Phase 3 checks | Card ID, check ID, result, blocker | `signal.card.package_compatible` | `archive.phase3.card_compliance_results` | `check.phase3.card_package_compatible` | `GUIDE_DRAFT` |

## 8. Generated Workflow Cards

Workflow cards define selected-section workflows only.

| Card ID | Name | Owner | Purpose | Steps | Inputs | Outputs | Consumed Signals | Produced Signals | Required Registries | Archive Records | Compliance Checks | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `card.workflow.phase1.department_mapping` | Phase 1 Department Mapping Workflow Card | Department Steward | Generate department structure from observed surfaces/routes/collections. | Import snapshot; define department IDs; map surfaces; map routes; map collections/assets/language; record gaps; issue department cards. | Snapshot report, route topology, surface topology, collection inventory, asset/localization inventory | Department map, matrices, department cards, gap ledger | `signal.constitution.snapshot_ingested` | `signal.department.created`, `signal.department.route_bound`, `signal.department.gap_recorded` | `registry.department`, `registry.surface_department`, `registry.route_department`, `registry.collection_department` | `archive.phase1.department_map`, `archive.phase1.gap_ledger` | `check.phase1.all_surfaces_mapped`, `check.phase1.all_routes_mapped`, `check.phase1.gaps_not_hidden` | `GUIDE_DRAFT` |
| `card.workflow.phase2.workforce_authority` | Phase 2 Workforce Authority Workflow Card | Owner / Legal & Governance | Generate workforce roles, authority boundaries, runtime alignment, and employee cards. | Import department map; define roles; assign authority verbs; define non-authority; define escalation; align runtime roles; issue employee cards. | Department map, role topology, workforce readiness, route gates, Firestore rules | Workforce map, authority matrix, escalation matrix, employee cards | `signal.department.created`, `signal.department.gap_recorded` | `signal.workforce.role_defined`, `signal.workforce.authority_assigned`, `signal.workforce.runtime_aligned` | `registry.workforce`, `registry.authority`, `registry.permission`, `registry.escalation` | `archive.phase2.workforce_map`, `archive.phase2.authority_matrix`, `archive.phase2.runtime_alignment` | `check.phase2.every_role_has_boundary`, `check.phase2.runtime_roles_aligned`, `check.phase2.escalation_defined` | `GUIDE_DRAFT` |
| `card.workflow.phase3.card_generation` | Phase 3 Card Generation Workflow Card | Card Steward / Compliance | Generate selected-section cards from doctrine and prepare future card package compatibility. | Import department and employee cards; define card classes; define lifecycle; bind owners; bind signals; bind registries; bind archive records; validate compatibility. | Phase 1 cards, Phase 2 cards, card topology, signal topology, language policy | Card class model, lifecycle model, selected card set, compliance matrix | `signal.workforce.role_defined`, `signal.workforce.authority_assigned` | `signal.card.created`, `signal.card.validation_pending`, `signal.card.package_compatible` | `registry.card`, `registry.card_lifecycle`, `registry.card_signal`, `registry.card_compliance` | `archive.phase3.card_set`, `archive.phase3.card_compliance_results` | `check.phase3.card_has_doctrine`, `check.phase3.card_package_compatible`, `check.phase3.no_unrelated_cards` | `GUIDE_DRAFT` |

## 9. Selected-Section Compatibility Ledger

| Compatibility Requirement | Phase 1 | Phase 2 | Phase 3 | Status |
|---|---|---|---|---|
| Doctrine present | Yes | Yes | Yes | Compatible |
| Definitions present | Yes | Yes | Yes | Compatible |
| Responsibilities present | Yes | Yes | Yes | Compatible |
| Authority boundaries present | Yes | Yes | Yes | Compatible |
| Inputs present | Yes | Yes | Yes | Compatible |
| Outputs present | Yes | Yes | Yes | Compatible |
| Dependencies present | Yes | Yes | Yes | Compatible |
| Consumed signals present | Yes | Yes | Yes | Compatible |
| Produced signals present | Yes | Yes | Yes | Compatible |
| Consumed cards present | Yes | Yes | Yes | Compatible |
| Produced cards present | Yes | Yes | Yes | Compatible |
| Required registries present | Yes | Yes | Yes | Compatible |
| Required archive records present | Yes | Yes | Yes | Compatible |
| Required compliance checks present | Yes | Yes | Yes | Compatible |
| Required workforce roles present | Yes | Yes | Yes | Compatible |
| Department cards generated | Yes | Consumed | Consumed | Compatible |
| Employee cards generated | Dependency | Yes | Consumed | Compatible |
| Signal cards generated | Yes | Yes | Yes | Compatible |
| Registry cards generated | Yes | Yes | Yes | Compatible |
| Workflow cards generated | Yes | Yes | Yes | Compatible |
| Unrelated sections excluded | Yes | Yes | Yes | Compatible |

## 10. Generation Status

| Item | Status |
|---|---|
| Phase 1 Department Constitution Structure | Generated |
| Phase 2 Workforce Structure | Generated |
| Phase 3 Card Constitution Structure | Generated |
| Phase 0 Master Constitution Structure | Not generated here |
| Phase 4 Registry Structure | Not generated here |
| Phase 5 Auditor Structure | Not generated here |
| Phase 6 Archive Structure | Not generated here |
| Department Cards | Generated for selected scope |
| Employee Cards | Generated for selected scope |
| Signal Cards | Generated for selected scope |
| Registry Cards | Generated for selected scope |
| Workflow Cards | Generated for selected scope |
| Future card package compatibility | Prepared |
| Runtime app changes | None |
| Firebase changes | None |
| ARB changes | None |
| Route changes | None |

