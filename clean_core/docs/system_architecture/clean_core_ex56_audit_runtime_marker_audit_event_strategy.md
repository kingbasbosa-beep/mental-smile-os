# EX-56 AuditRuntimeMarker audit_event Strategy

Phase: EX-56 - AuditRuntimeMarker Package Exposure Simulation

## audit_event Dependency

`audit_event.dart` currently contains:

- `AuditRuntimeMarker runtimeMarker`

This dependency affects the future pure `AuditEvent` package model.

## Strategy A - Use Public Marker Type

If `AuditRuntimeMarker` is exported, the package `AuditEvent` can keep a typed runtime marker.

Risk:

- public package surface gains runtime-sensitive vocabulary.

## Strategy B - Use Package-Safe Marker Type

Create a renamed package-safe marker, for example:

- `AuditRuntimeContext`
- `AuditRuntimeLabel`
- `AuditRuntimeReference`

Risk:

- requires mapping from host marker to package marker.

## Strategy C - Flatten to Primitive Fields

Package `AuditEvent` could use:

- `runtimeMode`
- `providerId`
- `runtimePolicyVersion`
- `fallbackReason`

Risk:

- spreads runtime-sensitive labels across the event model.

## Strategy D - Omit Runtime Marker From First Pure Event Model

Package `AuditEvent` could initially omit runtime marker.

Risk:

- loses current audit context and requires mapper compatibility decisions.

## audit_event Strategy Finding

Best strategy for `audit_event` is a package-safe marker type with clearer label-only naming, rather than exporting `AuditRuntimeMarker` as-is.

