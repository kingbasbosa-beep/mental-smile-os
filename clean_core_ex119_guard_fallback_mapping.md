# EX-119 Guard/Fallback Mapping

## Guard Decisions

Guard decisions appear in:

- `AiRuntimeGuard.blockReason`
- `ProviderGovernanceGuard.blockReason`
- `RuntimeExecutionGuard.blockReason`
- `RuntimeObservabilityGuard.blockReason`

These are authority-bearing decision functions.

Classification: backend-only.

## Fallback Handling

Fallback concepts include:

- `runtimeDisabled`
- `providerUnavailable`
- `safetyBlocked`
- `lowConfidence`
- `backendUnavailable`
- `fallbackOnlyMode`
- disabled provider adapter fallback
- runtime execution not implemented fallback

Classification: host/backend-owned for behavior; metadata-only possible only as
reported/observed diagnostics after caveats.

## Retry/Recovery Logic

No retry/recovery implementation should be inferred from fallback labels.

Blocked:

- retry scheduled
- recovery started
- recovery completed
- fallback route activated
- provider recovered
- backend recovered

## Guard/Fallback Verdict

Guards and fallbacks are not package-safe execution signals. Public labels, if
ever introduced, must remain reports or observations only.
