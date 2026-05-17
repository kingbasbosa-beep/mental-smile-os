# EX-117 Existing Surface Overlap Summary

## Existing Public Surface

`PassiveReviewSignal` already exposes:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

## Overlap With Runtime/Provider Diagnostics

Already covered:

- `auditReferencePresent`
- `policyReferencePresent`

Not covered and still held back:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

## Why No New Package Surface Is Justified

- the only safe reference labels already exist publicly
- non-reference diagnostics remain holdbacks
- public export of holdbacks would create consumer misuse risk
- no mappers, contracts, or consumers are needed
- runtime/provider execution remains out of scope

## Existing Surface Verdict

The current public surface is sufficient. No new runtime/provider package file
or export should be introduced.
