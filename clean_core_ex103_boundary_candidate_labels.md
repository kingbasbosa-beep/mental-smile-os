# EX-103 Boundary Candidate Labels

## Governance Assertion Labels

| Current concept | Candidate passive label | Decision | Required caveat |
| --- | --- | --- | --- |
| `backendGoverned` | `backend_governance_asserted` | Needs detox caveat | Externally asserted only; no package enforcement proof. |
| policy reference present | `policy_reference_present` | Package-safe after detox | Reference only; no policy enforcement claim. |
| audit reference present | `audit_reference_present` | Package-safe after detox | Reference only; no audit enforcement claim. |
| review boundary present | `review_boundary_observed` | Package-safe after detox | Boundary label only; no routing/enforcement claim. |

## Host/Backend Write Policy Labels

| Current concept | Candidate passive label | Decision | Required caveat |
| --- | --- | --- | --- |
| `clientOutcomeWritesAllowed` | `outcome_write_policy_external` | Host/backend-only forever | Package must not grant outcome write authority. |
| assignment writer identity | `assignment_record_external` | Host/backend-only forever | Assignment writes are not package-owned. |
| reviewer identity | `reviewer_record_external` | Host/backend-only forever | Reviewer ownership is not package-owned. |
| resolver identity | `resolver_record_external` | Host/backend-only forever | Resolution ownership is not package-owned. |
| outcome key | `outcome_record_external` | Host/backend-only unless read-only | Outcome meaning is backend/host-owned. |

## Emergency Posture Labels

| Current concept | Candidate passive label | Decision | Required caveat |
| --- | --- | --- | --- |
| `emergencyGuarantee` | blocked | Blocked | Must not become a package-facing promise. |
| no emergency guarantee | `emergency_capability_not_guaranteed` | Package-safe | Negative posture only. |
| crisis risk | `crisis_risk_observed` | Needs detox caveat | No emergency routing or human response guarantee. |
| emergency guidance present | `emergency_support_guidance_present` | Package-safe after detox | Guidance presence only; no response guarantee. |
| human support encouraged | `human_support_encouraged` | Package-safe after detox | Encouragement only; no availability guarantee. |

## Boundary Finding

Boundary labels can become package-safe only when they describe external facts or
negative safety posture. Enforcement, writes, and emergency guarantees remain
host/backend-owned.
