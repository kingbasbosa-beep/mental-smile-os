# EX-99 Remaining Governance Boundaries

## Preserved Host-Only Concepts

- `EscalationBoundaryMarker`
- `EscalationQueue`
- queue acceptance/routing
- backend governance semantics
- emergency guarantee semantics
- runtime/provider orchestration semantics
- Firestore persistence ownership

## Governance-Sensitive Concepts

Remaining concepts require separate governance before exposure:

- boundary marker redesign;
- queue/routing model review;
- emergency handling semantics;
- backend-governed write policy;
- provider/runtime causality;
- observability and telemetry behavior;
- adapter bridge surfaces;
- any client-side authority representation.

## Boundary Rule

No future package exposure should proceed without semantic freeze, import review, mapper boundary review, export governance, rollback plan, and stop conditions.
