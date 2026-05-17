# EX-104 Queue Label Specification

## Queue Intent Labels

| Final name | Meaning | Prohibited meaning | Caveat | Status |
| --- | --- | --- | --- | --- |
| `safety_concern_observed` | A safety-related concern was observed or reported. | Moderation ownership, safety-team handling, routing, or admission. | Passive metadata only. | Package-safe |
| `crisis_risk_observed` | A crisis-risk signal was observed or reported. | Emergency response, crisis-team ownership, routing, or human availability. | Emergency posture caveat required. | Needs future redesign |
| `policy_issue_observed` | A possible policy issue was observed or reported. | Confirmed violation or backend adjudication. | Passive metadata only. | Package-safe |
| `manual_support_requested` | A user or host requested support review. | Support availability, queue admission, or reviewer assignment. | Passive metadata only. | Package-safe |

## Queue Priority Labels

| Final name | Meaning | Prohibited meaning | Caveat | Status |
| --- | --- | --- | --- | --- |
| `review_priority_low` | Low display priority label. | SLA, routing, or delayed/expedited handling guarantee. | Passive metadata only. | Package-safe |
| `review_priority_medium` | Medium display priority label. | SLA, routing, or handling guarantee. | Passive metadata only. | Package-safe |
| `review_priority_high` | High display priority label. | Human availability, escalation, timing, or emergency response. | No service-level guarantee. | Package-safe |
| `review_priority_urgent` | Urgent display priority label. | Emergency handling, immediate review, human availability, or timing guarantee. | Emergency posture caveat required. | Needs future redesign |

## Queue Lifecycle Labels

| Final name | Meaning | Prohibited meaning | Caveat | Status |
| --- | --- | --- | --- | --- |
| `review_state_pending` | A review item is labeled pending. | Queue admission or guaranteed review. | Passive metadata only. | Package-safe |
| `review_state_assignment_recorded` | An external assignment record exists. | Package assignment authority or team ownership. | Externally asserted label only. | Host-only |
| `review_state_in_review_reported` | An external source reports the item as in review. | Reviewer availability or active handling guarantee. | Externally asserted label only. | Host-only |
| `review_state_resolution_recorded` | An external resolution record exists. | Package resolution authority or outcome write permission. | Externally asserted label only. | Host-only |
| `review_state_rejection_recorded` | An external rejection/outcome record exists. | Package outcome authority. | Externally asserted label only. | Host-only |
| `review_state_archived_recorded` | An external archive record exists. | Package archive authority. | Externally asserted label only. | Host-only |

## Queue Visibility Labels

| Final name | Meaning | Prohibited meaning | Caveat | Status |
| --- | --- | --- | --- | --- |
| `visibility_restricted_label` | The fact is labeled restricted for display/governance context. | Access-control enforcement. | Passive metadata only. | Package-safe |
| `visibility_safety_review_label` | The fact is associated with safety-review visibility. | Safety-team ownership, staffing, routing, or handling. | No team ownership guarantee. | Needs future redesign |
| `visibility_audit_reference_label` | The fact is associated with audit visibility/reference context. | Audit enforcement or backend audit proof. | Passive metadata only. | Package-safe |
| `visibility_backend_policy_label` | The fact is associated with backend policy context. | Package-level access control or backend enforcement. | Externally asserted label only. | Backend-only |

## Prohibited Queue Vocabulary

- `accepts`
- `acceptedReasons`
- `acceptedPriorities`
- `allowedStates`
- `should_route`
- `should_assign`
- `queue_admitted`
- `safety_team_assigned`
- `handled_by_team`

## Queue Verdict

Queue vocabulary is package-safe only when passive. Anything that admits,
matches, routes, assigns, owns, handles, or guarantees review remains blocked or
host/backend-only.
