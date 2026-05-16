# EX-46 Next Phase Recommendation

Phase: EX-46 - Next True Leaf Discovery

## Recommendation

Do not execute another movement from the reviewed areas yet.

## Recommended Next Phases

Recommended next phase options:

1. Firestore mapper split planning for audit event/trace/snapshot.
2. Firestore mapper split planning for escalation assignment/request/resolution/review.
3. Queue/escalation semantic review for `escalation_queue.dart`.
4. Boundary authority review for `escalation_boundary_marker.dart`.
5. Package-aware consumer strategy before moving consumer-bound labels.

## Consumer-First Rule

Before any future movement:

- map consumers
- classify coupling
- decide whether consumers move together
- split mappers from pure contracts if Firestore exists
- confirm no reconnect is required or approve reconnect explicitly

## Next Phase Finding

The next phase should prepare a cluster/split strategy, not execute leaf movement.

