# EX-68 AuditTrace Firestore Runtime Risk

## Firestore Coupling

`audit_trace.dart` contains:

- `cloud_firestore` import
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate`
- Firestore field names in `toMap`
- nested reference serialization through `reference.toMap()`
- runtime marker serialization through `runtimeMarker.toMap()`

## Runtime/Provider Semantics

`AuditTrace` carries `AuditRuntimeMarker`, which contains runtime and provider labels. The current file does not execute provider behavior, but package exposure of the marker would blur runtime ownership.

## Observability Risk

`AuditTrace` is adjacent to observability concepts and shares dependencies with `safety_observability_contract.dart`. Movement or reconnect should avoid observability activation and should not imply telemetry/runtime execution.

## Risk Classification

- Firestore-coupled: yes
- Runtime-marker coupled: yes
- Provider-label adjacent: yes
- Observability adjacent: yes
- Runtime executing: no direct execution found
- Package-safe as-is: no

## Stop Conditions

Stop future execution if the split requires direct movement, package Firestore imports, package exposure of `AuditRuntimeMarker`, observability activation, provider execution, or reconnect.
