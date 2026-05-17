import 'escalation_state.dart';

/// Passive escalation assignment metadata.
///
/// `assignedTo` and `assignedBy` are metadata only. `state` does not progress
/// workflow, `assignedAt` does not prove backend scheduling or execution, and
/// this record does not route, approve, execute, or own escalation workflow.
class EscalationAssignment {
  const EscalationAssignment({
    required this.escalationId,
    required this.assignedTo,
    required this.assignedBy,
    required this.state,
    this.assignedAt,
  });

  final String escalationId;
  final String assignedTo;
  final String assignedBy;
  final EscalationState state;
  final DateTime? assignedAt;
}
