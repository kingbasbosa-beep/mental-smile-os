# EX-51 Audit Snapshot Rollback Plan

Phase: EX-51 - audit_snapshot Controlled Split Execution Review

## Future Rollback Scope

Rollback should be limited to:

- package pure model file
- host/backend mapper file
- compatibility file edits
- one explicit package export line

## Rollback Steps

Future rollback sequence:

1. remove package pure model file
2. remove mapper file
3. restore compatibility file to original model-plus-Firestore shape
4. remove `export 'src/audit/audit_snapshot.dart';`
5. remove empty package audit folder only if appropriate
6. confirm no reconnect/import migration needs rollback

## Rollback Must Not Touch

Rollback must not touch:

- Wave 1 extracted files
- true leaf audit files
- pubspec files
- runtime/provider/Firebase systems
- adapters
- unrelated audit files
- human review files
- docs

## Rollback Finding

Rollback can remain local if execution preserves the compatibility file and avoids reconnect.

