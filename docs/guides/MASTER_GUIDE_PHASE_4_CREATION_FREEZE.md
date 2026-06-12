# Mental Smile Phase 4 Creation Freeze - Registry Constitution Structure

Document ID: `master_guide.phase4.creation_freeze.v1`
Scope: `MASTER_GUIDE_ONLY`
Phase: `PHASE_4`
Phase Name: `Registry Constitution Structure`
Card Source: `MASTER_CARD_SOURCE`
Distribution Status For All Cards: `MASTER_GUIDE_ONLY`
Archive Scope For All Cards: `EXTERNAL_TO_PHASE_4`
Runtime Changes: `NONE`
Firebase Changes: `NONE`
Firestore Changes: `NONE`
Rules Changes: `NONE`
Runtime Registries Created: `NONE`
Database Schemas Created: `NONE`
Storage Implemented: `NONE`
Distribution: `NONE`
Deployment: `NONE`
Phase 1 Handling: `CONSUMED_ONLY`
Phase 2 Handling: `CONSUMED_ONLY`
Phase 3 Handling: `CONSUMED_ONLY`

Source Inputs:
- `docs/guides/MASTER_GUIDE_PHASE_1_CREATION_FREEZE.md`
- `docs/guides/MASTER_GUIDE_PHASE_1_PURITY_ENFORCEMENT_REPORT.md`
- `docs/guides/MASTER_GUIDE_PHASE_2_CREATION_FREEZE.md`
- `docs/guides/MASTER_GUIDE_PHASE_3_CREATION_FREEZE.md`
- `docs/MASTER_CONSTITUTION_GENERATION_PLAN.md`
- `docs/MASTER_CONSTITUTIONAL_SNAPSHOT_REPORT.md`

## 1. PHASE 4 CREATION FREEZE REPORT

Phase 4 creates the constitutional registry governance layer only. It defines what registries are, who owns them, who stewards them, how they relate, how they are validated, how they are blocked/replaced/archived externally, and how they hand off to Phase 5 auditors.

No runtime registries, storage schemas, database schemas, distribution packages, deployment artifacts, or department guides were created.

| Output Area | Created In This File | Distribution Status |
|---|---:|---|
| Registry Constitution | 1 | `MASTER_GUIDE_ONLY` |
| Root Registry Constitution | 1 | `MASTER_GUIDE_ONLY` |
| Registry Cards | 21 | `MASTER_GUIDE_ONLY` |
| Registry Lifecycle Cards | 7 | `MASTER_GUIDE_ONLY` |
| Registry Signal Cards | 7 | `MASTER_GUIDE_ONLY` |
| Registry Workflow Cards | 5 | `MASTER_GUIDE_ONLY` |
| Registry Gap Cards | 10 | `MASTER_GUIDE_ONLY` |
| Registry Topology Maps | 5 | `MASTER_GUIDE_ONLY` |

Phase 4 rules enforced:

| Rule | Enforcement |
|---|---|
| All registries require ownership. | Every registry card has `Owner`. |
| All registries require stewardship. | Every registry card has `Steward`. |
| Ownership Registry is the root registry. | All registry relationships derive from Ownership Registry. |
| No registry may bypass compliance. | Every registry card has compliance checks. |
| No registry may bypass archive relationship. | Archive Scope is declared as `EXTERNAL_TO_PHASE_4`. |
| No runtime registry may be created. | Governance-only registry cards were created. |

## 2. REGISTRY CONSTITUTION

| Element | Definition |
|---|---|
| Registry Definition | A constitutional source-of-truth index for governed objects, their owners, stewards, dependencies, validation rules, compliance rules, and archive relationship. |
| Registry Ownership | Every registry has a named owner responsible for constitutional authority and acceptance. |
| Registry Stewardship | Every registry has a named steward responsible for evidence completeness, validation readiness, and relationship maintenance. |
| Registry Lifecycle | Registries move through created, validated, active, replacement requested, replaced, blocked, and archived-external states. |
| Registry Validation | Registries must validate ownership, dependencies, card links, signal links, tool links, localization links, compliance status, and archive scope. |
| Registry Compliance | Compliance verifies no ownerless, stewardless, relationshipless, unvalidated, or archive-bypassing registry exists. |
| Registry Archive Relationship | Archive behavior is external to Phase 4; active registry cards only declare `EXTERNAL_TO_PHASE_4`. |

