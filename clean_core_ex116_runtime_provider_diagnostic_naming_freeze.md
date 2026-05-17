# EX-116 Runtime/Provider Diagnostic Naming Freeze

## Scope

Review/docs only. This document freezes diagnostic names and caveat status
before any runtime/provider package introduction. It does not modify
runtime/source files, create package contracts, create mappers, export files,
reconnect consumers, migrate imports, run pub get/analyze, or activate
providers, adapters, Firebase, or runtime execution.

## Frozen Names

| Label | Naming status | Reason |
| --- | --- | --- |
| `providerIssueReported` | Frozen | Uses reported, not confirmed/failed. |
| `providerCapabilityGapObserved` | Frozen | Uses observed, not missing/proven. |
| `fallbackLoopObserved` | Frozen | Uses observed, not detected/resolved. |
| `fallbackOnlyModeObserved` | Frozen | Uses observed, not active/enforced. |
| `runtimeDisabledObserved` | Frozen | Uses observed, not verified. |
| `backendUnavailableObserved` | Frozen | Uses observed, not confirmed. |
| `auditReferencePresent` | Already frozen in public surface | Uses present, not verified. |
| `policyReferencePresent` | Already frozen in public surface | Uses present, not enforced/valid. |

## Names That Must Not Be Used

- `providerFailureConfirmed`
- `providerCapabilityMissing`
- `fallbackLoopDetected`
- `fallbackLoopResolved`
- `fallbackOnlyModeActive`
- `runtimeDisabledVerified`
- `backendUnavailableConfirmed`
- `auditReferenceVerified`
- `policyReferenceValid`

## Naming Verdict

All reviewed names are acceptable as soft diagnostic labels. Naming freeze does
not imply package introduction approval.
