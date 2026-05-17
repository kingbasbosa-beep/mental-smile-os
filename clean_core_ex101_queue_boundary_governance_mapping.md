# EX-101 Queue/Boundary Governance Mapping

## Scope

This document records the queue and boundary governance doctrine derived from
EX-100. It is documentation only. It does not create package contracts, mappers,
imports, exports, runtime activation, provider activation, Firebase activation,
or consumer migration.

Primary inspected concepts:

- `EscalationQueue`
- `EscalationQueue.accepts`
- `EscalationBoundaryMarker`
- request, assignment, review, and resolution contracts
- audit and policy references
- Firestore mapping semantics
- routing, runtime, provider, response, and safety governance references

## Governance Classification

### Routing-coupled semantics

- Queue identifiers.
- Accepted reasons.
- Accepted priorities.
- Visible review scope.
- Allowed lifecycle states.
- Queue acceptance checks.

`EscalationQueue.accepts` is routing logic because it decides whether a request
matches a queue's configured admission shape.

### Authority-coupled semantics

- `backendGoverned`
- `clientOutcomeWritesAllowed`
- assignment ownership
- reviewer identity
- resolver identity
- audit link requirements
- policy reference requirements

These concepts imply decision authority, write authority, or enforcement
authority. They cannot be treated as package-owned facts.

### Orchestration-coupled semantics

- pending, assigned, in-review, resolved, rejected, and archived states
- fallback-loop handling
- assignment/review/resolution flow
- queue matching over lifecycle state

These concepts describe process movement. They are host/backend governance
concerns, not portable package behavior.

### Moderation-coupled semantics

- safety concern
- crisis risk
- policy violation
- safety review
- safety team visibility

These terms imply moderation ownership. A package may describe such facts only
after detox, but must not imply that it owns moderation operations.

### Emergency-governance-coupled semantics

- crisis risk
- emergency escalation
- crisis support
- `emergencyGuarantee`

Emergency semantics must remain carefully bounded. A package must not promise
emergency handling, emergency routing, emergency availability, or human response.

### Provider/runtime-adjacent semantics

- provider failure
- fallback loop
- backend governance markers
- runtime marker references
- provider restriction and compatibility checks

These concepts may describe diagnostic facts only after detox. They must not
claim provider causality or runtime enforcement from package code.

## Doctrine

The package may describe facts. The host/backend decides routing, enforcement,
emergency handling, provider causality, moderation ownership, assignment, review,
resolution, and outcome writes.
