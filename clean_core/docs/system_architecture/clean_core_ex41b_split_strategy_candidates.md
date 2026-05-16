# EX-41B Split Strategy Candidates

Phase: EX-41B - Consumer Dependency Topology Audit

## Split Goal

Future extraction should separate pure contract data from host/backend-owned mapping and runtime coupling.

## Audit Split Candidates

### `audit_event.dart`

Potential split:

- pure audit event contract without Firestore imports
- host/backend mapper for `Timestamp` and `FieldValue.serverTimestamp()`

### `audit_snapshot.dart`

Potential split:

- pure snapshot contract
- Firestore timestamp mapper outside package

### `audit_trace.dart`

Potential split:

- pure trace contract
- Firestore timestamp mapper outside package

### `safety_observability_contract.dart`

Potential split:

- pure observability reference contract after observability review
- telemetry/runtime adapter remains host/backend-owned

## Human Review Split Candidates

### `escalation_assignment.dart`

Potential split:

- pure assignment contract
- Firestore timestamp mapper outside package

### `escalation_request.dart`

Potential split:

- pure request contract after boundary marker review
- Firestore timestamp mapper outside package
- boundary authority remains backend-governed

### `escalation_resolution.dart`

Potential split:

- pure resolution contract
- Firestore timestamp mapper outside package
- resolution authority remains backend/human-review governed

### `escalation_review.dart`

Potential split:

- pure review contract
- Firestore timestamp mapper outside package
- review authority remains backend/human-review governed

### `escalation_queue.dart`

Potential split:

- pure queue vocabulary only if approved
- queue routing/execution remains host/backend-owned

## Split Strategy Finding

The next successful extraction path should split Firestore mapping and execution semantics before moving consumer-bound contracts.

