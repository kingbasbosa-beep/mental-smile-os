# EX-61 Audit Event V2 Future Shape

Phase: EX-61 - audit_event Split Simulation V2

## Scope

This document simulates a future additive split for:

- `clean_core/lib/core/audit/audit_event.dart`

No source files were modified, no files were moved, no imports were changed, no exports were changed, no dependencies were added, and no runtime systems were activated.

## Simulated Package File

Future package model:

- `mental_smile_clean_core/lib/src/audit/audit_event.dart`

## Future Pure Model Fields

Potential package-safe fields:

- event type label or typed package event type
- severity label or typed package severity
- actor type label or typed package actor type
- actor id
- visibility scope label or typed package visibility scope
- sanitized preview
- policy version
- audit references
- `AuditProcessingContext processingContext`
- `DateTime? createdAt`

## Package-Safe Shape Requirements

Future package model must:

- be Dart-only
- avoid `cloud_firestore`
- avoid `FieldValue`
- avoid `Timestamp`
- avoid Firestore map ownership
- avoid runtime execution
- avoid provider authority
- avoid backend authority enforcement

## Future Shape Finding

`audit_event` is more viable after `AuditProcessingContext`, but it still requires a package-safe strategy for audit reference and enum/label dependencies.