## 3. ROOT REGISTRY CONSTITUTION

Root Registry: `registry.ownership`

| Field | Constitutional Value |
|---|---|
| Owner | Owner / Legal & Governance |
| Steward | Registry Steward |
| Consumers | Department Registry, Workforce Registry, Card Registry, Signal Registry, Tool Registry, Asset Registry, Surface Registry, Route Registry, Collection Registry, Localization Registry, Compliance Registry, Archive Registry |
| Dependencies | Phase 1 department cards, Phase 2 workforce cards, Phase 3 card governance |
| Authority Scope | Assigns and validates owner/steward fields for all registries. |
| Validation Rules | No registry may pass validation without owner, steward, consumers, dependencies, compliance checks, and archive scope. |
| Compliance Rules | Ownerless or stewardless registries are blocked and require replacement. |

Constitutional rule: all registries require ownership.

## 4. REGISTRY CARD SET

Every generated card contains the required structure: `Card ID`, `Card Name`, `Card Type`, `Source Doctrine`, `Phase`, `Registry`, `Owner`, `Steward`, `Consumers`, `Dependencies`, `Inputs`, `Outputs`, `Consumed Signals`, `Produced Signals`, `Required Registries`, `Archive Scope`, `Compliance Checks`, `Current Status`, `Version`, `Distribution Status`.

