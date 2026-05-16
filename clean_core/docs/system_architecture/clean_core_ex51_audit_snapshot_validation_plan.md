# EX-51 Audit Snapshot Validation Plan

Phase: EX-51 - audit_snapshot Controlled Split Execution Review

## Validation Sequence

Future validation sequence after controlled execution:

1. verify pure model file exists in package
2. verify mapper file exists outside package
3. verify existing compatibility file still exists
4. verify package barrel has at most one new explicit export
5. verify no Firestore import exists in package model
6. verify mapper owns Firestore import and timestamp conversion
7. verify no unrelated files changed
8. verify no reconnect occurred unless separately authorized
9. verify rollback scope remains local

## Manual Checks

Manual checks should confirm:

- no wildcard exports
- no package mapper export
- no runtime/provider/Firebase activation
- no audit event/trace/observability movement
- no queue/boundary movement

## Command Policy

Validation commands should run only if separately authorized.

No `pub get`, analyze, or tests are authorized by EX-51.

## Validation Finding

Validation should focus first on topology and boundary integrity before compile validation.

