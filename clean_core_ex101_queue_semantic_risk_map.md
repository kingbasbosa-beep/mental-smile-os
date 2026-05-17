# EX-101 Queue Semantic Risk Map

## Core Finding

`EscalationQueue.accepts` is routing, policy, and orchestration logic. It is not
metadata.

The method evaluates:

- escalation reason
- review priority
- escalation state

This makes the queue object more than a passive description. It encodes an
admission rule that can be mistaken for authoritative routing if exposed through
a package surface.

## Risk Map

### High-risk semantics

- `queueId`: can imply a real backend queue exists.
- `acceptedReasons`: can imply moderation ownership and routing capability.
- `acceptedPriorities`: can imply service-level handling priority.
- `visibleTo`: can imply real team visibility.
- `allowedStates`: can imply lifecycle authority.
- `accepts`: can imply actual queue admission.

### Reasons

- `safetyConcern`: moderation-coupled.
- `crisisRisk`: moderation- and emergency-governance-coupled.
- `policyViolation`: moderation- and policy-coupled.
- `providerFailure`: provider/runtime-adjacent.
- `fallbackLoop`: orchestration- and runtime-adjacent.
- `manualSupportRequest`: host workflow-coupled.

`providerFailure` and `fallbackLoop` are safe only as passive metadata after
detox. They must not trigger package-owned routing, provider diagnosis, runtime
claims, or fallback orchestration.

## Package Exposure Status

Queue exposure is blocked in current form.

Potentially safe future exposure requires redesign:

- Remove queue admission predicates from package-facing APIs.
- Rename operational concepts into passive labels where possible.
- Avoid team, route, queue, or ownership guarantees.
- Keep assignment/review/resolution authority host-only.
- Keep actual queue matching backend-owned.

## Doctrine

Queue concepts can become package-safe only as detoxed metadata. Package code may
describe review-related facts, but the host/backend decides routing and
orchestration.
