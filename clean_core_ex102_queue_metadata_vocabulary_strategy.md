# EX-102 Queue Metadata Vocabulary Strategy

## Goal

Define passive package-safe queue labels while prohibiting package-facing queue
admission logic.

## Passive Package-Safe Queue Labels

Potentially safe future vocabulary:

- `review_reason_label`
- `review_priority_label`
- `review_state_label`
- `review_visibility_label`
- `review_policy_reference_label`
- `review_audit_reference_label`
- `review_origin_label`

These labels describe request metadata only. They do not route, accept, assign,
resolve, enforce, or notify.

## Detoxed Reason Labels

Potential package-safe reason labels after redesign:

- `safety_concern_observed`
- `crisis_risk_observed`
- `policy_issue_observed`
- `provider_issue_reported`
- `fallback_loop_observed`
- `manual_support_requested`

The wording should emphasize observation or reporting. It must not imply that the
package diagnosed cause, assigned owner, routed a queue, or activated emergency
handling.

## Prohibited Queue Admission Predicates

Package-facing APIs must not expose predicates equivalent to:

- accepts request
- accepts reason
- accepts priority
- accepts state
- should route
- should assign
- should escalate
- should notify team
- is admitted to queue
- is handled by safety team

`EscalationQueue.accepts` remains prohibited for package exposure because it is
routing, policy, and orchestration logic rather than metadata.

## Queue Vocabulary Boundary

Allowed:

- passive labels
- display-safe category names
- audit references
- policy reference metadata

Blocked:

- executable routing rules
- queue matching logic
- assignment logic
- review ownership logic
- resolution logic
- backend queue claims

## Doctrine

Queue vocabulary may describe the shape of a review fact. It must not decide
where the fact goes or who owns it.
