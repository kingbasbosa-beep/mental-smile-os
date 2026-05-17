# EX-123 Blocked And Holdback Summary

## Scope

Docs/handoff only. This document summarizes blocked concepts and holdbacks for
future sessions.

## Permanently Or Indefinitely Blocked Concepts

- `EscalationQueue.accepts`
- routing/admission guarantees
- team or moderation ownership guarantees
- emergency guarantees
- emergency handling guarantees
- backend enforcement claims
- client outcome write permissions
- provider causality claims
- provider trust proof
- adapter execution proof
- runtime execution guarantees
- retry/recovery guarantees
- fallback recovery claims
- telemetry/privacy proof
- audit verification proof
- policy compliance proof
- backend governance proof
- governance/write mappers
- runtime/provider public mappers
- runtime/provider package contracts

## Queue/Boundary Holdbacks

- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`
- `providerIssueReported`
- `fallbackLoopObserved`

Holdback rationale:

- `safetyConcernObserved` can imply moderation ownership.
- `reviewStatePending` can imply workflow execution.
- `reviewBoundaryObserved` can imply boundary enforcement.
- `providerIssueReported` can imply provider causality.
- `fallbackLoopObserved` can imply fallback recovery or runtime behavior.

## Runtime/Provider Holdbacks

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

Holdback rationale:

- Provider labels can imply causality, trust, or capability proof.
- Fallback labels can imply fallback execution or recovery.
- Runtime labels can imply execution state proof.
- Backend labels can imply availability or enforcement proof.

## Safe Public Overlap

Current safe public overlap remains limited to:

- `PassiveReviewSignal.auditReferencePresent`
- `PassiveReviewSignal.policyReferencePresent`

These mean reference presence only. They do not prove validity, enforcement, or
runtime/backend behavior.

## Future Review Requirement

Any future proposal touching holdbacks must start with a doctrine/review phase,
not implementation. It must prove that the concept cannot be mistaken for
execution, authority, ownership, enforcement, emergency handling, causality, or
recovery.
