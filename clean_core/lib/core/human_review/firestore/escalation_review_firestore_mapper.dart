import 'package:cloud_firestore/cloud_firestore.dart';

import '../escalation_audit_link.dart';
import '../escalation_review.dart';
import '../escalation_state.dart';

class EscalationReviewFirestoreMapper {
  const EscalationReviewFirestoreMapper._();

  static Map<String, Object?> toFirestoreMap(
    EscalationReview review, {
    bool useServerTimestamp = false,
  }) {
    return {
      'escalationId': review.escalationId,
      'reviewerId': review.reviewerId,
      'state': review.state.key,
      'sanitizedReviewNote': review.sanitizedReviewNote,
      'auditLink': _auditLinkToMap(review.auditLink),
      'reviewedAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(review.reviewedAt),
    };
  }

  static EscalationReview fromFirestoreMap(
    Map<String, Object?> map,
  ) {
    return EscalationReview(
      escalationId: map['escalationId'] as String? ?? '',
      reviewerId: map['reviewerId'] as String? ?? '',
      state: _stateOrDefault(map['state']),
      sanitizedReviewNote: map['sanitizedReviewNote'] as String? ?? '',
      auditLink: _auditLinkOrDefault(map['auditLink']),
      reviewedAt: _dateTimeOrNull(map['reviewedAt']),
    );
  }

  static Map<String, Object?> _auditLinkToMap(
    EscalationAuditLink auditLink,
  ) {
    return {
      'auditId': auditLink.auditId,
      'traceHash': auditLink.traceHash,
      'policyVersion': auditLink.policyVersion,
    };
  }

  static EscalationAuditLink _auditLinkOrDefault(Object? value) {
    final auditLink = value is Map ? value : const <Object?, Object?>{};
    return EscalationAuditLink(
      auditId: auditLink['auditId'] as String? ?? '',
      traceHash: auditLink['traceHash'] as String? ?? '',
      policyVersion: auditLink['policyVersion'] as String? ?? '',
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
