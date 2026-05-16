# EX-57 Runtime Context audit_event Usage

Phase: EX-57 - Package-Safe Runtime Context Design

## Future audit_event Pure Model Usage

Future package `AuditEvent` could include:

- `AuditProcessingContext processingContext`

or, if naming remains runtime-oriented:

- `AuditRuntimeContext runtimeContext`

## Preferred Usage

Preferred field:

- `processingContext`

Reason:

- avoids implying runtime activation
- reads as audit metadata
- groups provider/fallback/policy labels without making them authoritative

## Compatibility With Existing audit_event

Existing host-side `audit_event.dart` can continue using `AuditRuntimeMarker` during compatibility phase.

Future mapper can translate host-side marker into package-safe context.

## Usage Restrictions

`audit_event` pure model must not:

- evaluate context
- decide fallback
- infer provider execution
- trigger runtime
- perform observability action
- claim backend authority

## audit_event Usage Finding

Using a package-safe processing context unblocks future `audit_event` pure model design without exposing `AuditRuntimeMarker` as-is.

