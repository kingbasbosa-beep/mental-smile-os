# EX-101 Boundary Semantic Risk Map

## Core Finding

`EscalationBoundaryMarker` exposure is blocked in current form.

The marker contains governance flags that look simple but imply enforcement,
write authority, and emergency capability:

- `backendGoverned`
- `clientOutcomeWritesAllowed`
- `emergencyGuarantee`

Because these are serialized as data, they can become fake guarantees unless
they are backed by host/backend enforcement.

## Risk Map

### `backendGoverned`

Risk: implies backend enforcement exists.

Doctrine: backend-only contract. A package must not self-attest that an action is
backend governed.

### `clientOutcomeWritesAllowed`

Risk: implies clients may write review outcomes or resolution results.

Doctrine: host/backend-only. This must not become package-facing authority.

### `emergencyGuarantee`

Risk: implies emergency handling is guaranteed.

Doctrine: must not become a package-facing promise. If represented at all, it
must remain a negative/passive safety marker rather than a capability claim.

## Decomposition Strategy

Boundary semantics can be decomposed into:

- passive provenance labels
- backend-enforced policy contracts
- host-only write policy
- emergency disclaimer/safety posture

Only passive labels are candidates for future package exposure. Enforcement and
write authority remain host/backend-owned.

## Doctrine

Boundary markers are not package guarantees. The package may describe facts only;
the host/backend decides enforcement, emergency handling, and outcome writes.
