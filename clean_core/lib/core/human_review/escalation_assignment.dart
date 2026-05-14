import 'package:cloud_firestore/cloud_firestore.dart';

import 'escalation_state.dart';

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

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      'escalationId': escalationId,
      'assignedTo': assignedTo,
      'assignedBy': assignedBy,
      'state': state.key,
      'assignedAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(assignedAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
