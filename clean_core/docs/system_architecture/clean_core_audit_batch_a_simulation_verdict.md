# clean_core Audit Batch A Simulation Verdict

EX-28 simulated future movement for Audit Batch A only.

## Simulation Findings

- Destination would be `mental_smile_clean_core/lib/src/audit/`.
- Eight files would move.
- Eight explicit root barrel exports would be added.
- No internal import rewrites are expected.
- No host reconnect is expected during movement.
- Rollback is limited to eight files and eight export lines.

## Approved Future Movement Scope

Approved for future execution only:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Not Approved

- whole audit directory movement
- Firestore-coupled audit files
- runtime marker movement
- safety observability contract movement
- host reconnect
- adapter implementation
- runtime/provider activation

## Final Verdict

Audit Batch A is ready for a future controlled movement phase, but EX-28 performed simulation only.
