# EX-108 Final Verdict

## Final Verdict

EX-106 files are technically clean but not broadly ready for full package export.

They remain isolated, unexported, pure, and non-authoritative. However, public
export creates semantic confusion risk because consumers may treat lifecycle,
boundary, provider, or fallback labels as execution signals.

## Approved vs Blocked Exports

Safe for controlled export:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

Conditionally safe with stronger caveats:

- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`
- `providerIssueReported`
- `fallbackLoopObserved`

Blocked:

- any accepts predicate
- routing/admission helpers
- moderation/team ownership claims
- backend enforcement claims
- emergency guarantees
- provider/runtime causality claims
- fallback recovery claims
- mappers
- consumer reconnection

## Doctrine Decisions

- Labels remain facts, not powers.
- The grouping strategy remains correct.
- Strong public caveats are required before any export.
- Provider/fallback labels should remain internal until runtime/provider public
  doctrine is clearer.
- Full export should remain blocked.

## EX-109 Decision

EX-109 is partially approved only for a controlled export plan or a narrow
low-risk export with public caveats and no consumers.

EX-109 is blocked for full export, consumers, mappers, routing/admission logic,
runtime/provider activation, backend enforcement claims, emergency guarantees,
provider causality, or fallback recovery.

## Closing Finding

Recommended posture: keep all labels internal-only for now, or export only the
lowest-risk subset after a dedicated public-caveat doc is created.
