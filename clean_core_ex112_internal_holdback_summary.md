# EX-112 Internal Holdback Summary

## Internal Holdbacks

- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`
- `providerIssueReported`
- `fallbackLoopObserved`

## Holdback Rationale

### `safetyConcernObserved`

Can imply moderation ownership, safety-team handling, or routing.

### `reviewStatePending`

Can imply queue admission, workflow state, or guaranteed human review.

### `reviewBoundaryObserved`

Can imply enforced boundary, backend governance, or routing eligibility.

### `providerIssueReported`

Can imply provider/runtime causality or provider failure diagnosis.

### `fallbackLoopObserved`

Can imply fallback routing, loop recovery, or runtime enforcement.

## Permanently/Indefinitely Blocked Concepts

- `EscalationQueue.accepts`
- routing/admission guarantees
- moderation ownership guarantees
- emergency guarantees
- backend enforcement claims
- client outcome write permissions
- provider causality claims
- fallback recovery claims
- governance/write mappers

## Holdback Verdict

Internal holdbacks are intentional, not incomplete work. They preserve semantic
safety until separate doctrine waves exist.