| Card ID | Card Name | Card Type | Source Doctrine | Phase | Registry | Owner | Steward | Consumers | Dependencies | Inputs | Outputs | Consumed Signals | Produced Signals | Required Registries | Archive Scope | Compliance Checks | Current Status | Version | Distribution Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `card.phase4.registry.ownership` | Ownership Registry Card | Registry Card | `doctrine.registry.ownership_required` | `PHASE_4` | `registry.ownership` | Owner / Legal & Governance | Registry Steward | All registries | Phases 1-3 freezes | Owner/steward fields | Root ownership map | `signal.registry.created` | `signal.registry.validated` | `registry.ownership` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_has_owner`, `check.phase4.registry_has_steward` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.department` | Department Registry Card | Registry Card | `doctrine.registry.ownership_required` | `PHASE_4` | `registry.department` | Owner | Registry Steward | Workforce, cards, compliance | Phase 1 department cards | Departments, surfaces, routes, collections | Department registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.department` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.workforce` | Workforce Registry Card | Registry Card | `doctrine.registry.ownership_required` | `PHASE_4` | `registry.workforce` | Owner / Legal & Governance | Registry Steward | Authority, permissions, escalation | Phase 2 workforce cards | Workforce roles and scopes | Workforce registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.workforce` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.authority` | Authority Registry Card | Registry Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.authority` | Owner / Legal & Governance | Registry Steward | Workforce, compliance | Phase 2 authority cards | Authority verbs and boundaries | Authority registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.authority` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.permission` | Permission Registry Card | Registry Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.permission` | Legal & Governance | Registry Steward | Workforce, compliance | Phase 2 permission cards | Allowed and forbidden actions | Permission registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.permission` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.escalation` | Escalation Registry Card | Registry Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.escalation` | Compliance / Owner | Registry Steward | Legal, monitoring, technical, archive | Phase 2 escalation cards | Escalation triggers and recipients | Escalation registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.escalation` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.card` | Card Registry Card | Registry Card | `doctrine.registry.card_required` | `PHASE_4` | `registry.card` | Card Steward / Compliance | Registry Steward | Card lifecycle, replacement, validation | Phase 3 card constitution | Card IDs and lifecycle status | Card registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.card` | `EXTERNAL_TO_PHASE_4` | `check.phase4.card_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.card_lifecycle` | Card Lifecycle Registry Card | Registry Card | `doctrine.registry.card_required` | `PHASE_4` | `registry.card_lifecycle` | Card Steward / Compliance | Registry Steward | Card workflows | Phase 3 lifecycle constitution | Card lifecycle states | Lifecycle registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.card_lifecycle` | `EXTERNAL_TO_PHASE_4` | `check.phase4.card_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.card_version` | Card Version Registry Card | Registry Card | `doctrine.registry.card_required` | `PHASE_4` | `registry.card_version` | Card Steward / Compliance | Registry Steward | Replacement workflows | Phase 3 version constitution | Version classes and latest-only rule | Version registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.card_version` | `EXTERNAL_TO_PHASE_4` | `check.phase4.card_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.card_replacement` | Card Replacement Registry Card | Registry Card | `doctrine.registry.card_required` | `PHASE_4` | `registry.card_replacement` | Compliance / Card Steward | Registry Steward | Replacement workflows | Phase 3 replacement constitution | Replacement stages | Replacement registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.card_replacement` | `EXTERNAL_TO_PHASE_4` | `check.phase4.card_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.card_distribution` | Card Distribution Registry Card | Registry Card | `doctrine.registry.card_required` | `PHASE_4` | `registry.card_distribution` | Technical / Compliance | Registry Steward | Future distribution engine | Phase 3 distribution constitution | Distribution package rules | Distribution registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.card_distribution` | `EXTERNAL_TO_PHASE_4` | `check.phase4.no_distribution_occurred` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.card_validation` | Card Validation Registry Card | Registry Card | `doctrine.registry.card_required` | `PHASE_4` | `registry.card_validation` | Compliance | Registry Steward | All card workflows | Phase 3 validation constitution | Validation classes | Validation registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.card_validation` | `EXTERNAL_TO_PHASE_4` | `check.phase4.card_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.signal` | Signal Registry Card | Registry Card | `doctrine.registry.signal_required` | `PHASE_4` | `registry.signal` | Monitoring / Technical | Registry Steward | Cards, monitoring, compliance | Signal inventories Phases 1-3 | Signal IDs, producers, consumers | Signal registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.signal` | `EXTERNAL_TO_PHASE_4` | `check.phase4.signal_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.tool` | Tool Registry Card | Registry Card | `doctrine.registry.tool_required` | `PHASE_4` | `registry.tool` | Technical / Product | Registry Steward | Technical, departments | Tool inventory and gaps | Tool IDs, owners, consumers | Tool registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.tool` | `EXTERNAL_TO_PHASE_4` | `check.phase4.tool_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.asset` | Asset Registry Card | Registry Card | `doctrine.registry.ownership_required` | `PHASE_4` | `registry.asset` | Product / Technical | Registry Steward | UI, localization, departments | Asset inventory | Asset IDs, owners, consumers | Asset registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.asset` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_has_owner` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.surface` | Surface Registry Card | Registry Card | `doctrine.registry.ownership_required` | `PHASE_4` | `registry.surface` | Owner / Department Steward | Registry Steward | Department and route registries | Surface topology | Surface IDs, owners, status | Surface registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.surface` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.route` | Route Registry Card | Registry Card | `doctrine.registry.ownership_required` | `PHASE_4` | `registry.route` | Technical / Department Steward | Registry Steward | Surface, workforce, compliance | Route topology | Route path, screen, surface, owner | Route registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.route` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.collection` | Collection Registry Card | Registry Card | `doctrine.registry.ownership_required` | `PHASE_4` | `registry.collection` | Technical / Legal & Governance | Registry Steward | Data governance, compliance | Firestore/Firebase inventory | Collection IDs, owners, consumers | Collection registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.collection` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.localization` | Localization Registry Card | Registry Card | `doctrine.registry.localization_required` | `PHASE_4` | `registry.localization` | Legal & Governance / Localization Owner | Registry Steward | UI, legal, departments | Localization inventory | Strings, policies, term matrix, drift | Localization registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.localization` | `EXTERNAL_TO_PHASE_4` | `check.phase4.localization_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.compliance` | Compliance Registry Card | Registry Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.compliance` | Compliance / Owner | Registry Steward | Phase 5 auditors | Compliance gaps Phases 1-4 | Checks, findings, blockers | Compliance registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.registry.archive` | Archive Registry Card | Registry Card | `doctrine.registry.archive_relationship_required` | `PHASE_4` | `registry.archive` | Archive / Owner | Registry Steward | Phase 6 archive, compliance | Archive concepts Phases 1-3 | Archive relationships only | Archive registry governance | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.archive` | `EXTERNAL_TO_PHASE_4` | `check.phase4.archive_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |

