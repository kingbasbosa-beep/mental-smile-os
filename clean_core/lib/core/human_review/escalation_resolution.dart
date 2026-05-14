import 'package:cloud_firestore/cloud_firestore.dart';

import 'escalation_audit_link.dart';
import 'escalation_state.dart';

class EscalationResolution {
  const EscalationResolution({
    required this.escalationId,
    required this.resolvedBy,
    required this.state,
    required this.outcomeKey,
    required this.sanitizedResolutionNote,
    required this.auditLink,
    this.resolvedAt,
  });

  final String escalationId;
  final String resolvedBy;
  final EscalationState state;
  final String outcomeKey;
  final String sanitizedResolutionNote;
  final EscalationAuditLink auditLink;
  final DateTime? resolvedAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      'escalationId': escalationId,
      'resolvedBy': resolvedBy,
      'state': state.key,
      'outcomeKey': outcomeKey,
      'sanitizedResolutionNote': sanitizedResolutionNote,
      'auditLink': auditLink.toMap(),
      'resolvedAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(resolvedAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
