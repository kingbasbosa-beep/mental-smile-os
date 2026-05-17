# EX-88 EscalationResolution Authority Detox

## Authority Risks

The current vocabulary can be misread as granting or proving authority:

- `resolvedBy` may sound like authorized resolver identity.
- `state` includes resolution-oriented values.
- `outcomeKey` may sound like a backend-approved outcome.
- `auditLink` may sound like validated audit proof.
- `resolvedAt` may sound like completion or finality.

## Required Detox Rules

- `resolvedBy` must remain a passive identifier label.
- `resolvedBy` must not prove resolver authorization, moderator status, or approval authority.
- `state` must not imply workflow progression, closure, or backend transition.
- `outcomeKey` must not imply policy enforcement, punishment, moderation effect, or backend action.
- `auditLink` must not imply audit persistence, integrity verification, or policy approval.
- `resolvedAt` must not imply backend execution, completion, closure, or finality.

## Prohibited Package Semantics

A package-safe model must not include:

- resolution authority
- approval authority
- enforcement guarantees
- policy guarantees
- backend ownership guarantees
- resolver authorization guarantees
- closure guarantees

## Authority Verdict

Approved for future package modeling only with explicit authority-detox caveats. Any enforcement, approval, or resolver authorization semantics must remain host/backend-owned.
