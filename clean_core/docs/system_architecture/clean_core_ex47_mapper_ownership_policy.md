# EX-47 Mapper Ownership Policy

Phase: EX-47 - Mapper Split Strategy

## Mapper Ownership Rule

Firestore mappers are host/backend-owned.

They must not enter `mental_smile_clean_core`.

## Mapper Responsibilities

Mappers own:

- Firestore imports
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- `toMap` and future `fromMap` Firestore shapes
- Firestore null handling
- document field naming
- server timestamp write behavior

## Package Responsibilities

`mental_smile_clean_core` may own:

- pure contracts
- labels
- states
- references
- sanitized text fields
- policy references
- audit/review visibility vocabulary

## Backend Authority Rule

Mappers must not create authority by themselves.

Sensitive writes still require:

- backend authority
- review governance
- fail-closed behavior
- audit linkage
- Firestore rules enforcement

## Mapper Policy Finding

Mapping is integration behavior, not core contract behavior. It belongs outside the pure package.

