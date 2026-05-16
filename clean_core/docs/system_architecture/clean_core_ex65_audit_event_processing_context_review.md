# EX-65 AuditEvent Processing Context Review

## Current Runtime Marker

The existing host-side `AuditEvent` depends on `AuditRuntimeMarker`. That marker remains host-side and must not be exposed as a package contract during the split.

## Package Replacement

`AuditProcessingContext` is available in `mental_smile_clean_core` as a label-only contract with:

- `processingModeLabel`
- `providerLabel`
- `policyReferenceLabel`
- `fallbackReasonLabel`

## Replacement Finding

`AuditProcessingContext` can replace the package model's need for `AuditRuntimeMarker` because it preserves passive audit context without carrying runtime lifecycle, provider authority, orchestration, or fallback approval semantics.

## Required Rule

Translation from host-side `AuditRuntimeMarker` into package-side `AuditProcessingContext` must remain mapper-owned and outside `mental_smile_clean_core`.

## Verdict

Processing-context strategy is approved for future split execution.
