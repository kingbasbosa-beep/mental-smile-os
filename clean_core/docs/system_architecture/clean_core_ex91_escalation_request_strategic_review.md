# EX-91 EscalationRequest Strategic Review

## Scope

Reviewed `EscalationRequest` before any semantic freeze, simulation, or split execution.

## Current File

- `clean_core/lib/core/human_review/escalation_request.dart`

## Current Couplings

`EscalationRequest` is mixed and high-sensitivity:

- Firestore-coupled through `cloud_firestore`, `FieldValue.serverTimestamp()`, and `Timestamp.fromDate`.
- Mapper-coupled through `toMap`.
- Workflow-adjacent through `state`, `level`, `priority`, and `reason`.
- Routing-adjacent through `level`, `priority`, `visibilityScope`, and nearby queue semantics.
- Boundary-coupled through `EscalationBoundaryMarker`.
- Policy/audit-coupled through `EscalationAuditLink` and `EscalationPolicyReference`.

## Package-Safe Metadata Candidates

Potentially package-safe fields after semantic freeze:

- `uid`
- `level`
- `reason`
- `state`
- `priority`
- `visibilityScope`
- `sanitizedPreview`
- `auditLink`
- `policyReference`
- `createdAt`

These fields are package-safe only with caveats that they remain passive metadata.

## High-Risk Field

`boundaryMarker` is not ready for package exposure as-is. It contains terms that imply backend governance, client write permission, and emergency guarantees.

## Strategic Finding

`EscalationRequest` should not move directly and should not enter execution next. It needs a semantic freeze and likely boundary-marker redesign before any additive package split.
