# EX-115 Runtime/Provider Diagnostic Caveat Spec

## Scope

Docs/spec only. This specification defines caveats and public meaning boundaries
for runtime/provider passive diagnostic labels. It does not modify runtime/source
files, create package contracts, create mappers, export files, reconnect
consumers, migrate imports, run pub get/analyze, or activate providers,
adapters, Firebase, or runtime execution.

## Final Shared Caveat Text

> This diagnostic label is passive metadata only. It reports, observes, or marks
> presence of a condition. It does not prove provider causality, provider trust,
> runtime execution state, backend enforcement, telemetry/privacy validity,
> retry, recovery, fallback execution, adapter execution, moderation/safety
> ownership, or emergency handling.

## Candidate Caveat Matrix

| Label | Public meaning | Prohibited meaning | Status |
| --- | --- | --- | --- |
| `providerIssueReported` | A provider-related issue was reported. | Provider fault, outage proof, causality, trust proof, runtime diagnosis. | Holdback |
| `providerCapabilityGapObserved` | A provider capability gap was observed or reported. | Capability proof, provider inability proof, compatibility verdict. | Holdback |
| `fallbackLoopObserved` | A fallback loop condition was observed. | Recovery need, recovery completion, retry, route activation. | Holdback |
| `fallbackOnlyModeObserved` | Fallback-only mode was observed or reported. | Runtime enforcement proof, fallback availability, execution mode proof. | Holdback |
| `runtimeDisabledObserved` | Runtime-disabled condition was observed or reported. | Verified runtime state, execution guarantee, backend proof. | Holdback |
| `backendUnavailableObserved` | Backend-unavailable condition was observed or reported. | Backend outage proof, backend causality, enforcement state. | Holdback |
| `auditReferencePresent` | An audit reference value is present. | Audit verification, trace validity, telemetry/privacy proof. | Safe with caveat |
| `policyReferencePresent` | A policy reference value is present. | Policy validity, compliance proof, backend enforcement. | Safe with caveat |

## Public Misuse Warning

Consumers must not use diagnostic labels to:

- select providers
- infer provider failure
- infer provider trust
- route runtime work
- activate retry or recovery
- decide fallback behavior
- prove backend enforcement
- prove telemetry/privacy state
- grant client execution permission
- claim moderation/safety ownership

## Spec Verdict

Reference-presence labels remain safe. Non-reference runtime/provider diagnostic
labels remain holdbacks until a later export readiness review.
