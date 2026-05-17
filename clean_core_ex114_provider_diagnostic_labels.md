# EX-114 Provider Diagnostic Labels

## Candidate Review

| Candidate | Decision | Rationale | Required caveat |
| --- | --- | --- | --- |
| `providerIssueReported` | Needs stronger caveats | Safe only as an external report; can imply provider fault. | Report only; no provider causality, outage proof, trust proof, or runtime diagnosis. |
| `providerCapabilityGapObserved` | Needs stronger caveats | Safer than "blocked" or "failed", but can imply verified capability. | Observation only; no proof of provider ability or inability. |
| `auditReferencePresent` | Package-safe | Already public as passive reference presence. | Reference only; no audit verification, trace validity, or telemetry proof. |
| `policyReferencePresent` | Package-safe | Already public as passive reference presence. | Reference only; no policy validity, enforcement, or compliance proof. |

## Provider Terms That Remain Blocked

- provider caused failure
- provider failed
- provider verified unavailable
- provider trusted
- provider approved
- provider compatible
- provider can execute
- provider can moderate
- provider can handle crisis
- provider escalation active

## Provider Doctrine

Provider diagnostics can describe externally reported facts only. They must not
declare why a provider failed, whether a provider is trustworthy, whether a
provider actually supports a capability, or whether backend/provider governance
approved execution.

## Provider Verdict

Only `auditReferencePresent` and `policyReferencePresent` are package-safe now.
Provider issue/capability labels need stronger caveats before any public
surface.
