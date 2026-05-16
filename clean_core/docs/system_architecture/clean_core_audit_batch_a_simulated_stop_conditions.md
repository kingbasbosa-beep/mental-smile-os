# clean_core Audit Batch A Simulated Stop Conditions

Stop future Audit Batch A movement immediately if any condition below appears.

## Contamination Stop Conditions

- Firebase import appears.
- Flutter import appears.
- provider SDK import appears.
- networking import appears.
- app-owned import appears.
- generated import appears.

## Scope Stop Conditions

- Any file outside the eight approved Batch A files is included.
- `audit_runtime_marker.dart` is included.
- `safety_observability_contract.dart` is included.
- `audit_event.dart`, `audit_trace.dart`, or `audit_snapshot.dart` is included.

## Export Stop Conditions

- wildcard export appears.
- directory-wide export appears.
- Firestore-coupled export appears.
- runtime marker or adapter-boundary export is bundled into Batch A.

## Reconnect Stop Conditions

- host imports are migrated during movement.
- Firebase/provider/runtime reconnect is proposed.
- adapters are implemented.
- package consumers import from `lib/src`.

## Stop Verdict

Batch A remains safe only while isolated to the exact eight files and explicit exports.
