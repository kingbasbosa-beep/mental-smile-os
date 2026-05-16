# EX-40 Wave 2 Blocked Surface

Phase: EX-40 - Wave 2 Safe Extraction Milestone Report

## Audit Blocked Surface

Still excluded from package movement/export:

- `audit_event.dart`
- `audit_runtime_marker.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `safety_observability_contract.dart`

Reasons:

- runtime marker semantics
- observability sensitivity
- trace/snapshot lifecycle concerns
- audit event aggregation semantics
- future reconnect pressure requiring review

## Human Review Blocked Surface

Still excluded from package movement/export:

- `escalation_assignment.dart`
- `escalation_boundary_marker.dart`
- `escalation_queue.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

Reasons:

- queue semantics
- boundary marker authority risk
- assignment/routing implications
- request/resolution/review authority semantics
- escalation execution risk

## Platform Blocked Surface

Still blocked:

- runtime markers
- observability contracts
- queues
- boundary markers
- Firestore-coupled files
- adapters
- provider bridges
- Firebase bridges
- telemetry/runtime systems
- escalation execution semantics

## Blocked Surface Finding

Wave 2 intentionally extracted only safe declarative labels and references. Runtime, queue, boundary, observability, authority, and Firebase-adjacent areas remain blocked until future governance phases.

