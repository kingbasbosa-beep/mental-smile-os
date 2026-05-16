# EX-54 Audit Event Compatibility Strategy

Phase: EX-54 - audit_event Split Design

## Compatibility Requirement

Existing path must remain stable during any future split:

- `clean_core/lib/core/audit/audit_event.dart`

## Recommended Strategy

Use additive-first compatibility strategy:

1. add pure package model only after runtime-marker decision
2. add host/backend Firestore mapper outside package
3. keep existing `audit_event.dart` as compatibility source/facade initially
4. do not force consumer migration
5. do not reconnect imports during split execution

## Mapper Location Recommendation

Recommended mapper location:

- `clean_core/lib/core/audit/firestore/audit_event_firestore_mapper.dart`

## Compatibility Finding

Additive compatibility is possible, but more caveated than `audit_snapshot` because `audit_event` depends on multiple audit contracts and runtime marker semantics.

