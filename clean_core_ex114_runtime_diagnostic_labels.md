# EX-114 Runtime Diagnostic Labels

## Candidate Review

| Candidate | Decision | Rationale | Required caveat |
| --- | --- | --- | --- |
| `runtimeDisabledObserved` | Needs stronger caveats | Can imply actual runtime state. | Observation/report only; no runtime proof or execution guarantee. |
| `backendUnavailableObserved` | Needs stronger caveats | Can imply backend outage proof. | Observation/report only; no backend diagnosis or enforcement proof. |
| `fallbackOnlyModeObserved` | Needs stronger caveats | Can imply active runtime mode and fallback behavior. | Observation/report only; no runtime enforcement or fallback guarantee. |
| `auditReferencePresent` | Package-safe | Passive reference presence only. | No audit verification or telemetry proof. |
| `policyReferencePresent` | Package-safe | Passive reference presence only. | No policy enforcement or compliance proof. |

## Runtime Concepts That Remain Host/Backend-Only

- `aiEnabled`
- `fallbackOnlyMode`
- `runtimeMode`
- allowed provider IDs
- blocked provider IDs
- `backendGoverned`
- runtime locks
- runtime guard decisions
- runtime execution boundary
- request/response/result authority

## Runtime Concepts That Remain Blocked

- runtime execution guarantees
- AI completion guarantees
- adapter execution proof
- client-side runtime permission
- backend enforcement proof
- telemetry/privacy proof

## Runtime Verdict

Runtime-state diagnostic labels are not package-safe yet. They may become
metadata-only after caveat specification and naming freeze.
