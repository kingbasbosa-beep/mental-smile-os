# EX-91 EscalationRequest Authority Review

## Authority Risks

`EscalationRequest` can be misread as initiating or authorizing escalation. Current fields imply authority-adjacent concepts:

- `uid` could be mistaken for authorized requester identity.
- `level` could be mistaken for escalation authority.
- `reason` could be mistaken for verified causality.
- `state` could be mistaken for backend transition state.
- `priority` could be mistaken for scheduling authority.
- `visibilityScope` could be mistaken for access control.
- `boundaryMarker` explicitly references backend governance, client writes, and emergency guarantee.
- `policyReference` could be mistaken for policy enforcement or approval.
- `auditLink` could be mistaken for audit proof.

## Required Authority Detox

Future package-safe request semantics must state:

- request metadata does not initiate escalation execution;
- `uid` does not prove authorization;
- `level` does not guarantee routing or escalation;
- `reason` does not prove runtime/provider causality;
- `state` does not progress workflow;
- `priority` does not schedule or order work;
- `visibilityScope` does not enforce access control;
- `policyReference` does not approve or enforce policy;
- `auditLink` does not prove persistence or integrity.

## Boundary Marker Risk

`EscalationBoundaryMarker` should remain host/backend-side until separately reviewed or replaced by a detoxed package-safe boundary label.

## Verdict

Authority risk is manageable only after semantic freeze and boundary marker redesign. Execution is not recommended as the next phase.
