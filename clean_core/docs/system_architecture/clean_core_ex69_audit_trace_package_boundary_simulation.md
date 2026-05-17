# EX-69 AuditTrace Package Boundary Simulation

## Package-Safe Fields

The following concepts are package-safe if represented as declarative data only:

- `traceId`
- `traceHash`
- `policyVersion`
- `references`
- `sanitizedPreview`
- `createdAt`
- `processingContext`

## Required Package Substitutions

The future package model should use:

- package `AuditReference` for `references`
- package `AuditProcessingContext` for runtime/provider context labels
- `DateTime?` for `createdAt`

It must not use:

- `AuditRuntimeMarker`
- `Timestamp`
- `FieldValue`
- `cloud_firestore`
- `toMap`
- `fromMap`

## Semantic Caveats

- `traceHash` is metadata unless verified by a backend-owned integrity system.
- `policyVersion` is a label/reference only and does not prove enforcement.
- `sanitizedPreview` is not a security boundary.
- `references` are metadata only.
- `processingContext` does not prove execution, provider guarantees, orchestration ownership, or fallback approval.

## Package Boundary Verdict

A package-safe pure `AuditTrace` model is viable with caveats.
