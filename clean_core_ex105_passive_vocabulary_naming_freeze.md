# EX-105 Passive Vocabulary Naming Freeze

## Scope

This document freezes naming strategy for the EX-104 passive vocabulary
candidates before any package introduction. It is review documentation only and
does not create contracts, mappers, imports, exports, runtime behavior, or
consumer migration.

## Naming Strategy

Final Dart type names should use PascalCase and describe the family, not the
stored snake_case value.

Recommended future type families:

- `PassiveQueueIntentLabel`
- `PassiveQueueLifecycleLabel`
- `PassiveBoundaryLabel`
- `PassiveEmergencyPostureLabel`
- `PassiveProviderIssueLabel`
- `PassiveFallbackObservationLabel`

The exact type/file creation remains out of scope for EX-105.

## Snake Case Strategy

Snake_case names must be enum keys or serialized labels only. They should not be
Dart type names.

Approved pattern:

- Dart enum value: `safetyConcernObserved`
- Serialized key: `safety_concern_observed`

Rejected pattern:

- Dart type: `safety_concern_observed`
- Dart class: `policy_issue_observed`

## Candidate Naming Freeze

The following serialized labels are approved for freeze review:

- `safety_concern_observed`
- `policy_issue_observed`
- `manual_support_requested`
- `review_state_pending`
- `policy_reference_present`
- `audit_reference_present`
- `review_boundary_observed`
- `emergency_capability_not_guaranteed`
- `provider_issue_reported`
- `fallback_loop_observed`

## Caveat Freeze

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

## Naming Verdict

The candidate snake_case labels are suitable as keys. Dart names should be
PascalCase types with lowerCamelCase enum values. No snake_case Dart classes or
types should be introduced.
