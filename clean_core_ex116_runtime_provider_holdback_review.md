# EX-116 Runtime/Provider Holdback Review

## Holdback Labels

The following remain holdback:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

## Holdback Rationale

### `providerIssueReported`

Still can imply provider fault, provider outage, runtime causality, or backend
adjudication.

### `providerCapabilityGapObserved`

Still can imply provider capability proof, inability proof, or compatibility
verdict.

### `fallbackLoopObserved`

Still can imply recovery need, recovery completion, retry, route activation, or
runtime failure.

### `fallbackOnlyModeObserved`

Still can imply active runtime mode, fallback enforcement, or fallback
availability.

### `runtimeDisabledObserved`

Still can imply verified runtime state, execution guarantee, or backend proof.

### `backendUnavailableObserved`

Still can imply backend outage proof, backend causality, or enforcement state.

## Holdback Verdict

No holdback should move to public package introduction yet. A future unexported
introduction could be considered only after a separate readiness review.
