# EX-103 Provider/Fallback Candidate Labels

## Provider Issue Report Labels

| Current concept | Candidate passive label | Decision | Required caveat |
| --- | --- | --- | --- |
| `providerFailure` | `provider_issue_reported` | Needs renaming and detox | Report only; no provider failure causality claim. |
| provider unavailable | `provider_unavailable_reported` | Needs detox caveat | External report only; no package diagnosis. |
| provider blocked | `provider_policy_block_reported` | Needs detox caveat | Policy report only; backend decides enforcement. |
| provider capability unavailable | `provider_capability_gap_reported` | Needs detox caveat | Capability report only; no runtime proof. |

## Fallback Observation Labels

| Current concept | Candidate passive label | Decision | Required caveat |
| --- | --- | --- | --- |
| `fallbackLoop` | `fallback_loop_observed` | Needs renaming and detox | Observation only; no recovery claim. |
| fallback only mode | `fallback_only_mode_reported` | Needs detox caveat | Runtime report only; no enforcement claim. |
| fallback required | `fallback_recommended_label` | Needs detox caveat | Recommendation only; no route activation. |
| fail safe mode | `fail_safe_posture_label` | Package-safe after detox | Posture only; no emergency response guarantee. |

## Blocked Provider/Fallback Claims

- provider caused failure
- provider definitely failed
- provider escalation activated
- fallback recovery completed
- fallback route accepted
- fallback loop resolved
- runtime enforcement guaranteed
- backend provider governance guaranteed by package

## Provider/Fallback Finding

Provider and fallback labels are candidates only when converted from causality
claims into passive reports or observations. The host/backend decides actual
provider causality, runtime enforcement, fallback routing, and recovery.
