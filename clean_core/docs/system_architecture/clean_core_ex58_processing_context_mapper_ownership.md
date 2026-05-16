# EX-58 Processing Context Mapper Ownership

Phase: EX-58 - AuditProcessingContext Pre-Execution Approval

## Mapper Ownership

Host/backend mapper owns translation from host-side `AuditRuntimeMarker` into package-safe `AuditProcessingContext`.

## Package Contract Ownership

The package owns only:

- field names
- label storage
- declarative value shape

The package does not own:

- runtime verification
- provider verification
- fallback approval
- policy enforcement
- backend authority
- observability execution

## Translation Boundary

Translation is a copy/label mapping:

- `runtimeMode` -> `processingModeLabel`
- `providerId` -> `providerLabel`
- `policyVersion` -> `policyReferenceLabel`
- `fallbackReason` -> `fallbackReasonLabel`

## Mapper Ownership Finding

Mapper ownership remains host/backend-side. The package contract remains passive.

