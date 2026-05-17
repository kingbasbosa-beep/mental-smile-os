# EX-118 Unexported Package Option Review

## Option

Create unexported internal package diagnostic files later.

Potential labels:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

## Benefits

- keeps names close to package doctrine
- can preserve caveats near definitions
- rollback could be local if isolated
- avoids public export

## Risks

- creates apparent package intent before orchestration doctrine is ready
- may encourage future export pressure
- may duplicate host/backend diagnostic language
- may be mistaken for a future mapper or contract surface
- still risks semantic confusion even unexported

## Readiness Finding

Unexported package files are not justified now. They may be considered only if:

- no exports are added
- no consumers are added
- no mappers are added
- no runtime/provider/Firebase imports are added
- labels remain strictly passive
- rollback is delete-file local
- runtime/provider orchestration isolation has completed

## Option Verdict

Blocked for now. Revisit after runtime/provider orchestration isolation.
