# EX-115 Runtime Execution Detox

## Problem

Runtime labels can be misread as proof of execution state, permission, or safety.

## Candidate Caveats

### `runtimeDisabledObserved`

Final caveat:

> `runtimeDisabledObserved` means a runtime-disabled condition was observed or
> reported. It does not prove backend runtime state, execution permission,
> adapter state, provider state, safety status, or enforcement.

Status: holdback.

### `backendUnavailableObserved`

Final caveat:

> `backendUnavailableObserved` means a backend-unavailable condition was
> observed or reported. It does not prove backend outage, backend causality,
> governance state, enforcement state, or recovery status.

Status: holdback.

## Runtime Meanings That Stay Blocked

- runtime execution guarantee
- AI completion guarantee
- adapter execution proof
- client-side runtime permission
- backend governance proof
- execution safety proof

## Runtime Detox Verdict

Runtime-state diagnostics require stronger caveats and should remain internal
until a later public readiness phase.
