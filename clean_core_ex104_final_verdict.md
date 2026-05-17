# EX-104 Final Verdict

## Final Verdict

The passive vocabulary specification is ready for no-code review. It is not
ready for package contracts.

The package may describe facts only. Any term that accepts, routes, admits,
assigns, resolves, enforces, guarantees emergency handling, proves backend
governance, grants client outcome writes, diagnoses provider causality, or
claims fallback recovery remains blocked or host/backend-owned.

## Final Vocabulary Candidates

Strongest package-safe candidates:

- `safety_concern_observed`
- `policy_issue_observed`
- `manual_support_requested`
- `review_priority_low`
- `review_priority_medium`
- `review_priority_high`
- `review_state_pending`
- `visibility_restricted_label`
- `visibility_audit_reference_label`
- `policy_reference_present`
- `audit_reference_present`
- `review_boundary_observed`
- `emergency_capability_not_guaranteed`
- `emergency_support_guidance_present`
- `human_support_encouraged`
- `provider_issue_reported`
- `provider_capability_gap_reported`
- `fallback_loop_observed`
- `fallback_recommended_label`
- `fail_safe_posture_label`

## Caveat Text

Default caveat:

> This label is passive metadata only. It does not route, admit, assign, enforce,
> guarantee human review, guarantee emergency handling, prove backend
> governance, diagnose provider causality, recover fallback loops, or grant
> outcome write permission.

Emergency caveat:

> This label does not guarantee emergency response, human availability, queue
> admission, backend intervention, provider escalation, or service-level timing.

External assertion caveat:

> This label records an externally supplied assertion only. The package does not
> verify, enforce, or guarantee the assertion.

## Blocked Concepts

- `EscalationQueue.accepts`
- accepts predicates
- routing/admission guarantees
- team ownership guarantees
- emergency guarantees
- backend enforcement claims
- client outcome write permissions
- provider causality claims
- fallback recovery claims
- package mappers for governance/write semantics

## Recommended EX-105 Phase

EX-105 should be a no-code migration-blocker and naming-freeze review:

- confirm final label names
- freeze caveat text
- identify labels requiring host/backend proof
- identify labels requiring future legal/safety review
- define package introduction blockers
- keep package contracts and mappers out of scope

## Closing Doctrine

Labels are not powers. The package describes facts only; host/backend owns
routing, admission, enforcement, emergency handling, provider causality,
fallback recovery, moderation ownership, review/resolution ownership, and
outcome writes.
