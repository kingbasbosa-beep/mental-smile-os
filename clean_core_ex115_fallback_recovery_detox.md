# EX-115 Fallback Recovery Detox

## Problem

Fallback labels can be misread as route activation, retry intent, or recovery
status.

## Candidate Caveats

### `fallbackLoopObserved`

Final caveat:

> `fallbackLoopObserved` means a fallback-loop condition was observed. It does
> not route work, start fallback, schedule retry, prove recovery need, complete
> recovery, prove runtime failure, or guarantee fallback response.

Status: holdback.

### `fallbackOnlyModeObserved`

Final caveat:

> `fallbackOnlyModeObserved` means fallback-only mode was observed or reported.
> It does not prove active runtime mode, enforce fallback behavior, guarantee
> fallback response, route execution, or prove recovery status.

Status: holdback.

## Blocked Recovery Meanings

- retry scheduled
- fallback activated
- fallback route accepted
- fallback response guaranteed
- fallback loop resolved
- runtime recovered
- backend recovered
- provider recovered

## Fallback Detox Verdict

Fallback diagnostics are not public-ready. They remain metadata-only candidates
with holdback status.
