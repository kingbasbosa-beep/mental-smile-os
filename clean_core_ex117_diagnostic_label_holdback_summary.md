# EX-117 Diagnostic Label Holdback Summary

## Holdback List

| Label | Reason |
| --- | --- |
| `providerIssueReported` | Can imply provider fault, outage, causality, or backend adjudication. |
| `providerCapabilityGapObserved` | Can imply provider capability proof, inability proof, or compatibility verdict. |
| `fallbackLoopObserved` | Can imply recovery need, retry, route activation, or runtime failure. |
| `fallbackOnlyModeObserved` | Can imply active runtime mode, fallback enforcement, or fallback availability. |
| `runtimeDisabledObserved` | Can imply verified runtime state, execution guarantee, or backend proof. |
| `backendUnavailableObserved` | Can imply backend outage proof, backend causality, or enforcement state. |

## Caveat Specification Summary

Frozen caveat:

> This diagnostic label is passive metadata only. It reports, observes, or marks
> presence of a condition. It does not prove provider causality, provider trust,
> runtime execution state, backend enforcement, telemetry/privacy validity,
> retry, recovery, fallback execution, adapter execution, moderation/safety
> ownership, or emergency handling.

## Naming Freeze Summary

Names are frozen as soft diagnostics. They must not be strengthened to:

- confirmed
- proven
- failed
- detected
- resolved
- active
- verified
- valid
- enforced

## Holdback Verdict

No holdback label should be exported or introduced as a package contract yet.
