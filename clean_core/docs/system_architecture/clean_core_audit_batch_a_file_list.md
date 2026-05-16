# clean_core Audit Batch A File List

This file defines the exact approved future movement scope for Audit Lane Candidate Batch A.

## Included Files

| File | Future Classification |
| --- | --- |
| `clean_core/lib/core/audit/audit_actor_type.dart` | Safe declarative candidate |
| `clean_core/lib/core/audit/audit_event_type.dart` | Safe declarative candidate with audit-label caveat |
| `clean_core/lib/core/audit/audit_hash_placeholder.dart` | Safe declarative candidate |
| `clean_core/lib/core/audit/audit_redaction.dart` | Safe declarative candidate |
| `clean_core/lib/core/audit/audit_reference.dart` | Safe declarative candidate |
| `clean_core/lib/core/audit/audit_retention_policy.dart` | Safe declarative candidate |
| `clean_core/lib/core/audit/audit_severity.dart` | Safe declarative candidate |
| `clean_core/lib/core/audit/audit_visibility_scope.dart` | Safe declarative candidate with authority-label caveat |

## Excluded Files

Explicitly excluded:

- `audit_runtime_marker.dart`
- `safety_observability_contract.dart`
- `audit_event.dart`
- `audit_trace.dart`
- `audit_snapshot.dart`

## File List Verdict

Only the eight included Batch A files may be considered in a future movement phase. Whole-directory audit movement remains disallowed.
