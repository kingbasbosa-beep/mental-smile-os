# EX-41B Audit Consumer Graph

Phase: EX-41B - Consumer Dependency Topology Audit

## Local Audit Import Graph

Audit consumer files and their sibling dependencies:

| Consumer | Consumed audit contracts | Coupling |
| --- | --- | --- |
| `audit_event.dart` | `audit_actor_type`, `audit_event_type`, `audit_reference`, `audit_runtime_marker`, `audit_severity`, `audit_visibility_scope` | Firestore-coupled aggregate |
| `audit_snapshot.dart` | `audit_visibility_scope` | Firestore-coupled snapshot |
| `audit_trace.dart` | `audit_reference`, `audit_runtime_marker` | Firestore-coupled trace |
| `safety_observability_contract.dart` | `audit_reference`, `audit_runtime_marker` | observability-sensitive contract |

## Safe Contracts Consumed by Excluded Files

The attempted Wave 2 Audit Batch A1 files are consumed by excluded audit files:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_reference.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Safe Leaf Candidates

Potential extraction-safe leaf files with no observed local imports:

- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_retention_policy.dart`

These still require external consumer review before movement.

## Firestore-Coupled Cluster

Firestore-coupled audit consumers:

- `audit_event.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`

These should not move as-is into the pure package without splitting Firestore timestamp mapping from pure contract data.

## Observability-Sensitive Cluster

Observability-sensitive consumer:

- `safety_observability_contract.dart`

This should remain blocked until observability isolation and runtime/telemetry semantics are reviewed.

## Audit Graph Finding

The audit safe batch was consumer-bound. Moving it alone broke the remaining audit graph because excluded consumers still required sibling access to moved contracts.

