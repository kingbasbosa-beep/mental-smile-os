# EX-112 Queue/Boundary Containment Summary

## Queue/Routing/Orchestration Doctrine

`EscalationQueue.accepts` remains blocked. It is routing, policy, and
orchestration logic, not metadata.

Blocked queue concepts:

- accepts predicates
- queue admission
- queue matching
- queue routing
- assignment authority
- review ownership
- resolution ownership
- moderation/team ownership
- outcome write authority

Allowed queue doctrine:

- package may describe passive facts
- host/backend decides routing
- host/backend decides admission
- host/backend decides assignment/review/resolution

## Boundary/Governance Doctrine

Boundary flags can imply authority even when represented as booleans.

Blocked or host/backend-owned concepts:

- `backendGoverned` as package proof
- `clientOutcomeWritesAllowed`
- backend enforcement claims
- governance/write mappers
- audit enforcement claims
- policy compliance proof

Allowed boundary doctrine:

- passive reference presence can be public when caveated
- enforcement remains host/backend-owned
- write authority remains host/backend-owned

## Emergency Semantics Doctrine

Emergency language must not create false safety certainty.

Blocked:

- emergency guarantees
- emergency routing promises
- human availability promises
- provider escalation promises
- service-level timing promises

Allowed:

- negative posture: `emergencyCapabilityNotGuaranteed`

## Provider/Fallback Causality Doctrine

Provider/fallback labels are high-risk because consumers may infer causality or
recovery.

Internal-only for now:

- `providerIssueReported`
- `fallbackLoopObserved`

Blocked:

- provider causality claims
- runtime enforcement claims
- fallback recovery claims
- fallback routing claims

## Containment Verdict

The containment doctrine holds: package labels describe facts only; host/backend
owns execution and authority.
