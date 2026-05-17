# EX-101 Queue/Boundary Exposure Strategy

## Exposure Verdicts

### Queue exposure

Blocked in current form.

Reasons:

- `EscalationQueue.accepts` is routing/policy/orchestration logic.
- Queue fields imply operational routing.
- Visibility scope implies moderation ownership.
- Allowed states imply lifecycle authority.
- Accepted priorities can imply service-level handling.

### Boundary marker exposure

Blocked in current form.

Reasons:

- `backendGoverned` is an enforcement claim.
- `clientOutcomeWritesAllowed` is write-authority policy.
- `emergencyGuarantee` can create a false emergency promise.

### Request/review/resolution contracts

Host-only in current form when connected to assignment, review, resolution,
Firestore, server timestamps, policy snapshots, audit traces, or outcome writes.

### Firestore mappers

Permanently host-only unless redesigned as backend-internal infrastructure. They
must not become package contracts.

## Future Package-Safe Path

Potentially package-safe concepts:

- detoxed reason labels
- detoxed priority labels
- passive lifecycle labels
- non-authoritative audit references
- non-authoritative policy reference metadata

Blocked or host/backend-only concepts:

- queue acceptance
- queue routing
- assignment
- review ownership
- resolution ownership
- outcome writes
- backend enforcement
- emergency handling guarantees
- provider/runtime causality

## Doctrine Direction

Future package exposure should be redesign-first and metadata-only. Backend-only
semantics stay backend-only forever. The package may describe facts only; the
host/backend decides routing, enforcement, emergency handling, provider
causality, and outcome writes.
