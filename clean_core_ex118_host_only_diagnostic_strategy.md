# EX-118 Host-Only Diagnostic Strategy

## Strategy

Runtime/provider diagnostics should remain host-only for now.

## Why Host-Only Is Safest

Host-only diagnostics avoid package-level implication that labels:

- select providers
- prove provider causality
- prove provider trust
- activate runtime execution
- activate fallback
- schedule retry or recovery
- prove backend enforcement
- prove telemetry/privacy state

## Suitable Host-Only Uses

- UI-safe support messaging
- local debug summaries
- admin-only diagnostic displays
- support triage notes
- host-owned runtime status panels

## Required Caveat

Host-visible diagnostics should preserve EX-115 caveats:

> This diagnostic label is passive metadata only. It reports, observes, or marks
> presence of a condition. It does not prove provider causality, provider trust,
> runtime execution state, backend enforcement, telemetry/privacy validity,
> retry, recovery, fallback execution, adapter execution, moderation/safety
> ownership, or emergency handling.

## Host-Only Verdict

Recommended. Host-only diagnostics give teams room to describe conditions
without creating package contracts or public execution signals.
