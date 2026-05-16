# EX-61 Audit Event Firestore Mapper Plan

Phase: EX-61 - audit_event Split Simulation V2

## Simulated Mapper File

Future host-side mapper:

- `clean_core/lib/core/audit/firestore/audit_event_firestore_mapper.dart`

## Mapper Ownership

The mapper remains host/backend-owned and outside `mental_smile_clean_core`.

## Mapper Responsibilities

Mapper owns:

- `cloud_firestore` import
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- timestamp null handling
- Firestore field names
- nested audit reference map conversion
- runtime marker to processing context translation
- future deserialization, if introduced

## Nested Reference Mapping

The mapper must decide how to map:

- `List<AuditReference>`

into package-safe references or Firestore maps.

This remains a secondary blocker unless `AuditReference` becomes package-safe or is converted to primitive reference maps by the mapper.

## Mapper Finding

The mapper can own all Firestore and runtime-marker translation concerns, but nested reference strategy must be resolved before execution.

