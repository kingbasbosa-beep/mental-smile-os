# EX-93 EscalationRequest Rollback Simulation

## Local Rollback Scope

If EX-94 executes an additive split, rollback should remain limited to:

- remove `mental_smile_clean_core/lib/src/human_review/escalation_request.dart`
- remove `clean_core/lib/core/human_review/firestore/escalation_request_firestore_mapper.dart`
- remove one explicit barrel export for `src/human_review/escalation_request.dart`

## Rollback Preconditions

Rollback remains local only if:

- existing host compatibility file is not moved;
- no consumer reconnect occurs;
- no package import is introduced into `clean_core/lib/core`;
- `EscalationBoundaryMarker` remains host-only;
- queue/routing logic remains untouched;
- no pubspec/dependency changes occur.

## Rollback Risk

Rollback becomes non-local if EX-94 changes existing request imports, removes host `boundaryMarker` storage, migrates consumers, or changes queue/boundary files.

## Rollback Verdict

Local rollback is achievable for an additive metadata split with host-side boundary preservation.
