# clean_core Audit Lane Hidden Contracts

This document identifies files that should remain hidden/internal or review-required during any future audit lane movement.

## Hidden or Review-Required

| File | Reason |
| --- | --- |
| `audit_event.dart` | Firestore-coupled serialization and server timestamp behavior. |
| `audit_trace.dart` | Firestore-coupled serialization and server timestamp behavior. |
| `audit_snapshot.dart` | Firestore-coupled serialization and server timestamp behavior. |
| `safety_observability_contract.dart` | Adapter-boundary semantics involving runtime marker/provider id. |
| `audit_runtime_marker.dart` | Runtime/provider marker semantics require clear non-execution documentation. |

## Internal-Only Until Split

The Firestore-coupled files may become extractable only if split into:

- pure Dart contract model
- host-owned Firestore mapper/serializer

## Hidden Contract Verdict

No audit lane file should be exposed through a broad barrel. Review-required files should stay hidden until semantic and adapter boundaries are explicit.
