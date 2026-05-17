# EX-94 EscalationRequest Mapper API Freeze

## Mapper API Decision

Use an optional host marker parameter with `EscalationBoundaryMarker.safeDefault`.

## Future `toFirestoreMap` Shape

The mapper should accept:

- package or compatibility request model value;
- `bool useServerTimestamp = false`;
- optional host-side `EscalationBoundaryMarker boundaryMarker = EscalationBoundaryMarker.safeDefault`.

The marker stays outside the package model while the mapper preserves the stored `boundaryMarker` field.

## Future `fromFirestoreMap` Shape

The mapper may return the package-safe request model and intentionally omit boundary marker from the returned package model. If host callers need boundary marker recovery, that should remain host-side and separate from the package model.

## Mapper Responsibilities

The mapper must own:

- `cloud_firestore` import
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- null/default handling
- vocabulary `.key` serialization
- vocabulary key deserialization
- nested audit-link serialization/deserialization
- nested policy-reference serialization/deserialization
- host boundary marker serialization for storage compatibility

## Mapper API Verdict

Optional host marker parameter is the safest balance: preserves existing storage shape without exposing boundary semantics in the package model.
