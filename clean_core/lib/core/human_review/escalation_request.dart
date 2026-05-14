import 'package:cloud_firestore/cloud_firestore.dart';

import 'escalation_audit_link.dart';
import 'escalation_boundary_marker.dart';
import 'escalation_level.dart';
import 'escalation_policy_reference.dart';
import 'escalation_reason.dart';
import 'escalation_state.dart';
import 'review_priority.dart';
import 'review_visibility_scope.dart';

class EscalationRequest {
  const EscalationRequest({
    required this.uid,
    required this.level,
    required this.reason,
    required this.state,
    required this.priority,
    required this.visibilityScope,
    required this.sanitizedPreview,
    required this.auditLink,
    required this.policyReference,
    this.boundaryMarker = EscalationBoundaryMarker.safeDefault,
    this.createdAt,
  });

  final String uid;
  final EscalationLevel level;
  final EscalationReason reason;
  final EscalationState state;
  final ReviewPriority priority;
  final ReviewVisibilityScope visibilityScope;
  final String sanitizedPreview;
  final EscalationAuditLink auditLink;
  final EscalationPolicyReference policyReference;
  final EscalationBoundaryMarker boundaryMarker;
  final DateTime? createdAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      'uid': uid,
      'level': level.key,
      'reason': reason.key,
      'state': state.key,
      'priority': priority.key,
      'visibilityScope': visibilityScope.key,
      'sanitizedPreview': sanitizedPreview,
      'auditLink': auditLink.toMap(),
      'policyReference': policyReference.toMap(),
      'boundaryMarker': boundaryMarker.toMap(),
      'createdAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(createdAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
