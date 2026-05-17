import 'package:cloud_firestore/cloud_firestore.dart';

import '../escalation_assignment.dart';
import '../escalation_state.dart';

class EscalationAssignmentFirestoreMapper {
  const EscalationAssignmentFirestoreMapper._();

  static Map<String, Object?> toFirestoreMap(
    EscalationAssignment assignment, {
    bool useServerTimestamp = false,
  }) {
    return {
      'escalationId': assignment.escalationId,
      'assignedTo': assignment.assignedTo,
      'assignedBy': assignment.assignedBy,
      'state': assignment.state.key,
      'assignedAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(assignment.assignedAt),
    };
  }

  static EscalationAssignment fromFirestoreMap(
    Map<String, Object?> map,
  ) {
    return EscalationAssignment(
      escalationId: map['escalationId'] as String? ?? '',
      assignedTo: map['assignedTo'] as String? ?? '',
      assignedBy: map['assignedBy'] as String? ?? '',
      state: _stateOrDefault(map['state']),
      assignedAt: _dateTimeOrNull(map['assignedAt']),
    );
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }

  static DateTime? _dateTimeOrNull(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }

  static EscalationState _stateOrDefault(Object? value) {
    if (value is EscalationState) return value;
    if (value is String) {
      for (final state in EscalationState.values) {
        if (state.key == value) return state;
      }
    }
    return EscalationState.pendingReview;
  }
}