## 5. REGISTRY RELATIONSHIP MAP

Root relationship rule: `registry.ownership` is the parent authority registry for every registry.

| Parent Registry | Child Registry | Relationship |
|---|---|---|
| `registry.ownership` | `registry.department` | Owns department registry owner/steward authority. |
| `registry.ownership` | `registry.workforce` | Owns workforce registry owner/steward authority. |
| `registry.ownership` | `registry.card` | Owns card registry owner/steward authority. |
| `registry.ownership` | `registry.signal` | Owns signal registry owner/steward authority. |
| `registry.ownership` | `registry.tool` | Owns tool registry owner/steward authority. |
| `registry.ownership` | `registry.localization` | Owns localization registry owner/steward authority. |
| `registry.department` | `registry.surface` | Departments bind surfaces. |
| `registry.surface` | `registry.route` | Surfaces expose routes. |
| `registry.route` | `registry.workforce` | Routes consume workforce permissions. |
| `registry.workforce` | `registry.authority` | Workforce roles receive authority. |
| `registry.authority` | `registry.permission` | Authority produces allowed/forbidden permissions. |
| `registry.permission` | `registry.escalation` | Permission failures escalate. |
| `registry.card` | `registry.card_lifecycle` | Cards consume lifecycle states. |
| `registry.card` | `registry.card_version` | Cards consume version rules. |
| `registry.card` | `registry.card_replacement` | Cards consume replacement rules. |
| `registry.card` | `registry.card_distribution` | Cards consume distribution rules. |
| `registry.card` | `registry.card_validation` | Cards consume validation rules. |
| `registry.signal` | `registry.card` | Signals bind to card producers/consumers. |
| `registry.tool` | `registry.department` | Tools are owned by departments. |
| `registry.asset` | `registry.surface` | Assets support surfaces. |
| `registry.collection` | `registry.department` | Collections are owned by departments. |
| `registry.localization` | `registry.surface` | Localization binds to surface language rules. |
| `registry.compliance` | `registry.archive` | Compliance findings require external archive relationship. |

## 6. REGISTRY LIFECYCLE CARD SET

| Card ID | Card Name | Card Type | Source Doctrine | Phase | Registry | Owner | Steward | Consumers | Dependencies | Inputs | Outputs | Consumed Signals | Produced Signals | Required Registries | Archive Scope | Compliance Checks | Current Status | Version | Distribution Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `card.phase4.lifecycle.registry_created` | REGISTRY_CREATED Card | Registry Lifecycle Card | `doctrine.registry.lifecycle_required` | `PHASE_4` | `registry.lifecycle` | Compliance | Registry Steward | All registries | Registry constitution | New registry governance card | Registry created state | None | `signal.registry.created` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.lifecycle_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.lifecycle.registry_validated` | REGISTRY_VALIDATED Card | Registry Lifecycle Card | `doctrine.registry.validation_required` | `PHASE_4` | `registry.lifecycle` | Compliance | Registry Steward | All registries | Validation constitution | Owner/steward/dependency checks | Registry validated state | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.lifecycle.registry_active` | REGISTRY_ACTIVE Card | Registry Lifecycle Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.lifecycle` | Owner / Compliance | Registry Steward | All registries | Validated registry | Compliant registry | Registry active state | `signal.registry.validated` | `signal.registry.activated` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.lifecycle.registry_replacement_requested` | REGISTRY_REPLACEMENT_REQUESTED Card | Registry Lifecycle Card | `doctrine.registry.replacement_required` | `PHASE_4` | `registry.lifecycle` | Compliance | Registry Steward | Replacement workflow | Active registry | Replacement reason | Registry replacement requested state | `signal.registry.activated` | `signal.registry.replacement_requested` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.lifecycle.registry_replaced` | REGISTRY_REPLACED Card | Registry Lifecycle Card | `doctrine.registry.replacement_required` | `PHASE_4` | `registry.lifecycle` | Owner / Compliance | Registry Steward | All registries | Replacement requested | New registry replaces old | Registry replaced state | `signal.registry.replacement_requested` | `signal.registry.replaced` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.lifecycle.registry_blocked` | REGISTRY_BLOCKED Card | Registry Lifecycle Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.lifecycle` | Compliance | Registry Steward | Owner, Phase 5 auditors | Validation/compliance failure | Block state | Registry blocked state | `signal.registry.validated` | `signal.registry.blocked` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.lifecycle.registry_archived` | REGISTRY_ARCHIVED Card | Registry Lifecycle Card | `doctrine.registry.archive_relationship_required` | `PHASE_4` | `registry.lifecycle` | Archive / Compliance | Registry Steward | Future archive phase | Replacement/block trigger | External archive relationship | Registry archived-external state | `signal.registry.replaced`, `signal.registry.blocked` | `signal.registry.archived` | `registry.archive`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.archive_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |

