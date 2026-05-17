# EX-102 Emergency Semantics Policy

## Purpose

Define emergency semantics doctrine for any future queue/boundary package
exposure.

## Emergency Guarantee Prohibition

`emergencyGuarantee` must not become a package-facing promise.

A package cannot guarantee:

- emergency response
- human availability
- emergency routing
- crisis-team ownership
- service-level timing
- backend intervention
- provider escalation

## Allowed Emergency-Safe Metadata

Potentially safe metadata must be negative or descriptive, not promissory:

- `emergency_capability_not_guaranteed`
- `crisis_risk_observed`
- `emergency_support_guidance_present`
- `local_emergency_services_guidance_present`
- `human_support_encouraged`

These labels must not imply that the package has activated emergency handling.

## Blocked Emergency Concepts

The following are blocked from package-facing exposure:

- emergency guaranteed
- crisis team assigned
- emergency route accepted
- emergency queue admitted
- emergency backend handled
- emergency provider escalated
- emergency outcome writable by client

## Provider/Runtime Causality Detox

Emergency semantics must not be coupled to provider/runtime causality in package
metadata.

`providerFailure` may be represented only as a detoxed passive report, such as
`provider_issue_reported`. The host/backend decides whether a provider actually
failed and whether that failure matters.

## `fallbackLoop` Detox

`fallbackLoop` may be represented only as an observed passive condition, such as
`fallback_loop_observed`. The package must not claim loop recovery, routing, or
emergency escalation based on it.

## Doctrine

Emergency language must reduce false certainty. The package may provide safety
posture labels and guidance metadata, but emergency handling remains
host/backend-owned.
