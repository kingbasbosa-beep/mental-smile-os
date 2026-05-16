# EX-54 Audit Event Firestore Coupling

Phase: EX-54 - audit_event Split Design

## Firestore Coupling

Firestore coupling exists through:

- `package:cloud_firestore/cloud_firestore.dart`
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- `Timestamp?`
- Firestore-oriented `toMap(...)`

## Firestore Map Ownership

Current map fields:

- `eventType`
- `severity`
- `actorType`
- `actorId`
- `visibilityScope`
- `sanitizedPreview`
- `policyVersion`
- `references`
- `runtimeMarker`
- `createdAt`

## Nested Serialization

Current `toMap` delegates to:

- `reference.toMap()`
- `runtimeMarker.toMap()`

This means a future mapper must own nested conversion policy, not only timestamp conversion.

## Missing Deserialization

There is no current `fromMap`.

If future mapper adds deserialization, it must remain host/backend-owned and must not create backend authority or runtime activation.

## Firestore Coupling Finding

`audit_event.dart` cannot move as-is. Firestore serialization and nested map conversion must be separated before any pure package extraction.

