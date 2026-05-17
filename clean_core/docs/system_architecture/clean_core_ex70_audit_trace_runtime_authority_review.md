# EX-70 AuditTrace Runtime Authority Review

## Current Runtime Source

Current `clean_core/lib/core/audit/audit_trace.dart` uses host-side `AuditRuntimeMarker`.

## Translation Boundary

Future package `AuditTrace` must use `AuditProcessingContext`, not `AuditRuntimeMarker`.

Allowed translation remains host-side only:

- `runtimeMode` -> `processingModeLabel`
- `providerId` -> `providerLabel`
- `policyVersion` -> `policyReferenceLabel`
- `fallbackReason` -> `fallbackReasonLabel`

## Prohibited Semantics

The package model must not imply:

- runtime execution
- orchestration ownership
- provider ownership
- provider execution
- fallback approval
- backend guarantees
- observability activation
- lifecycle authority

## Finding

No runtime authority semantics are allowed to survive translation. `AuditProcessingContext` remains metadata-only and label-only.
