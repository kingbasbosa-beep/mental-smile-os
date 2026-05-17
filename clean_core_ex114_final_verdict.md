# EX-114 Final Verdict

## Candidate Findings

The runtime/provider diagnostic candidate set is useful, but most candidates are
not ready for public package introduction. Provider, fallback, and runtime-state
labels require stronger caveats because consumers may treat them as execution,
causality, or recovery signals.

## Package-Safe Candidates

- `auditReferencePresent`
- `policyReferencePresent`

These already exist in the narrow passive review signal export and remain safe
only as reference-presence labels.

## Rename/Detox Findings

No reviewed candidate needs immediate renaming. However, provider/fallback names
must remain soft:

- use `reported`, not confirmed
- use `observed`, not detected/proven
- use reference `present`, not verified
- never use failure/causality/recovery wording for public package labels

## Candidates Requiring Stronger Caveats

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

## Blocked Semantics

- provider causality claims
- runtime execution guarantees
- retry/recovery guarantees
- fallback recovery claims
- provider trust proof
- adapter execution proof
- moderation/safety ownership
- telemetry/privacy proof
- backend enforcement proof
- runtime/provider public mappers

## Final Verdict

Pass as a candidate review. Do not introduce new runtime/provider public package
contracts yet.

## Recommended EX-115 Phase

EX-115 should define the Runtime/Provider Diagnostic Caveat Specification:

- freeze caveat language for reported/observed diagnostics
- classify which labels remain internal-only
- define public misuse warnings
- decide whether any non-reference diagnostic label may ever be exported
- preserve blocks on execution, causality, retry, recovery, provider trust,
  telemetry proof, and backend enforcement
