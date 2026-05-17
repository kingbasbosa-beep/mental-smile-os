# EX-73 Human Review Authority Risk Review

## Authority-Coupled Files

- `escalation_boundary_marker.dart`
- `escalation_request.dart`
- `escalation_assignment.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`
- `escalation_queue.dart`

## Authority and Orchestration Findings

- `EscalationBoundaryMarker` contains `backendGoverned`, `clientOutcomeWritesAllowed`, and `emergencyGuarantee`; these are authority-sensitive labels and must not be exposed without caveats.
- `EscalationQueue.accepts` evaluates reason/priority/state membership and could be misread as routing authority or queue execution.
- `EscalationAssignment` carries `assignedTo`, `assignedBy`, and `state`; these may imply assignment authority unless mapper/host-owned.
- `EscalationResolution` carries `resolvedBy`, `outcomeKey`, and state; these may imply approval/resolution authority.
- `EscalationReview` carries `reviewerId`, state, and review note semantics; these may imply review authority.
- `EscalationRequest` combines level, reason, state, priority, visibility, audit link, policy reference, and boundary marker; it is the highest semantic-risk record.

## Required Detox Concepts

Future package-safe contracts may need a human-review equivalent of `AuditProcessingContext`, such as a passive review context or escalation context, to carry labels without implying queue routing, assignment power, approval authority, or emergency guarantees.

## Verdict

Authority semantics are manageable only with semantic freeze, caveats, additive split, host-side mappers, and compatibility preservation.