Lifecycle definitions:

| Lifecycle State | Entry Conditions | Exit Conditions | Validation | Compliance | Archive Scope |
|---|---|---|---|---|---|
| `REGISTRY_CREATED` | Registry card exists with required fields. | Ownership validation starts. | Structure check. | Owner/steward required. | `EXTERNAL_TO_PHASE_4` |
| `REGISTRY_VALIDATED` | Ownership, stewardship, dependency checks pass. | Active or blocked. | Full validation. | Compliance check required. | `EXTERNAL_TO_PHASE_4` |
| `REGISTRY_ACTIVE` | Validated and compliant. | Replacement requested or blocked. | Relationship check. | No bypass. | `EXTERNAL_TO_PHASE_4` |
| `REGISTRY_REPLACEMENT_REQUESTED` | Registry change required. | Replaced or blocked. | Replacement validation. | Compliance reason recorded. | `EXTERNAL_TO_PHASE_4` |
| `REGISTRY_REPLACED` | Replacement approved. | External archive relation later. | New registry valid. | Old registry not active. | `EXTERNAL_TO_PHASE_4` |
| `REGISTRY_BLOCKED` | Validation/compliance failure. | Replacement required. | Block validation. | Compliance owns finding. | `EXTERNAL_TO_PHASE_4` |
| `REGISTRY_ARCHIVED` | External archive relationship applies later. | No operational exit. | Archive relationship check. | Not active registry. | `EXTERNAL_TO_PHASE_4` |

## 7. REGISTRY VALIDATION CONSTITUTION

| Validation Type | Purpose | Required Evidence |
|---|---|---|
| Ownership Validation | Confirms registry owner exists. | `Owner` field and ownership registry relationship. |
| Dependency Validation | Confirms dependencies are declared. | Phase inputs and parent/child registry links. |
| Card Validation | Confirms registry-card relationships. | Card registry and card lifecycle links. |
| Signal Validation | Confirms registry signals. | Created, validated, activated, replacement, blocked, archived signals. |
| Tool Validation | Confirms tools are governed. | Tool registry owner/steward and department relationship. |
| Localization Validation | Confirms localization registry relationship. | Localization registry owner/steward and surface/department links. |
| Compliance Validation | Confirms no registry bypasses compliance. | Compliance checks and compliance registry link. |
| Archive Validation | Confirms external archive relationship. | Archive Scope = `EXTERNAL_TO_PHASE_4`. |

## 8. REGISTRY SIGNAL CARD SET

