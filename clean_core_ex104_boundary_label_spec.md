# EX-104 Boundary Label Specification

## Governance Assertion Labels

| Final name | Meaning | Prohibited meaning | Caveat | Status |
| --- | --- | --- | --- | --- |
| `backend_governance_asserted` | An external source asserted backend governance context. | Package proof of backend enforcement. | Externally asserted label only. | Needs future redesign |
| `policy_reference_present` | A policy reference value is present. | Policy enforcement, policy validity, or compliance proof. | Passive metadata only. | Package-safe |
| `audit_reference_present` | An audit reference value is present. | Audit enforcement, audit validity, or trace verification. | Passive metadata only. | Package-safe |
| `review_boundary_observed` | A review boundary label was observed. | Routing, admission, enforcement, or ownership. | Passive metadata only. | Package-safe |

## Host/Backend Write Policy Labels

| Final name | Meaning | Prohibited meaning | Caveat | Status |
| --- | --- | --- | --- | --- |
| `outcome_write_policy_external` | An external policy may exist for outcome writes. | Client write permission or package authority. | Package must not grant writes. | Host-only |
| `assignment_record_external` | An external assignment record exists. | Assignment authority or team ownership. | Externally asserted label only. | Host-only |
| `reviewer_record_external` | An external reviewer record exists. | Reviewer authority or active handling guarantee. | Externally asserted label only. | Host-only |
| `resolver_record_external` | An external resolver record exists. | Resolution authority. | Externally asserted label only. | Host-only |
| `outcome_record_external` | An external outcome record exists. | Outcome write permission or package validation. | Externally asserted label only. | Host-only |

## Emergency Posture Labels

| Final name | Meaning | Prohibited meaning | Caveat | Status |
| --- | --- | --- | --- | --- |
| `emergency_capability_not_guaranteed` | The package does not guarantee emergency capability. | Emergency response, emergency routing, or human availability. | Negative posture only. | Package-safe |
| `emergency_support_guidance_present` | Emergency-related support guidance text or reference is present. | Emergency intervention or service-level response. | Emergency posture caveat required. | Package-safe |
| `human_support_encouraged` | Human support is encouraged. | Human support availability or assignment. | Passive guidance only. | Package-safe |

## Blocked Boundary Vocabulary

- `emergencyGuarantee`
- `clientOutcomeWritesAllowed`
- `backendGoverned` as package proof
- `emergency_guaranteed`
- `client_can_resolve`
- `client_can_write_outcome`
- `backend_enforced`
- `verified_backend_governance`

## Boundary Verdict

Boundary vocabulary can be package-safe only as passive labels or negative safety
posture. Enforcement, writes, emergency guarantees, and proof claims remain
host/backend-owned.
