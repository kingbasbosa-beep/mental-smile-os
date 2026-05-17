# EX-109 High-Risk Internal Holdback

## Holdback Labels

The following labels must remain internal for now:

- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`
- `providerIssueReported`
- `fallbackLoopObserved`

## Holdback Rationale

### `safetyConcernObserved`

Risk: can imply moderation ownership, safety-team handling, or routing.

Holdback decision: internal until public docs can prevent moderation/team
ownership interpretation.

### `reviewStatePending`

Risk: can imply queue admission or guaranteed review.

Holdback decision: internal until lifecycle labels are clearly separated from
workflow state.

### `reviewBoundaryObserved`

Risk: can imply enforced boundary, routing eligibility, or backend governance.

Holdback decision: internal until boundary labels have stronger public caveats.

### `providerIssueReported`

Risk: can imply provider/runtime causality or provider failure diagnosis.

Holdback decision: internal until runtime/provider public doctrine exists.

### `fallbackLoopObserved`

Risk: can imply fallback routing, loop recovery, or runtime enforcement.

Holdback decision: internal until fallback public doctrine exists.

## Permanently Blocked Concepts

- accepts predicates
- routing/admission helpers
- moderation/team ownership claims
- backend enforcement claims
- emergency guarantees
- provider/runtime causality claims
- fallback recovery claims
- mappers
- consumer reconnection

## Holdback Verdict

High-risk labels remain internal-only. They should not be included in a narrow
EX-110 export.