| Card ID | Card Name | Card Type | Source Doctrine | Phase | Registry | Owner | Steward | Consumers | Dependencies | Inputs | Outputs | Consumed Signals | Produced Signals | Required Registries | Archive Scope | Compliance Checks | Current Status | Version | Distribution Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `card.phase4.signal.registry_created` | Registry Created Signal Card | Signal Card | `doctrine.registry.lifecycle_required` | `PHASE_4` | `registry.signal` | Monitoring / Compliance | Registry Steward | Registry workflows | Registry constitution | Registry ID and owner | Created signal | None | `signal.registry.created` | `registry.signal`, `registry.ownership` | `EXTERNAL_TO_PHASE_4` | `check.phase4.signal_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.signal.registry_validated` | Registry Validated Signal Card | Signal Card | `doctrine.registry.validation_required` | `PHASE_4` | `registry.signal` | Compliance | Registry Steward | Registry workflows | Validation constitution | Validation result | Validated signal | `signal.registry.created` | `signal.registry.validated` | `registry.signal`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.signal.registry_activated` | Registry Activated Signal Card | Signal Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.signal` | Owner / Compliance | Registry Steward | Phase 5 auditors | Lifecycle constitution | Active registry result | Activated signal | `signal.registry.validated` | `signal.registry.activated` | `registry.signal`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.signal.registry_replacement_requested` | Registry Replacement Requested Signal Card | Signal Card | `doctrine.registry.replacement_required` | `PHASE_4` | `registry.signal` | Compliance | Registry Steward | Replacement workflow | Lifecycle constitution | Replacement reason | Replacement requested signal | `signal.registry.activated` | `signal.registry.replacement_requested` | `registry.signal`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.signal.registry_replaced` | Registry Replaced Signal Card | Signal Card | `doctrine.registry.replacement_required` | `PHASE_4` | `registry.signal` | Owner / Compliance | Registry Steward | All registries | Replacement workflow | Replacement result | Replaced signal | `signal.registry.replacement_requested` | `signal.registry.replaced` | `registry.signal`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.signal.registry_blocked` | Registry Blocked Signal Card | Signal Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.signal` | Compliance | Registry Steward | Owner, Phase 5 auditors | Validation failure | Block reason | Blocked signal | `signal.registry.validated` | `signal.registry.blocked` | `registry.signal`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.signal.registry_archived` | Registry Archived Signal Card | Signal Card | `doctrine.registry.archive_relationship_required` | `PHASE_4` | `registry.signal` | Archive / Compliance | Registry Steward | Future archive phase | Archive relationship | External archive signal | Archived signal | `signal.registry.replaced`, `signal.registry.blocked` | `signal.registry.archived` | `registry.signal`, `registry.archive` | `EXTERNAL_TO_PHASE_4` | `check.phase4.archive_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |

## 9. REGISTRY WORKFLOW CARD SET

| Card ID | Card Name | Card Type | Source Doctrine | Phase | Registry | Owner | Steward | Consumers | Dependencies | Inputs | Outputs | Consumed Signals | Produced Signals | Required Registries | Archive Scope | Compliance Checks | Current Status | Version | Distribution Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `card.phase4.workflow.registry_creation` | Registry Creation Workflow Card | Workflow Card | `doctrine.registry.lifecycle_required` | `PHASE_4` | `registry.workflow` | Registry Steward | Registry Steward | All registries | Registry constitution | Registry card request | Registry created workflow | None | `signal.registry.created` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_has_owner` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.workflow.registry_validation` | Registry Validation Workflow Card | Workflow Card | `doctrine.registry.validation_required` | `PHASE_4` | `registry.workflow` | Compliance | Registry Steward | Phase 5 auditors | Validation constitution | Registry card and relationships | Registry validation workflow | `signal.registry.created` | `signal.registry.validated` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.workflow.registry_replacement` | Registry Replacement Workflow Card | Workflow Card | `doctrine.registry.replacement_required` | `PHASE_4` | `registry.workflow` | Compliance / Owner | Registry Steward | All registries | Lifecycle constitution | Replacement reason | Registry replacement workflow | `signal.registry.replacement_requested` | `signal.registry.replaced` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.workflow.registry_blocking` | Registry Blocking Workflow Card | Workflow Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.workflow` | Compliance | Registry Steward | Owner, Phase 5 auditors | Compliance failure | Block evidence | Registry blocking workflow | `signal.registry.validated` | `signal.registry.blocked` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.phase4.workflow.registry_archive` | Registry Archive Workflow Card | Workflow Card | `doctrine.registry.archive_relationship_required` | `PHASE_4` | `registry.workflow` | Archive / Compliance | Registry Steward | Future archive phase | Replacement/block event | External archive relationship | Registry archive workflow | `signal.registry.replaced`, `signal.registry.blocked` | `signal.registry.archived` | `registry.archive`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.archive_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |

## 10. REGISTRY GAP CARD SET

