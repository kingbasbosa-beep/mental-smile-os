# EX-65 AuditEvent Boundary Approval

## Current Source

Reviewed:

- `clean_core/lib/core/audit/audit_event.dart`

The current host-side `AuditEvent` imports `cloud_firestore`, local audit vocabulary contracts, `AuditReference`, and `AuditRuntimeMarker`. It owns Firestore serialization through `toMap`, `FieldValue.serverTimestamp()`, and `Timestamp.fromDate`.

## Future Pure Model Boundary

A future package-safe `AuditEvent` can be introduced as a pure model only if it contains passive data fields:

- actor type
- event type
- severity
- visibility scope
- actorId
- sanitizedPreview
- policyVersion
- references
- processingContext
- createdAt

## Boundary Approval

The package model boundary is viable with caveats:

- must use package-safe audit vocabulary only
- must use `AuditProcessingContext`, not `AuditRuntimeMarker`
- must use `DateTime?` for `createdAt`
- must not import Firestore
- must not own `toMap` or `fromMap`
- must not imply authority, persistence, runtime execution, provider execution, or access enforcement

## Verdict

Approved for future controlled additive split with caveats.
