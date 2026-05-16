# EX-62 Audit Event Dependency Readiness

Phase: EX-62 - Audit Dependency Vocabulary Review

## audit_event Dependency Set

`audit_event.dart` depends on:

- `AuditActorType`
- `AuditEventType`
- `AuditReference`
- `AuditRuntimeMarker`
- `AuditSeverity`
- `AuditVisibilityScope`

## Package-Safe Dependencies

Safe with caveats:

- `AuditActorType`
- `AuditEventType`
- `AuditSeverity`
- `AuditVisibilityScope`
- `AuditReference`

Already package-safe replacement exists for runtime marker strategy:

- `AuditProcessingContext`

## Compatibility Strategy

Additive compatibility remains possible:

- keep existing host-side `audit_event.dart`
- introduce future package event model
- use mapper to translate host-side marker and references
- avoid reconnect during split

## Remaining Readiness Gap

Before `audit_event` split execution:

- decide whether audit vocabulary contracts are moved/exported first
- or represent them as package-local labels/strings in the future package event
- decide how `AuditReference` map serialization is owned

## Readiness Finding

The dependency vocabulary no longer blocks `audit_event` conceptually, but export/mapping decisions are still required before execution.

