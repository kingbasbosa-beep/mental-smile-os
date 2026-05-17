# EX-103 Queue Candidate Labels

## Queue Intent Labels

| Current concept | Candidate passive label | Decision | Required caveat |
| --- | --- | --- | --- |
| `safetyConcern` | `safety_concern_observed` | Package-safe after detox | Observation only; no moderation ownership. |
| `crisisRisk` | `crisis_risk_observed` | Needs detox caveats | Observation only; no emergency handling guarantee. |
| `policyViolation` | `policy_issue_observed` | Needs renaming | Avoid declaring violation as fact unless backend adjudicates. |
| `manualSupportRequest` | `manual_support_requested` | Package-safe after detox | Request label only; no support availability claim. |
| `providerFailure` | `provider_issue_reported` | Needs renaming and detox | Report only; no provider causality claim. |
| `fallbackLoop` | `fallback_loop_observed` | Needs renaming and detox | Observation only; no recovery or routing claim. |

## Queue Priority Labels

| Current concept | Candidate passive label | Decision | Required caveat |
| --- | --- | --- | --- |
| `low` | `review_priority_low` | Package-safe | Display priority only; no SLA. |
| `medium` | `review_priority_medium` | Package-safe | Display priority only; no SLA. |
| `high` | `review_priority_high` | Needs detox caveat | No urgent handling guarantee. |
| `urgent` | `review_priority_urgent` | Needs detox caveat | No emergency, human, or timing guarantee. |

## Queue Lifecycle Labels

| Current concept | Candidate passive label | Decision | Required caveat |
| --- | --- | --- | --- |
| `pendingReview` | `review_state_pending` | Package-safe after detox | State label only; no queue admission. |
| `assigned` | `review_state_assignment_recorded` | Needs renaming | Assignment must be externally asserted. |
| `inReview` | `review_state_in_review_reported` | Needs detox caveat | No reviewer availability guarantee. |
| `resolved` | `review_state_resolution_recorded` | Host/backend-only unless read-only | Resolution authority is not package-owned. |
| `rejected` | `review_state_rejection_recorded` | Host/backend-only unless read-only | Outcome authority is not package-owned. |
| `archived` | `review_state_archived_recorded` | Host/backend-only unless read-only | Archive transition is not package-owned. |

## Queue Visibility Labels

| Current concept | Candidate passive label | Decision | Required caveat |
| --- | --- | --- | --- |
| `restricted` | `visibility_restricted_label` | Package-safe after detox | Display label only; no access enforcement claim. |
| `safetyTeam` | `visibility_safety_review_label` | Needs renaming | No team ownership or staffing guarantee. |
| `auditOnly` | `visibility_audit_reference_label` | Needs detox caveat | No audit enforcement guarantee. |
| `backendOnly` | `visibility_backend_policy_label` | Backend-only unless externally asserted | No package access-control claim. |

## Blocked Queue Concepts

- `EscalationQueue.accepts`
- `acceptedReasons`
- `acceptedPriorities`
- `allowedStates`
- queue admission
- queue matching
- queue routing
- queue ownership
- team notification
- team handling

## Queue Finding

Queue labels can become package-safe only when they are passive and
non-authoritative. Any predicate or field that decides acceptance, routing, or
ownership remains blocked.
