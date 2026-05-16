# clean_core Audit Batch A Stop Conditions

Stop any future Batch A movement if any condition below appears.

## Import Stop Conditions

- Firebase import appears.
- Flutter import appears.
- provider SDK import appears.
- networking import appears.
- app-owned `flutterprojects` import appears.
- generated localization/config import appears.

## Scope Stop Conditions

- Any excluded audit file is included.
- Whole `core/audit/` directory movement is proposed.
- `audit_event.dart`, `audit_trace.dart`, or `audit_snapshot.dart` is moved.
- `audit_runtime_marker.dart` or `safety_observability_contract.dart` is bundled into Batch A.

## Semantic Stop Conditions

- `trustedServer` is treated as backend authority.
- `trustedServerOnly` is treated as real auth enforcement.
- `runtimeDisabled` is treated as runtime control.
- `providerRejected` is treated as provider execution control.
- `protectedWriteDenied` is treated as write enforcement implementation.
- redaction contracts are bypassed or weakened.

## Export Stop Conditions

- wildcard export
- directory-wide export
- Firestore-coupled export
- runtime marker export
- adapter-boundary export

## Stop Verdict

Batch A remains approved only while it stays pure, declarative, narrow, and file-scoped.
