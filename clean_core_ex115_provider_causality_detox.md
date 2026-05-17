# EX-115 Provider Causality Detox

## Problem

Provider labels can be misread as proof that a provider caused, failed, blocked,
or mishandled execution.

## Detox Rules

Use:

- reported
- observed
- reference present
- issue reported
- gap observed

Do not use:

- confirmed
- proven
- failed
- caused
- trusted
- approved
- compatible
- unavailable confirmed

## Candidate Caveats

### `providerIssueReported`

Final caveat:

> `providerIssueReported` means a provider-related issue was reported. It does
> not prove provider fault, outage, runtime causality, trust level, backend
> adjudication, or provider execution state.

Status: holdback.

### `providerCapabilityGapObserved`

Final caveat:

> `providerCapabilityGapObserved` means a capability gap was observed or
> reported. It does not prove provider capability, provider inability,
> compatibility, trust, approval, or execution safety.

Status: holdback.

## Backend-Owned Provider Meanings

The following remain backend-only:

- provider causality
- provider trust proof
- provider compatibility proof
- provider approval
- provider blocking
- provider capability enforcement

## Provider Detox Verdict

Provider diagnostics can be passive reports only. They are not ready for public
export.
