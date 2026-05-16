# EX-37 Reconnect Candidate Inventory

Phase: EX-37 - Wave 2 Safe Batch Reconnect Simulation

## Safe or Low-Risk Candidate Types

Potential safe reconnect candidates are files that:

- consume moved contracts only as labels or value objects
- do not execute runtime behavior
- do not connect Firebase/provider systems
- do not create authority or queue execution
- can import from the public package barrel without exposing hidden files

## Audit Reconnect Candidates

| File | Consumes moved contracts | Simulated classification |
| --- | --- | --- |
| `audit_event.dart` | actor, event type, reference, severity, visibility | Manual review reconnect |
| `audit_trace.dart` | audit reference | Manual review reconnect |
| `audit_snapshot.dart` | audit visibility scope | Manual review reconnect |
| `safety_observability_contract.dart` | audit reference | Runtime/observability-sensitive reconnect |

## Human Review Reconnect Candidates

| File | Consumes moved contracts | Simulated classification |
| --- | --- | --- |
| `escalation_assignment.dart` | escalation state | Manual review reconnect |
| `escalation_queue.dart` | reason, state, priority, visibility | Blocked/manual review due queue semantics |
| `escalation_request.dart` | level, reason, state, priority, visibility, audit link, policy reference | Manual review reconnect; escalation-sensitive |
| `escalation_resolution.dart` | audit link, state | Manual review reconnect; authority-sensitive |
| `escalation_review.dart` | audit link, state | Manual review reconnect; review-sensitive |

## Test Reconnect Candidates

No new test reconnect target was identified for the moved audit/human-review safe batches during this simulation.

Existing scoped tests remain related to previous backend-boundary reconnects and are not part of the Wave 2 safe-batch reconnect scope.

