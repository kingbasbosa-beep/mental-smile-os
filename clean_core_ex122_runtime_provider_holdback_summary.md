# EX-122 Runtime/Provider Holdback Summary

## Scope

Docs/report only. This document summarizes runtime/provider diagnostic
holdbacks after EX-113 through EX-121.

## Safe Overlap

The only safe public overlap remains the existing `PassiveReviewSignal`
reference labels:

- `auditReferencePresent`
- `policyReferencePresent`

These labels indicate reference presence only. They do not prove audit
validity, policy validity, backend enforcement, telemetry correctness, runtime
execution, or provider behavior.

## Diagnostic Holdbacks

The following remain held back:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

## Holdback Rationale

`providerIssueReported` can be misused as provider causality proof.
`providerCapabilityGapObserved` can be misused as provider ability or trust
proof. `fallbackLoopObserved` and `fallbackOnlyModeObserved` can be misused as
fallback execution or recovery signals. `runtimeDisabledObserved` can be
misused as runtime state proof. `backendUnavailableObserved` can be misused as
backend enforcement or availability proof.

## Why No New Package Surface Was Justified

The only low-risk overlap already exists in `PassiveReviewSignal`. Additional
runtime/provider labels would create a new public surface near execution,
provider causality, fallback, backend availability, and runtime state. The wave
therefore found no justification for new files, exports, mappers, or consumer
connections.

## Summary Verdict

Holdbacks remain active. Future use must begin as host-only or backend-only
design unless a separate wave proves a label is passive, caveated,
non-authoritative, and not prone to execution or causality misuse.
