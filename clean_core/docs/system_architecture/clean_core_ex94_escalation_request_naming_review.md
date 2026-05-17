# EX-94 EscalationRequest Naming Review

## Options Reviewed

### `EscalationRequest`

Benefits:

- Matches the existing host compatibility type name.
- Matches the prior additive split pattern for assignment, review, and resolution.
- Keeps the public package surface predictable.

Risks:

- May imply escalation initiation or execution authority.
- Requires strong caveats to remain metadata-only.

### `EscalationRequestMetadata`

Benefits:

- Reduces initiation-authority ambiguity.
- Makes metadata-only semantics explicit.

Risks:

- Diverges from the established package naming pattern.
- Creates future mapping friction between host compatibility type and package type.
- May invite duplicate conceptual models instead of a clean additive split.

## Naming Decision

Use `EscalationRequest`.

## Required Caveats

The package model must state that request metadata does not initiate escalation execution, approve, route, schedule, execute, own, or guarantee escalation handling.

## Naming Verdict

`EscalationRequest` is approved for future execution only with explicit metadata-only caveats.