| Card ID | Card Name | Card Type | Source Doctrine | Phase | Registry | Owner | Steward | Consumers | Dependencies | Inputs | Outputs | Consumed Signals | Produced Signals | Required Registries | Archive Scope | Compliance Checks | Current Status | Version | Distribution Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `card.gap.phase4.ownership_governance_missing` | Missing Ownership Governance Gap Card | Gap Card | `doctrine.registry.ownership_required` | `PHASE_4` | `registry.ownership` | Compliance | Registry Steward | Owner, Phase 5 auditors | Snapshot gaps | Ownership governance incomplete | Gap card | `signal.registry.created` | `signal.registry.blocked` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_has_owner` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.gap.phase4.registry_relationships_missing` | Missing Registry Relationships Gap Card | Gap Card | `doctrine.registry.relationship_required` | `PHASE_4` | `registry.relationship` | Compliance | Registry Steward | Phase 5 auditors | Relationship map | Registry relationships incomplete | Gap card | `signal.registry.created` | `signal.registry.blocked` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.gap.phase4.runtime_registries_missing` | Missing Runtime Registries Gap Card | Gap Card | `doctrine.registry.governance_only` | `PHASE_4` | `registry.runtime` | Compliance / Technical | Registry Steward | Technical, Phase 5 auditors | Snapshot registry readiness | Runtime registries not implemented | Gap card | `signal.registry.created` | `signal.registry.blocked` | `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.no_runtime_registry_created` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.gap.phase4.compliance_registry_missing` | Missing Compliance Registry Gap Card | Gap Card | `doctrine.registry.compliance_required` | `PHASE_4` | `registry.compliance` | Compliance | Registry Steward | Phase 5 auditors | Compliance gaps | Runtime compliance registry missing | Gap card | `signal.registry.created` | `signal.registry.blocked` | `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_compliant` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.gap.phase4.archive_registry_missing` | Missing Archive Registry Gap Card | Gap Card | `doctrine.registry.archive_relationship_required` | `PHASE_4` | `registry.archive` | Archive / Compliance | Registry Steward | Phase 6 archive | Archive gaps | Runtime archive registry missing | Gap card | `signal.registry.created` | `signal.registry.blocked` | `registry.archive`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.archive_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.gap.phase4.localization_registry_missing` | Missing Localization Registry Gap Card | Gap Card | `doctrine.registry.localization_required` | `PHASE_4` | `registry.localization` | Legal & Governance / Localization Owner | Registry Steward | Legal, UI, Phase 5 auditors | Localization gaps | Localization registry missing | Gap card | `signal.registry.created` | `signal.registry.blocked` | `registry.localization`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.localization_validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.gap.phase4.surface_registry_missing` | Missing Surface Registry Gap Card | Gap Card | `doctrine.registry.relationship_required` | `PHASE_4` | `registry.surface` | Owner / Department Steward | Registry Steward | Departments, routes, Phase 5 auditors | Surface topology | Runtime surface registry missing | Gap card | `signal.registry.created` | `signal.registry.blocked` | `registry.surface`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_relationship_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.gap.phase4.registry_synchronization_missing` | Missing Registry Synchronization Gap Card | Gap Card | `doctrine.registry.validation_required` | `PHASE_4` | `registry.synchronization` | Compliance / Technical | Registry Steward | Phase 5 auditors | Registry relationship map | Registry sync process missing | Gap card | `signal.registry.validated` | `signal.registry.blocked` | `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.gap.phase4.registry_validation_missing` | Missing Registry Validation Gap Card | Gap Card | `doctrine.registry.validation_required` | `PHASE_4` | `registry.validation` | Compliance | Registry Steward | Phase 5 auditors | Validation constitution | Runtime validation missing | Gap card | `signal.registry.created` | `signal.registry.blocked` | `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.validation_defined` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |
| `card.gap.phase4.registry_stewardship_missing` | Missing Registry Stewardship Gap Card | Gap Card | `doctrine.registry.stewardship_required` | `PHASE_4` | `registry.stewardship` | Compliance / Registry Steward | Registry Steward | Owner, Phase 5 auditors | Workforce freeze | Stewardship process incomplete | Gap card | `signal.registry.created` | `signal.registry.blocked` | `registry.ownership`, `registry.compliance` | `EXTERNAL_TO_PHASE_4` | `check.phase4.registry_has_steward` | `ACTIVE_CONSTITUTIONAL_CARD` | `v1.0.0` | `MASTER_GUIDE_ONLY` |

## 11. REGISTRY TOPOLOGY MAP

### 11.1 Constitutional Topology

```text
Constitution
  -> Departments
  -> Workforce
  -> Cards
  -> Ownership Registry
  -> All Registries
```

