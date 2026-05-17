# EX-124 Export Governance Verification

## Scope

Docs/review only. Verified the package barrel for explicit export governance
after EX-123.

## Commands Used

- `Get-Content -Path mental_smile_clean_core/lib/mental_smile_clean_core.dart`
- `Select-String -Path mental_smile_clean_core/lib/mental_smile_clean_core.dart -Pattern "^export"`
- `rg 'export .*\\*|export [''\"\"].*/[''\"\"]|export [''\"\"].*src/audit/[''\"\"]|export [''\"\"].*src/human_review/[''\"]' mental_smile_clean_core/lib/mental_smile_clean_core.dart`
- `rg "boundary_passive_label|emergency_posture_label|fallback_observation_label|provider_issue_label|queue_passive_label|QueuePassiveLabel|BoundaryPassiveLabel|EmergencyPostureLabel|ProviderIssueLabel|FallbackObservationLabel" mental_smile_clean_core/lib clean_core/lib test`

## Explicit Exports Only

Finding: the barrel uses explicit file exports. Each exported API is named as a
specific Dart file.

## No Wildcard Exports

Finding: no wildcard export was found in
`mental_smile_clean_core/lib/mental_smile_clean_core.dart`.

## No Directory Exports

Finding: no directory export was found for audit, human review, or any other
surface group. The apparent groups are organizational only; the actual barrel
entries remain file-specific.

## Internal Passive Vocabulary Holdback

The following files exist under `mental_smile_clean_core/lib/src/human_review/`
but remain unexported:

- `boundary_passive_label.dart`
- `emergency_posture_label.dart`
- `fallback_observation_label.dart`
- `provider_issue_label.dart`
- `queue_passive_label.dart`

The labels remain package-internal only:

- `BoundaryPassiveLabel`
- `EmergencyPostureLabel`
- `FallbackObservationLabel`
- `ProviderIssueLabel`
- `QueuePassiveLabel`

## PassiveReviewSignal Verification

`PassiveReviewSignal` remains the only public passive review signal vocabulary
in the barrel. Its source-level caveat states that the labels are passive
metadata only and must not be used for routing, admission, assignment,
enforcement, verification, backend governance proof, emergency handling,
provider/runtime causality, fallback recovery, or outcome write permission.

## Export Governance Verdict

Pass. Export governance remains explicit, narrow, and compatible with the
holdback doctrine. EX-124 made no import/export changes.
