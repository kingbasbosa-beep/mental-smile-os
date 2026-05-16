# clean_core Wave 2 Safe Batches Stop Conditions

Stop movement immediately if any condition below appears.

## Scope Stop Conditions

- Any excluded file is included.
- Audit and human review batches are merged in a way that weakens rollback clarity.
- Whole directory movement is proposed.
- Runtime/queue/boundary marker files are touched.
- Firestore-coupled files are touched.

## Import Stop Conditions

- Firebase import appears.
- Flutter import appears.
- provider SDK import appears.
- networking import appears.
- app-owned import appears.
- generated import appears.

## Export Stop Conditions

- wildcard export appears.
- directory-wide export appears.
- Firestore-coupled export appears.
- runtime marker export appears.
- queue/boundary marker export appears.

## Reconnect Stop Conditions

- host imports are migrated during movement.
- adapters are implemented.
- Firebase/provider/runtime reconnect is proposed.
- routing/localization/assets reconnect is proposed.

## Stop Verdict

Movement remains approved only while each batch stays exact, narrow, pure, and disconnected.
