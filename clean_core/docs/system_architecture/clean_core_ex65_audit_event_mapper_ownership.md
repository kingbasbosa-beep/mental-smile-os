# EX-65 AuditEvent Mapper Ownership

## Mapper Responsibilities

A future host-side mapper must own:

- Firestore serialization
- Firestore field names
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- nested `AuditReference` mapping
- runtime-marker to processing-context translation
- null timestamp handling
- compatibility with existing host storage shape

## Package Restrictions

The package-safe `AuditEvent` must not own:

- Firestore imports
- `Timestamp`
- `FieldValue`
- `toMap` / `fromMap` persistence logic
- backend persistence semantics
- runtime-marker interpretation

## Recommended Mapper Location

Future mapper location should remain host-owned, such as:

- `clean_core/lib/core/audit/firestore/audit_event_firestore_mapper.dart`

## Verdict

Mapper ownership is clear and must remain outside `mental_smile_clean_core`.
