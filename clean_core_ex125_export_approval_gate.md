# EX-125 Export Approval Gate

## Scope

Docs/review only. This gate must be used before any future change to
`mental_smile_clean_core/lib/mental_smile_clean_core.dart`.

## Export Baseline

The current public surface is explicitly file-based. EX-124 verified 126
explicit file exports, no wildcard exports, no directory exports, and no export
of internal passive vocabulary files.

## Required Answers

- Is it passive? Required yes.
- Is it pure Dart? Required yes.
- Does the name imply authority? Required no.
- Does it imply execution? Required no.
- Does it imply routing/admission? Required no.
- Does it imply backend enforcement? Required no.
- Does it imply emergency handling? Required no.
- Does it imply provider causality? Required no.
- Does it imply retry/fallback recovery? Required no.
- Does it require mapper ownership? Required no.
- Is rollback local? Required yes.
- Is compatibility preserved? Required yes.
- Is public export justified? Required yes.
- Is consumer migration explicitly approved? Required separate approval.

## Approval Requirements

A future export may be approved only when:

- the contract already passed the package addition decision matrix
- the export is an explicit file export
- the exported symbol is passive metadata only
- the name cannot be mistaken for authority or execution
- caveats are present where misuse risk exists
- the export does not expose Firestore/Firebase behavior
- the export does not expose mapper ownership
- the export does not reconnect consumers by implication
- rollback can remove the export without runtime/provider activation
- compatibility with existing public contracts is preserved

## Blocked Export Patterns

- wildcard exports
- directory exports
- exports of host Firestore mappers
- exports of Firebase/Timestamp/FieldValue behavior
- exports of queue admission or routing concepts
- exports of boundary enforcement concepts
- exports of runtime/provider diagnostic concepts
- exports of AI/safety labels that imply ownership or guarantees
- exports that require consumer migration to become meaningful
- exports that make a passive label appear operational

## Current Internal Holdbacks

The following remain unexported unless a future doctrine wave explicitly
reopens them:

- `boundary_passive_label.dart`
- `emergency_posture_label.dart`
- `fallback_observation_label.dart`
- `provider_issue_label.dart`
- `queue_passive_label.dart`

## Export Gate Verdict

Pass. The export approval gate is fail-closed and preserves explicit export
doctrine.
