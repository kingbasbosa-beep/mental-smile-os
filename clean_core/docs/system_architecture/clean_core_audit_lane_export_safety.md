# clean_core Audit Lane Export Safety

This document recommends future export posture for the audit lane. No exports were changed.

## Safe Future Export Candidates

Recommended for future curated export after final review:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Export With Runtime-Sensitive Notes

Potentially exportable only with marker-only documentation:

- `audit_runtime_marker.dart`

Reason: it references runtime mode and provider id, but remains declarative.

## Adapter-Boundary Export Candidate

Potentially exportable after adapter-boundary review:

- `safety_observability_contract.dart`

Reason: it bridges audit, incident references, runtime marker, provider id, policy version, and fallback reason.

## Do Not Export Yet

Do not export until Firestore coupling is removed or moved behind host adapters:

- `audit_event.dart`
- `audit_trace.dart`
- `audit_snapshot.dart`

## Export Safety Verdict

The audit lane can support a future curated export subset, but it is not safe for whole-directory export.
