# EX-104 Provider/Fallback Label Specification

## Provider Issue Report Labels

| Final name | Meaning | Prohibited meaning | Caveat | Status |
| --- | --- | --- | --- | --- |
| `provider_issue_reported` | An external source reported a provider-related issue. | Provider failure causality or package diagnosis. | Report only; no causality claim. | Package-safe |
| `provider_unavailable_reported` | An external source reported provider unavailability. | Verified outage or runtime proof. | Externally reported only. | Needs future redesign |
| `provider_policy_block_reported` | An external source reported a provider policy block. | Backend enforcement proof. | Externally reported only. | Needs future redesign |
| `provider_capability_gap_reported` | An external source reported a capability gap. | Verified provider capability state. | Externally reported only. | Package-safe |

## Fallback Observation Labels

| Final name | Meaning | Prohibited meaning | Caveat | Status |
| --- | --- | --- | --- | --- |
| `fallback_loop_observed` | A fallback loop condition was observed or reported. | Recovery, routing, or loop resolution. | Observation only; no recovery claim. | Package-safe |
| `fallback_only_mode_reported` | An external source reported fallback-only mode. | Runtime enforcement proof. | Externally reported only. | Needs future redesign |
| `fallback_recommended_label` | Fallback was recommended as posture metadata. | Fallback route activation or recovery. | Recommendation only; no route activation. | Package-safe |
| `fail_safe_posture_label` | A fail-safe posture label is present. | Emergency response or backend intervention. | Passive posture only. | Package-safe |

## Blocked Provider/Fallback Vocabulary

- `provider_failure_confirmed`
- `provider_caused_failure`
- `provider_escalated`
- `provider_runtime_verified`
- `fallback_recovered`
- `fallback_route_accepted`
- `fallback_loop_resolved`
- `runtime_enforced`

## Provider/Fallback Verdict

Provider and fallback vocabulary is package-safe only when it reports or observes
conditions. It must not diagnose provider causality, prove runtime enforcement,
activate fallback routing, or claim recovery.
