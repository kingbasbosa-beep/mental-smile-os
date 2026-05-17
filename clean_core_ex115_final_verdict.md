# EX-115 Final Verdict

## Docs Created

- `clean_core_ex115_runtime_provider_diagnostic_caveat_spec.md`
- `clean_core_ex115_provider_causality_detox.md`
- `clean_core_ex115_runtime_execution_detox.md`
- `clean_core_ex115_fallback_recovery_detox.md`
- `clean_core_ex115_backend_observability_detox.md`
- `clean_core_ex115_final_verdict.md`

## Final Caveat Text

> This diagnostic label is passive metadata only. It reports, observes, or marks
> presence of a condition. It does not prove provider causality, provider trust,
> runtime execution state, backend enforcement, telemetry/privacy validity,
> retry, recovery, fallback execution, adapter execution, moderation/safety
> ownership, or emergency handling.

## Safe Candidates

- `auditReferencePresent`
- `policyReferencePresent`

These remain safe only with caveats that prohibit audit verification, policy
compliance proof, telemetry/privacy proof, backend enforcement, and execution
permission.

## Holdbacks

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

## Final Verdict

Pass as a caveat specification. No new runtime/provider public package
contracts, mappers, or exports should be introduced yet.

## Recommended EX-116 Phase

EX-116 should be Runtime/Provider Diagnostic Naming Freeze and Holdback Review:

- freeze diagnostic names
- freeze caveat text
- classify all non-reference diagnostics as internal-only or future candidates
- decide whether any holdback can move toward unexported introduction
- keep public export blocked for non-reference diagnostics
