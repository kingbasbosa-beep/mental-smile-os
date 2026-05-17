# EX-93 EscalationRequest Package Boundary Simulation

## Package Boundary

The future package request model would be pure Dart and declarative only.

## Allowed Dependencies

The package model may depend only on already introduced package-safe human review contracts:

- `EscalationLevel`
- `EscalationReason`
- `EscalationState`
- `ReviewPriority`
- `ReviewVisibilityScope`
- `EscalationAuditLink`
- `EscalationPolicyReference`

## Required Caveats

- Request metadata does not initiate escalation execution.
- `level` and `priority` do not route or schedule.
- `reason` does not prove provider/runtime causality.
- `state` does not progress workflow.
- `visibilityScope` does not enforce authorization.
- `sanitizedPreview` is not privacy or security proof.
- `auditLink` and `policyReference` remain metadata only.
- `createdAt` does not prove backend ingestion or processing.
- A request record does not approve, route, execute, own, or guarantee escalation handling.

## Naming Review

The current name `EscalationRequest` is acceptable only if the caveats are strong. A more explicit future name such as `EscalationRequestMetadata` would reduce initiation-authority ambiguity, but would diverge from the compatibility pattern used by prior splits.

## Package Boundary Verdict

Package model is viable as `EscalationRequest` with caveats, or safer as `EscalationRequestMetadata` if semantic caution outweighs naming continuity.
