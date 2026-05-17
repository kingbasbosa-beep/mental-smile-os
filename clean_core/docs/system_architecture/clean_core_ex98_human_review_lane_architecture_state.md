# EX-98 Human Review Lane Architecture State

## Package State

Package path:

- `mental_smile_clean_core/lib/src/human_review/`

Package surface is explicit-export only through:

- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

## Package Guarantees

- Pure Dart.
- Metadata-only.
- Declarative.
- No Firestore/Firebase.
- No `Timestamp`.
- No `FieldValue`.
- No `toMap` or `fromMap`.
- No persistence logic.
- No runtime/provider execution.

## Host State

Compatibility path remains:

- `clean_core/lib/core/human_review/`

Mapper path:

- `clean_core/lib/core/human_review/firestore/`

## Host Ownership

The host owns:

- Firestore serialization/deserialization;
- server timestamp behavior;
- field names;
- null/default handling;
- boundary marker storage;
- queue acceptance/routing;
- compatibility with existing storage shape.

## Architecture State Verdict

The lane is split into pure package contracts plus host-owned mappers and compatibility files.
