import 'package:cloud_firestore/cloud_firestore.dart';

import 'escalation_audit_link.dart';
import 'escalation_state.dart';

class EscalationReview {
  const EscalationReview({
    required this.escalationId,
    required this.reviewerId,
    required this.state,
    required this.sanitizedReviewNote,
    required this.auditLink,
    this.reviewedAt,
  });

  final String escalationId;
  final String reviewerId;
  final EscalationState state;
  final String sanitizedReviewNote;
  final EscalationAuditLink auditLink;
  final DateTime? reviewedAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      'escalationId': escalationId,
      'reviewerId': reviewerId,
      'state': state.key,
      'sanitizedReviewNote': sanitizedReviewNote,
      'auditLink': auditLink.toMap(),
      'reviewedAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(reviewedAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
