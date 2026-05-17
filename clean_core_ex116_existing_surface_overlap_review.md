# EX-116 Existing Surface Overlap Review

## Existing Public Surface

`PassiveReviewSignal` already exposes:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

## Overlap With EX-116 Labels

Already covered:

- `auditReferencePresent`
- `policyReferencePresent`

Not covered:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

## Overlap Finding

No new package file is justified for `auditReferencePresent` or
`policyReferencePresent` because the existing public surface already covers
them with caveats.

## Surface Verdict

The existing public surface is sufficient for reference-presence labels. All
non-reference diagnostics remain outside the public surface.
