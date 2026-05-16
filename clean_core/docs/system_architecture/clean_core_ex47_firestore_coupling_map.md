# EX-47 Firestore Coupling Map

Phase: EX-47 - Mapper Split Strategy

## Firestore Imports

All target files import:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
```

## Firestore Types and APIs

All target files use:

- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- `Timestamp?`

## Server Timestamp Behavior

Each target uses the same pattern:

```dart
toMap({bool useServerTimestamp = false})
```

When `useServerTimestamp` is true, the map uses `FieldValue.serverTimestamp()`.

When false, the map uses local `DateTime?` converted through `Timestamp.fromDate(...)`.

## Coupling Impact

This makes the files not package-safe for pure `mental_smile_clean_core` extraction because pure models must not depend on Cloud Firestore.

## Mapper Requirement

Future Firestore mappers must own:

- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- Firestore map shape
- Firestore-specific null handling
- server timestamp choice

## Coupling Finding

The current files are not pure models. They are combined model-plus-Firestore-mapper classes.

