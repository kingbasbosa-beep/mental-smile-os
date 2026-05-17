# EX-112 Export Risk Summary

## Public Export Risk Doctrine

Export changes interpretation. Once a symbol is public, consumers may treat it as
an execution signal even if the implementation is inert.

## Consumer Misuse Risk Findings

Consumers could misuse labels as:

- queue routing signals
- queue admission proof
- moderation/team assignment proof
- backend enforcement proof
- emergency workflow activation
- provider failure diagnosis
- fallback recovery state
- outcome write permission

## Narrow Export Strategy

Only the lowest-risk labels were exported:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

Why these are lower risk:

- no routing verb
- no queue-admission state
- no team ownership language
- no provider/fallback causality
- no backend governance proof
- emergency label is negative posture only

## Export Blockers

Still blocked:

- broad passive vocabulary export
- high-risk label export
- consumer migration
- mappers
- routing/admission helpers
- backend enforcement claims
- emergency guarantees
- provider causality
- fallback recovery

## Export Verdict

The narrow export is acceptable because it is explicit, caveated, low-risk, and
rollback-local. Broad export remains blocked.