### 11.2 Ownership Tree

```text
registry.ownership
  -> registry.department
  -> registry.workforce
  -> registry.card
  -> registry.signal
  -> registry.tool
  -> registry.asset
  -> registry.surface
  -> registry.route
  -> registry.collection
  -> registry.localization
  -> registry.compliance
  -> registry.archive
```

### 11.3 Registry Tree

```text
registry.department
  -> registry.surface
  -> registry.route
  -> registry.collection

registry.workforce
  -> registry.authority
  -> registry.permission
  -> registry.escalation

registry.card
  -> registry.card_lifecycle
  -> registry.card_version
  -> registry.card_replacement
  -> registry.card_distribution
  -> registry.card_validation
```

### 11.4 Dependency Tree

```text
Phase 1 Department Freeze
  -> Department Registry
  -> Surface Registry
  -> Route Registry
  -> Collection Registry

Phase 2 Workforce Freeze
  -> Workforce Registry
  -> Authority Registry
  -> Permission Registry
  -> Escalation Registry

Phase 3 Card Freeze
  -> Card Registry
  -> Card Lifecycle Registry
  -> Card Version Registry
  -> Card Replacement Registry
  -> Card Distribution Registry
  -> Card Validation Registry
```

### 11.5 Validation Tree

```text
Ownership Validation
  -> Dependency Validation
  -> Card Validation
  -> Signal Validation
  -> Tool Validation
  -> Localization Validation
  -> Compliance Validation
  -> Archive Validation
```

### 11.6 Compliance Tree

```text
Compliance Registry
  -> Owner present
  -> Steward present
  -> Relationships defined
  -> Lifecycle state defined
  -> Validation rules defined
  -> Archive scope declared
  -> Runtime registry not created in Phase 4
```

## 12. PHASE 4 TO PHASE 5 READINESS HANDOFF

Phase 4 hands registry governance to Phase 5 Auditor Structure.

| Handoff Item | Produced By | Consumed By Phase 5 | Status |
|---|---|---|---|
| Registry constitution | Phase 4 | Auditor rule catalog | Ready in Master Guide only |
| Ownership registry root | Phase 4 | Auditor ownership checks | Ready in Master Guide only |
| Registry card set | Phase 4 | Auditor registry scan | Ready in Master Guide only |
| Registry relationship map | Phase 4 | Auditor relationship checks | Ready in Master Guide only |
| Registry lifecycle cards | Phase 4 | Auditor lifecycle checks | Ready in Master Guide only |
| Registry validation constitution | Phase 4 | Auditor validation checks | Ready in Master Guide only |
| Registry signal cards | Phase 4 | Auditor signal checks | Ready in Master Guide only |
| Registry workflow cards | Phase 4 | Auditor workflow checks | Ready in Master Guide only |
| Registry gap cards | Phase 4 | Auditor gap checks | Ready in Master Guide only |
| Registry topology map | Phase 4 | Auditor topology checks | Ready in Master Guide only |

Phase 5 start gates:

| Gate | Status |
|---|---|
| Ownership Registry exists | Passed |
| All registries have owners | Passed |
| All registries have stewards | Passed |
| All registry relationships are defined | Passed |
| All registry lifecycle states are defined | Passed |
| All registry validation rules are defined | Passed |
| No Phase 1 modifications exist | Passed |
| No Phase 2 modifications exist | Passed |
| No Phase 3 modifications exist | Passed |
| No runtime registries exist | Passed |
| No distribution occurred | Passed |
| All outputs remain Master Guide only | Passed |

## 13. PHASE 4 VALIDATION RESULT

| Validation Requirement | Result |
|---|---|
| Ownership Registry exists | PASS |
| All registries have owners | PASS |
| All registries have stewards | PASS |
| All registry relationships are defined | PASS |
| All registry lifecycle states are defined | PASS |
| All registry validation rules are defined | PASS |
| No Phase 1 modifications exist | PASS |
| No Phase 2 modifications exist | PASS |
| No Phase 3 modifications exist | PASS |
| No runtime registries exist | PASS |
| No distribution occurred | PASS |
| All outputs remain `MASTER_GUIDE_ONLY` | PASS |

Final Phase 4 creation freeze result: `PASS`.
