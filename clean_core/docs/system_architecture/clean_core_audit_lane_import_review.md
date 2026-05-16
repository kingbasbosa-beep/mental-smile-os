# clean_core Audit Lane Import Review

This import review covers only `clean_core/lib/core/audit/`.

## Pure Dart Files

These files have no external package imports:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_runtime_marker.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Local-Only Imports

`safety_observability_contract.dart` imports only local audit contracts:

- `audit_reference.dart`
- `audit_runtime_marker.dart`

## Firebase-Coupled Imports

These files import `package:cloud_firestore/cloud_firestore.dart`:

- `audit_event.dart`
- `audit_trace.dart`
- `audit_snapshot.dart`

They use `FieldValue.serverTimestamp()` and `Timestamp.fromDate()`, which makes them app/Firebase-coupled and not safe for immediate extraction into dependency-free `mental_smile_clean_core`.

## Absent Imports

No audit lane file was found importing:

- Flutter UI
- provider SDKs
- networking clients
- app package paths
- generated localization
- routing
- assets

## Import Verdict

Audit lane import risk is concentrated in the three Firestore-coupled timestamp mapping files.
