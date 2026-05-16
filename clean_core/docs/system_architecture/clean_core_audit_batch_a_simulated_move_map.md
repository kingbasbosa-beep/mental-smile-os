# clean_core Audit Batch A Simulated Move Map

EX-28 simulates movement for Audit Batch A only. No folders were created, no files were moved, no exports were modified, and no imports were rewritten.

## Future Destination

Future destination root:

`mental_smile_clean_core/lib/src/audit/`

This folder does not need to exist until the real movement phase.

## Simulated Mapping

| Current Path | Future Package Path |
| --- | --- |
| `clean_core/lib/core/audit/audit_actor_type.dart` | `mental_smile_clean_core/lib/src/audit/audit_actor_type.dart` |
| `clean_core/lib/core/audit/audit_event_type.dart` | `mental_smile_clean_core/lib/src/audit/audit_event_type.dart` |
| `clean_core/lib/core/audit/audit_hash_placeholder.dart` | `mental_smile_clean_core/lib/src/audit/audit_hash_placeholder.dart` |
| `clean_core/lib/core/audit/audit_redaction.dart` | `mental_smile_clean_core/lib/src/audit/audit_redaction.dart` |
| `clean_core/lib/core/audit/audit_reference.dart` | `mental_smile_clean_core/lib/src/audit/audit_reference.dart` |
| `clean_core/lib/core/audit/audit_retention_policy.dart` | `mental_smile_clean_core/lib/src/audit/audit_retention_policy.dart` |
| `clean_core/lib/core/audit/audit_severity.dart` | `mental_smile_clean_core/lib/src/audit/audit_severity.dart` |
| `clean_core/lib/core/audit/audit_visibility_scope.dart` | `mental_smile_clean_core/lib/src/audit/audit_visibility_scope.dart` |

## Excluded From Simulation

- `audit_runtime_marker.dart`
- `safety_observability_contract.dart`
- `audit_event.dart`
- `audit_trace.dart`
- `audit_snapshot.dart`

## Move Map Verdict

Simulated move scope is exact, narrow, and limited to the eight approved pure Dart files.
