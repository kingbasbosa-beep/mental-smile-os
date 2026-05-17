# EX-114 Candidate Ranking

## Package-Safe Now

- `auditReferencePresent`
- `policyReferencePresent`

Reason: these are already public as low-risk passive reference labels and do not
claim runtime execution, provider causality, fallback recovery, or backend
enforcement when caveated.

## Needs Stronger Caveats

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

Required caveat:

> This diagnostic label is passive metadata only. It reports or observes a
> condition; it does not prove provider causality, provider trust, runtime
> execution state, backend enforcement, telemetry/privacy validity, retry,
> recovery, fallback execution, adapter execution, or safety/moderation
> ownership.

## Needs Rename

No reviewed candidate requires immediate renaming, but the following names must
not be strengthened:

- do not rename `providerIssueReported` to `providerFailureConfirmed`
- do not rename `providerCapabilityGapObserved` to `providerCapabilityMissing`
- do not rename `fallbackLoopObserved` to `fallbackLoopDetected`
- do not rename `backendUnavailableObserved` to `backendUnavailableConfirmed`

## Host-Only

- runtime display state derived from host configuration
- UI messaging around fallback-only mode
- client-visible support copy around disabled runtime

## Backend-Only

- provider trust proof
- provider compatibility proof
- backend governance enforcement
- runtime execution permission
- telemetry/privacy verification
- audit trace verification

## Blocked

- adapter execution proof
- runtime execution guarantees
- AI completion guarantees
- provider causality claims
- retry/recovery guarantees
- fallback recovery claims
- moderation/safety ownership
- crisis/escalation ownership
- runtime/provider mappers as public contracts
