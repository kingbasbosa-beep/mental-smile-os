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
