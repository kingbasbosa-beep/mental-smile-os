# EX-108 Passive Vocabulary Export Readiness

## Scope

Review-only determination of whether the EX-106 passive vocabulary files are
ready for controlled package export or should remain internal-only. No source,
runtime, barrel, mapper, import/export, consumer, pub get, or analyze changes
were made.

## Commands Used

- `Get-ChildItem -Path . -Filter "clean_core_ex108_*.md" -Force`
- `Get-Content` for the five passive vocabulary files
- `Get-Content mental_smile_clean_core/lib/mental_smile_clean_core.dart`
- `Select-String` against the package barrel for passive file/type names
- `Get-Content` for EX-101 through EX-107 doctrine docs where present
- `git status --short mental_smile_clean_core/lib/src/human_review mental_smile_clean_core/lib/mental_smile_clean_core.dart`

## Files Reviewed

- `mental_smile_clean_core/lib/src/human_review/queue_passive_label.dart`
- `mental_smile_clean_core/lib/src/human_review/boundary_passive_label.dart`
- `mental_smile_clean_core/lib/src/human_review/emergency_posture_label.dart`
- `mental_smile_clean_core/lib/src/human_review/provider_issue_label.dart`
- `mental_smile_clean_core/lib/src/human_review/fallback_observation_label.dart`
- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

## Export Readiness Classification

| Vocabulary | Export readiness | Reason |
| --- | --- | --- |
| `QueuePassiveLabel.safetyConcernObserved` | Conditionally safe | Passive observation, but moderation context can be overread. |
| `QueuePassiveLabel.policyIssueObserved` | Safe for controlled export | Good detox wording; no confirmed violation claim. |
| `QueuePassiveLabel.manualSupportRequested` | Safe for controlled export | Request label only. |
| `QueuePassiveLabel.reviewStatePending` | Conditionally safe | Could be misused as queue admission or guaranteed review state. |
| `BoundaryPassiveLabel.policyReferencePresent` | Safe for controlled export | Reference presence only. |
| `BoundaryPassiveLabel.auditReferencePresent` | Safe for controlled export | Reference presence only. |
| `BoundaryPassiveLabel.reviewBoundaryObserved` | Conditionally safe | Could be misused as boundary enforcement or routing signal. |
| `EmergencyPostureLabel.emergencyCapabilityNotGuaranteed` | Safe for controlled export | Negative posture; lowers false guarantee risk. |
| `ProviderIssueLabel.providerIssueReported` | Conditionally safe | Could be misused as provider/runtime causality. |
| `FallbackObservationLabel.fallbackLoopObserved` | Conditionally safe | Could be misused as fallback recovery/routing signal. |

## Readiness Finding

The files are technically export-clean, but semantic export is only partially
ready. Export should not broadly proceed until consumer-facing docs and naming
caveats are attached to any exported symbols.
