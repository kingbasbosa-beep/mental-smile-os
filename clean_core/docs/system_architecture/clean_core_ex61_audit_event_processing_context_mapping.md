# EX-61 Audit Event Processing Context Mapping

Phase: EX-61 - audit_event Split Simulation V2

## Current Runtime Marker

Current host-side field:

- `AuditRuntimeMarker runtimeMarker`

Current marker fields:

- `runtimeMode`
- `providerId`
- `policyVersion`
- `fallbackReason`

## Future Package Context

Future package field:

- `AuditProcessingContext processingContext`

Future context fields:

- `processingModeLabel`
- `providerLabel`
- `policyReferenceLabel`
- `fallbackReasonLabel`

## Simulated Mapping

Host/backend mapper should translate:

- `runtimeMarker.runtimeMode` -> `processingContext.processingModeLabel`
- `runtimeMarker.providerId` -> `processingContext.providerLabel`
- `runtimeMarker.policyVersion` -> `processingContext.policyReferenceLabel`
- `runtimeMarker.fallbackReason` -> `processingContext.fallbackReasonLabel`

## Mapping Semantics

Mapping is label translation only.

It must not:

- prove runtime execution
- prove provider execution
- approve fallback
- enforce policy
- activate observability
- create backend guarantee

## Processing Context Finding

`AuditProcessingContext` removes the main runtime-marker naming blocker for the future package model.

