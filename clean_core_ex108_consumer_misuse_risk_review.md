# EX-108 Consumer Misuse Risk Review

## Misuse Risk

The main risk is not implementation behavior. The implementation is inert. The
risk is consumer interpretation once symbols are exported from the package
barrel.

## Potential Misuse Patterns

Consumers could misuse labels as:

- queue routing signals
- queue admission proof
- moderation/team assignment proof
- emergency workflow activation
- backend enforcement proof
- provider failure diagnosis
- fallback recovery state
- outcome write permission

## Label-Level Risk

| Label | Misuse risk | Required caveat before export |
| --- | --- | --- |
| `safetyConcernObserved` | Medium | Observation only; no moderation ownership. |
| `policyIssueObserved` | Low | Possible issue only; not adjudicated violation. |
| `manualSupportRequested` | Low | Request only; no availability or admission. |
| `reviewStatePending` | Medium | Pending label only; no guaranteed review. |
| `policyReferencePresent` | Low | Reference only; no enforcement. |
| `auditReferencePresent` | Low | Reference only; no verification. |
| `reviewBoundaryObserved` | Medium | Observed label only; no boundary enforcement. |
| `emergencyCapabilityNotGuaranteed` | Low | Negative posture only. |
| `providerIssueReported` | Medium | Report only; no provider causality. |
| `fallbackLoopObserved` | Medium | Observation only; no recovery or routing. |

## Consumer Guidance Requirement

Before export, consumer-facing docs must say:

> These labels are passive metadata only. They must not be used to route,
> admit, assign, enforce, guarantee emergency handling, infer provider
> causality, recover fallback loops, or grant write authority.

## Misuse Verdict

Misuse risk is manageable only for controlled export with explicit public
documentation. Without that documentation, export should remain blocked.
