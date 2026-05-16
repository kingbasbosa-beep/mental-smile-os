# clean_core Audit Lane Runtime Flags

This document identifies runtime-sensitive audit lane concepts.

## Runtime-Sensitive Files

- `audit_runtime_marker.dart`
- `safety_observability_contract.dart`
- `audit_event_type.dart`
- `audit_event.dart`
- `audit_trace.dart`

## Runtime-Sensitive Fields

- `runtimeMode`
- `providerId`
- `fallbackReason`
- `policyVersion`
- `AuditEventType.runtimeDisabled`
- `AuditEventType.providerRejected`

## Runtime Safety Finding

These fields describe runtime state and provider status, but they do not activate runtime. They should be documented as observational/marker-only if exported later.

## Runtime Blockers

`audit_event.dart` and `audit_trace.dart` are additionally blocked by Firestore coupling. Their runtime markers should not be used as runtime authority.

## Runtime Verdict

Runtime-sensitive audit contracts may be extracted only as inert markers. No runtime bridge or telemetry pipeline should be inferred.
