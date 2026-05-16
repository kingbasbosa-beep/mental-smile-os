# EX-47 Mapper Split Inventory

Phase: EX-47 - Mapper Split Strategy

## Scope

This inventory reviews Firestore-coupled audit and human review files for future split planning only.

No source files were modified, no imports were changed, no exports were changed, no dependencies were added, and no runtime systems were activated.

## Audit Targets

- `clean_core/lib/core/audit/audit_event.dart`
- `clean_core/lib/core/audit/audit_trace.dart`
- `clean_core/lib/core/audit/audit_snapshot.dart`

## Human Review Targets

- `clean_core/lib/core/human_review/escalation_assignment.dart`
- `clean_core/lib/core/human_review/escalation_request.dart`
- `clean_core/lib/core/human_review/escalation_resolution.dart`
- `clean_core/lib/core/human_review/escalation_review.dart`

## Shared Coupling Pattern

Each target currently mixes:

- pure domain fields
- Firestore import
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- `toMap({bool useServerTimestamp = false})`
- private `_timestampOrNull(...)`

## Split Goal

Future work should separate:

1. pure Dart contract/model
2. host/backend Firestore mapper
3. optional adapter boundary later

