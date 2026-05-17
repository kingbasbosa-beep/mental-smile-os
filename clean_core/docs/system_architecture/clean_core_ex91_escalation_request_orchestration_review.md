# EX-91 EscalationRequest Orchestration Review

## Orchestration-Adjacent Concepts

Reviewed concepts:

- `providerFailure`
- `fallbackLoop`
- `urgent`
- `backendOnly`
- `safeDefault`
- `backendGoverned`
- `clientOutcomeWritesAllowed`
- `emergencyGuarantee`

## Provider/Runtime Risk

`providerFailure` and `fallbackLoop` are already package-safe as passive reason labels, but when combined with request creation they may imply provider/runtime causality. Future request docs must repeat that reason labels are metadata only.

## Boundary Marker Risk

`EscalationBoundaryMarker` is the strongest orchestration risk:

- `backendGoverned` may imply backend execution guarantee.
- `clientOutcomeWritesAllowed` may imply write authority policy.
- `emergencyGuarantee` may imply emergency response guarantee.

## Orchestration Boundary

Future package model must not include orchestration ownership, provider lifecycle ownership, fallback execution, emergency handling, or backend action guarantees.

## Verdict

`EscalationRequest` is orchestration-adjacent and needs a dedicated semantic freeze/redesign before any additive split.
