# GOVERNANCE_DECISION_REGISTRY_V1

Status: ACTIVE_GOVERNANCE_REGISTRY
Phase: 8A
Runtime effect: none

## Purpose

Record constitutional governance decisions that approve, reject, defer, or constrain future runtime, documentation, archive, registry, Git, Firebase, and release actions.

## Authority

Owner is final decision authority. Codex records decisions only when explicitly provided or implied by approved execution.

## Owner

Owner.

## Consumers

- Owner Approval Registry.
- Operations Registry.
- Archive Registry.
- Domain Boundary Registry.
- Phase reports.
- Future commit/release process.

## Inputs

- Owner approvals.
- Owner rejections.
- Owner deferrals.
- Audit findings.
- Validation evidence.
- Archive card recommendations.
- Registry update recommendations.

## Outputs

- Decision ID.
- Decision title.
- Decision status.
- Affected domain.
- Approved scope.
- Prohibited scope.
- Required follow-up.
- Memory impact.

## Dependencies

- Operations Registry.
- Owner Approval Registry.
- Finding Registry.
- Archive Registry.
- Memory Registry.

## Escalation Path

Finding/report -> proposed decision -> Owner decision -> Governance Decision Registry -> Operations Registry reference -> implementation or archive.

## Compliance Status

ACTIVE_REQUIRED

Major future actions require a decision record when they change authority, runtime, Git/Firebase state, archive status, public visibility, or Pure DNA baseline state.

## Decision Record Template

| Field | Value |
| --- | --- |
| Decision ID | GOV-DECISION-YYYYMMDD-### |
| Date | YYYY-MM-DD |
| Title | pending |
| Domain | pending |
| Decision | APPROVED / REJECTED / DEFERRED / REQUIRES_MORE_EVIDENCE |
| Approved Scope | pending |
| Prohibited Scope | pending |
| Related Operation | pending |
| Related Finding | pending |
| Related Card | pending |
| Memory Impact | pending |

## Decision Records

| Decision ID | Date | Title | Domain | Decision | Approved Scope | Prohibited Scope | Related Operation | Related Finding | Related Card | Memory Impact |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CLIENT_IDENTITY_EXTRACTION_DECISION_V1 | 2026-06-18 | Client Identity Extraction Era Documentation | RESIDENTIAL / SIGNALS | DOCUMENTED_DOCTRINE_ONLY | Document client identity simplification doctrine and fresh signal preference doctrine. | No runtime change, no login removal, no profile deletion, no Firebase change, no route change. | OP-PHASE-7A-CLIENT-IDENTITY-EXTRACTION-DOCUMENTATION-V1 | FINDING-FRESH-SIGNALS-OVER-STORED-PREFERENCES-V1 | `CLIENT_IDENTITY_EXTRACTION_DECISION_V1.md` | Creates Client Identity Extraction Era memory, Fresh Signal Preference Doctrine memory, and Stateless Client Room Doctrine memory. |
| CONSTITUTIONAL_OPERATION_LOGGING_DIRECTIVE_V1 | 2026-06-18 | Constitutional Operation Logging Directive | GOVERNANCE | APPROVED_DIRECTIVE | Every repository action must be operation-logged, linked, chronologically ordered, and integrity-verified after each phase. | No undocumented operation unless Owner explicitly says `DO NOT LOG THIS OPERATION`. | OP-CONSTITUTIONAL-OPERATION-LOGGING-DIRECTIVE-V1 | none | `CONSTITUTIONAL_OPERATION_LOGGING_DIRECTIVE_V1.md` | Creates mandatory operation logging and repository memory compliance memory. |
| CLIENT_ACCESS_EXECUTION_DECISION_V1 | 2026-06-18 | Phase 8 Client Access Execution | RESIDENTIAL / ACCESSIBILITY / RUNTIME | APPROVED_BY_PROMPT | Add splash quick/accessibility/provider-center access, introduce public Client Session Room, and mark client login/registration/profile as LEGACY_CANDIDATE. | Do not remove legacy routes yet; do not delete auth/profile data; do not change Firebase. | OP-PHASE-8-CLIENT-ACCESS-EXECUTION-V1 | FINDING-CLIENT-ACCESS-ACCOUNT-FIRST-BARRIER-V1 | `CLIENT_ACCESS_EXECUTION_DECISION_V1.md` | Records first runtime client access extraction step. |
| ACCESSIBLE_COMMUNICATION_EXECUTION_DECISION_V1 | 2026-06-18 | Phase 9 Accessible Communication Execution | ACCESSIBILITY / COMMERCIAL / SIGNALS | APPROVED_BY_PROMPT | Add accessible contact path, readiness field support, capability labels, and accessible contact signals on provider and center pages. | Do not classify users; do not remove normal contact; do not change Firebase; do not delete routes or collections. | OP-PHASE-9-ACCESSIBLE-COMMUNICATION-V1 | FINDING-ACCESSIBLE-CONTACT-PATH-MISSING-V1 | `ACCESSIBLE_COMMUNICATION_EXECUTION_DECISION_V1.md` | Records first runtime accessible communication execution step. |
| ACCESSIBILITY_TV_EXECUTION_DECISION_V1 | 2026-06-18 | Phase 10 Accessibility TV Execution | ACCESSIBILITY / CONTENT | APPROVED_BY_PROMPT | Add Accessibility TV as a YouTube Gateway card with fixed support topics. | No CMS; no video runtime; no embedded player; no collection; no Firebase action. | OP-PHASE-10-ACCESSIBILITY-TV-V1 | FINDING-ACCESSIBILITY-TV-GATEWAY-MISSING-V1 | `ACCESSIBILITY_TV_EXECUTION_DECISION_V1.md` | Records first runtime Accessibility TV gateway step. |
| PARTNERSHIP_FOUNDATION_DECISION_V1 | 2026-06-18 | Phase 11 Organizations And Partnerships Foundation | ACCESSIBILITY / PARTNERSHIPS | APPROVED_BY_PROMPT | Add organizations directory foundation, governed categories, empty registry, and non-persistent partnership request flow. | No Firebase action; no organization endorsement; no persisted request data; no partnership approval. | OP-PHASE-11-PARTNERSHIP-FOUNDATION-V1 | FINDING-PARTNERSHIP-DIRECTORY-FOUNDATION-MISSING-V1 | `PARTNERSHIP_FOUNDATION_DECISION_V1.md` | Records first accessibility partnership foundation step. |
| PHASE_OPERATION_GOVERNANCE_REINFORCEMENT_DECISION_V1 | 2026-06-18 | Phase Operation Governance Reinforcement | GOVERNANCE / OPERATIONS MEMORY | APPROVED_DIRECTIVE | Create operation record before every phase; update registries and run integrity verification after every phase; require cards for decisions, findings, removals, and implementations. | No undocumented operation; no skipped chronological ordering; no broken causality chain. | OP-PHASE-OPERATION-GOVERNANCE-REINFORCEMENT-V1 | none | `PHASE_OPERATION_GOVERNANCE_REINFORCEMENT_DECISION_V1.md` | Reinforces mandatory phase-level operation memory and causality preservation. |
