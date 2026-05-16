# EX-61 Audit Event Remaining Risks

Phase: EX-61 - audit_event Split Simulation V2

## Risk Compared With audit_snapshot

`audit_event` remains higher risk than `audit_snapshot`.

Reasons:

- more fields
- nested list references
- actor identity fields
- runtime context mapping
- event/severity/visibility vocabulary
- privacy-sensitive sanitized preview
- policy version reference

## Remaining Blockers

Remaining blockers:

- package-safe audit reference strategy
- package-safe event/severity/actor/visibility vocabulary strategy
- nested reference serialization
- privacy review for actor id and sanitized preview
- authority review for actor type, policy version, and visibility scope

## Lowered Risk

The runtime-marker blocker is reduced because `AuditProcessingContext` now exists.

## Stop Conditions

Stop if:

- runtime execution semantics remain inseparable
- observability coupling becomes inseparable
- reconnect becomes required
- package gains backend/runtime authority
- compatibility cannot remain additive
- nested references cannot be mapped without package contamination

## Remaining Risk Finding

`audit_event` is now viable for future simulation toward execution, but not ready for immediate split execution.

