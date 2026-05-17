# EX-117 Runtime/Provider Holdback Milestone

## Scope

Docs/report only. This milestone report documents the runtime/provider
diagnostic holdback decision after EX-113 through EX-116. It does not modify
runtime/source files, create package contracts, create mappers, export files,
reconnect consumers, migrate imports, run pub get/analyze, or activate
providers, adapters, Firebase, or runtime execution.

## Runtime/Provider Doctrine Map Summary

Runtime/provider concepts are higher risk than passive review vocabulary because
they can imply:

- AI execution
- adapter execution
- runtime permission
- provider trust
- provider capability
- provider causality
- fallback recovery
- backend enforcement
- telemetry/privacy proof
- safety/moderation ownership

## Holdback Decision

The following remain holdback:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

## Existing Safe Overlap

Already public via `PassiveReviewSignal`:

- `auditReferencePresent`
- `policyReferencePresent`

No new package surface is justified for those labels.

## Milestone Finding

Runtime/provider diagnostic package introduction remains blocked. The wave
successfully froze names and caveats without creating new public contracts.
