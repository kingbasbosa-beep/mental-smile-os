# clean_core Human Review Import Review

This import review covers only `clean_core/lib/core/human_review/`.

## Pure Dart Files Without Imports

- `escalation_audit_link.dart`
- `escalation_boundary_marker.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Local-Only Imports

`escalation_queue.dart` imports only local human review contracts:

- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Firebase-Coupled Imports

These files import `package:cloud_firestore/cloud_firestore.dart`:

- `escalation_assignment.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

They use `FieldValue.serverTimestamp()` and `Timestamp.fromDate()`, which makes them host/Firebase-coupled.

## Absent Imports

No human review lane file was found importing:

- Flutter UI
- provider SDKs
- networking clients
- app package paths
- generated localization
- routing
- assets

## Import Verdict

Import risk is concentrated in the four Firestore-coupled persistence/action record files.
