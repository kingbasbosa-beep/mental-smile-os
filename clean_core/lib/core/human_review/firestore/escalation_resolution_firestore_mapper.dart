import 'package:cloud_firestore/cloud_firestore.dart';

import '../escalation_audit_link.dart';
import '../escalation_resolution.dart';
import '../escalation_state.dart';

class EscalationResolutionFirestoreMapper {
  const EscalationResolutionFirestoreMapper._();

  static Map<String, Object?> toFirestoreMap(
    EscalationResolution resolution, {
    bool useServerTimestamp = false,
  }) {
    return {
      'escalationId': resolution.escalationId,
      'resolvedBy': resolution.resolvedBy,
      'state': resolution.state.key,
      'outcomeKey': resolution.outcomeKey,
      'sanitizedResolutionNote': resolution.sanitizedResolutionNote,
      'auditLink': _auditLinkToMap(resolution.auditLink),
      'resolvedAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(resolution.resolvedAt),
    };
  }

  static EscalationResolution fromFirestoreMap(
    Map<String, Object?> map,
  ) {
    return EscalationResolution(
      escalationId: map['escalationId'] as String? ?? '',
      resolvedBy: map['resolvedBy'] as String? ?? '',
      state: _stateOrDefault(map['state']),
      outcomeKey: map['outcomeKey'] as String? ?? '',
      sanitizedResolutionNote: map['sanitizedResolutionNote'] as String? ?? '',
      auditLink: _auditLinkOrDefault(map['auditLink']),
      resolvedAt: _dateTimeOrNull(map['resolvedAt']),
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
