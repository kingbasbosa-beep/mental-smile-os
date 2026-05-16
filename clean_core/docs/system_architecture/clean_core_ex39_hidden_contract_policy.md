# EX-39 Hidden Contract Policy

Phase: EX-39 - Package Surface Freeze

## Hidden Contract Definition

Hidden contracts are files that may be pure Dart but are not approved for public export because they imply runtime, authority, queue, observability, Firestore, or adapter behavior.

## Hidden by Default

The following categories remain hidden by default:

- guards not explicitly approved
- policies not explicitly approved
- locks
- resolvers
- profiles
- queues
- boundary markers
- runtime markers not explicitly approved
- observability contracts
- Firestore-coupled files
- audit event/trace/snapshot files
- escalation assignment/request/resolution/review files
- adapter bridge files
- runtime orchestration files

## Hidden Audit Contracts

Audit files hidden after EX-39:

- `audit_event.dart`
- `audit_runtime_marker.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `safety_observability_contract.dart`

## Hidden Human Review Contracts

Human review files hidden after EX-39:

- `escalation_assignment.dart`
- `escalation_boundary_marker.dart`
- `escalation_queue.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

## Hidden Contract Rule

Hidden contracts may not be exported because another exported file references the same vocabulary. Each file requires its own semantic review, import review, authority review, rollback plan, and checkpoint plan.

