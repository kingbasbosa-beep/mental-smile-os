# EX-108 Semantic Confusion Review

## Confusion Risk Summary

The labels are passive in code, but public export changes interpretation risk.
Consumers may treat public enum values as execution signals unless documentation
clearly says otherwise.

## Special-Focus Labels

### `emergencyCapabilityNotGuaranteed`

Risk: low.

This is negative posture and does not promise emergency handling. It is the
strongest emergency-safe candidate.

Decision: safe for controlled export.

### `providerIssueReported`

Risk: medium.

Although the comment denies causality, consumers may treat a provider issue as a
confirmed provider failure.

Decision: conditionally safe. Export only with strong caveat: reported issue,
not diagnosis.

### `fallbackLoopObserved`

Risk: medium.

The label can be mistaken for fallback orchestration state or recovery signal.

Decision: conditionally safe. Export only with strong caveat: observation only,
no routing or recovery.

### `reviewBoundaryObserved`

Risk: medium.

The label can be mistaken for enforced review boundary, backend governance, or
routing eligibility.

Decision: conditionally safe. Export only with strong caveat: observed boundary
label only, no enforcement.

### `reviewStatePending`

Risk: medium.

The label can be mistaken for queue admission or guaranteed human review.

Decision: conditionally safe. Export only with strong caveat: passive pending
label only, no admission or SLA.

## Doctrine Decisions

- No label may imply routing or admission.
- No label may imply moderation/team ownership.
- No label may imply backend enforcement.
- No label may imply emergency handling.
- No label may imply provider/runtime causality.
- No label may imply fallback recovery.

## Semantic Verdict

Export creates semantic confusion risk for lifecycle, boundary, provider, and
fallback labels. Export should be limited, documented, and staged.
