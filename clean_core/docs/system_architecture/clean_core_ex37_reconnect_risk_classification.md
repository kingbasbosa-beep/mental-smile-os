# EX-37 Reconnect Risk Classification

Phase: EX-37 - Wave 2 Safe Batch Reconnect Simulation

## Classification Rules

Reconnect candidates are classified by semantic risk, not only by import shape.

## Safe Reconnect Candidates

No immediate safe reconnect was approved for execution in this phase.

Future safe reconnect may be considered only for files that remain declarative after reconnect and require no runtime, queue, Firebase, provider, or adapter behavior.

## Manual-Review Reconnects

Manual-review reconnects include:

- `audit_event.dart`
- `audit_trace.dart`
- `audit_snapshot.dart`
- `escalation_assignment.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

These consume moved contracts but remain excluded from movement and require semantic review before any import change.

## Runtime-Sensitive Reconnects

Runtime-sensitive reconnects include:

- `safety_observability_contract.dart`

Reason: observability terminology can imply telemetry/runtime behavior even when imports are pure.

## Blocked or High-Risk Reconnects

Blocked/high-risk reconnects include:

- `escalation_queue.dart`

Reason: queue semantics can imply routing, assignment, escalation execution, or operational runtime behavior.

## Reconnect Risk Finding

Reconnect should not be automatic. The future reconnect lane must separate declarative consumers from queue, observability, review, and authority-sensitive consumers.

