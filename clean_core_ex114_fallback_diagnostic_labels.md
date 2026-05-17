# EX-114 Fallback Diagnostic Labels

## Candidate Review

| Candidate | Decision | Rationale | Required caveat |
| --- | --- | --- | --- |
| `fallbackLoopObserved` | Needs stronger caveats | Can imply routing loop, recovery need, or runtime failure. | Observation only; no recovery, retry, route activation, or execution guarantee. |
| `fallbackOnlyModeObserved` | Needs stronger caveats | Can imply active fallback runtime and fallback availability. | Observation/report only; no fallback execution guarantee. |
| `runtimeDisabledObserved` | Needs stronger caveats | Can imply runtime proof. | Observation/report only; no backend verification. |
| `backendUnavailableObserved` | Needs stronger caveats | Can imply backend outage. | Observation/report only; no backend causality. |

## Blocked Fallback Meanings

- fallback recovered
- fallback retry scheduled
- fallback route activated
- fallback response guaranteed
- fallback loop resolved
- runtime recovered
- backend recovered
- provider recovered

## Retry/Recovery Doctrine

Retry and recovery are execution semantics. They must remain host/backend-owned
and must not be represented as package-level public diagnostic capability.

## Fallback Verdict

Fallback diagnostic labels are metadata-only candidates, not package-safe yet.
They need stronger caveats and likely a separate holdback period.
