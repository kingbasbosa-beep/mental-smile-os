# clean_core Audit Lane Future Extraction Candidates

This document proposes future audit lane extraction candidates without executing extraction.

## Candidate Batch A: Safe Pure Contracts

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Candidate Batch B: Marker/Adapter Review

- `audit_runtime_marker.dart`
- `safety_observability_contract.dart`

Batch B requires explicit documentation that runtime/provider fields are observational and non-executing.

## Blocked Until Split

- `audit_event.dart`
- `audit_trace.dart`
- `audit_snapshot.dart`

Required split:

- pure Dart audit event/trace/snapshot contracts
- host/backend Firestore mapper for `Timestamp` and `FieldValue.serverTimestamp()`

## Extraction Preconditions

- no Firebase imports
- no Flutter imports
- no app-owned imports
- no runtime activation semantics
- curated exports only
- hidden contracts reviewed
- rollback checkpoint available

## Extraction Verdict

Audit lane can become a future Wave 2 candidate only in split batches. It is not ready for whole-lane movement.
