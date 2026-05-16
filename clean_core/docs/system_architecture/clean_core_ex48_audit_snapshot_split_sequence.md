# EX-48 Audit Snapshot Split Sequence

Phase: EX-48 - audit_snapshot Split Design

## Future Execution Sequence

No split was executed in EX-48.

Recommended future sequence:

1. approve pure contract name and destination
2. create or transform pure `AuditSnapshot` contract without Firestore imports
3. create host/backend Firestore mapper outside `mental_smile_clean_core`
4. preserve current mapper behavior in host/backend layer
5. verify consumers still compile under local sibling imports or approved package strategy
6. move pure contract only after mapper boundary is established
7. add explicit package export only after export approval
8. perform post-split verification

## Suggested Package Destination

Future pure contract destination:

- `mental_smile_clean_core/lib/src/audit/audit_snapshot.dart`

Only after Firestore mapper logic is removed or relocated.

## Suggested Mapper Destination

Future mapper destination should be outside the pure package, such as a host/backend-owned Firebase mapper area.

## Split Sequence Finding

The split should happen before movement. Moving the current file as-is would contaminate the pure package with Firestore.

