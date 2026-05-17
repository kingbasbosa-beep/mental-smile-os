import 'package:cloud_firestore/cloud_firestore.dart';

import '../escalation_audit_link.dart';
import '../escalation_boundary_marker.dart';
import '../escalation_level.dart';
import '../escalation_policy_reference.dart';
import '../escalation_reason.dart';
import '../escalation_request.dart';
import '../escalation_state.dart';
import '../review_priority.dart';
import '../review_visibility_scope.dart';

class EscalationRequestFirestoreMapper {
  const EscalationRequestFirestoreMapper._();

  static Map<String, Object?> toFirestoreMap(
    EscalationRequest request, {
    bool useServerTimestamp = false,
    EscalationBoundaryMarker boundaryMarker =
        EscalationBoundaryMarker.safeDefault,
  }) {
    return {
      'uid': request.uid,
      'level': request.level.key,
      'reason': request.reason.key,
      'state': request.state.key,
      'priority': request.priority.key,
      'visibilityScope': request.visibilityScope.key,
      'sanitizedPreview': request.sanitizedPreview,
      'auditLink': _auditLinkToMap(request.auditLink),
      'policyReference': _policyReferenceToMap(request.policyReference),
      'boundaryMarker': _boundaryMarkerToMap(boundaryMarker),
      'createdAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(request.createdAt),
    };
  }

  static EscalationRequest fromFirestoreMap(
    Map<String, Object?> map,
  ) {
    return EscalationRequest(
      uid: map['uid'] as String? ?? '',
      level: _levelOrDefault(map['level']),
      reason: _reasonOrDefault(map['reason']),
      state: _stateOrDefault(map['state']),
      priority: _priorityOrDefault(map['priority']),
      visibilityScope: _visibilityScopeOrDefault(map['visibilityScope']),
      sanitizedPreview: map['sanitizedPreview'] as String? ?? '',
      auditLink: _auditLinkOrDefault(map['auditLink']),
      policyReference: _policyReferenceOrDefault(map['policyReference']),
      boundaryMarker: _boundaryMarkerOrDefault(map['boundaryMarker']),
      createdAt: _dateTimeOrNull(map['createdAt']),
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

  static Map<String, Object?> _policyReferenceToMap(
    EscalationPolicyReference policyReference,
  ) {
    return {
      'policyVersion': policyReference.policyVersion,
      'snapshotId': policyReference.snapshotId,
      'hashPlaceholder': policyReference.hashPlaceholder,
    };
  }

  static EscalationPolicyReference _policyReferenceOrDefault(Object? value) {
    final policyReference = value is Map ? value : const <Object?, Object?>{};
    return EscalationPolicyReference(
      policyVersion: policyReference['policyVersion'] as String? ?? '',
      snapshotId: policyReference['snapshotId'] as String? ?? '',
      hashPlaceholder: policyReference['hashPlaceholder'] as String? ?? '',
    );
  }

  static Map<String, Object?> _boundaryMarkerToMap(
    EscalationBoundaryMarker boundaryMarker,
  ) {
    return {
      'backendGoverned': boundaryMarker.backendGoverned,
      'clientOutcomeWritesAllowed': boundaryMarker.clientOutcomeWritesAllowed,
      'emergencyGuarantee': boundaryMarker.emergencyGuarantee,
    };
  }

  static EscalationBoundaryMarker _boundaryMarkerOrDefault(Object? value) {
    final boundaryMarker = value is Map ? value : const <Object?, Object?>{};
    return EscalationBoundaryMarker(
      backendGoverned:
          boundaryMarker['backendGoverned'] as bool? ??
              EscalationBoundaryMarker.safeDefault.backendGoverned,
      clientOutcomeWritesAllowed:
          boundaryMarker['clientOutcomeWritesAllowed'] as bool? ??
              EscalationBoundaryMarker
                  .safeDefault.clientOutcomeWritesAllowed,
      emergencyGuarantee:
          boundaryMarker['emergencyGuarantee'] as bool? ??
              EscalationBoundaryMarker.safeDefault.emergencyGuarantee,
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

  static EscalationLevel _levelOrDefault(Object? value) {
    if (value is EscalationLevel) return value;
    if (value is String) {
      for (final level in EscalationLevel.values) {
        if (level.key == value) return level;
      }
    }
    return EscalationLevel.none;
  }

  static EscalationReason _reasonOrDefault(Object? value) {
    if (value is EscalationReason) return value;
    if (value is String) {
      for (final reason in EscalationReason.values) {
        if (reason.key == value) return reason;
      }
    }
    return EscalationReason.manualSupportRequest;
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

  static ReviewPriority _priorityOrDefault(Object? value) {
    if (value is ReviewPriority) return value;
    if (value is String) {
      for (final priority in ReviewPriority.values) {
        if (priority.key == value) return priority;
      }
    }
    return ReviewPriority.low;
  }

  static ReviewVisibilityScope _visibilityScopeOrDefault(Object? value) {
    if (value is ReviewVisibilityScope) return value;
    if (value is String) {
      for (final scope in ReviewVisibilityScope.values) {
        if (scope.key == value) return scope;
      }
    }
    return ReviewVisibilityScope.restricted;
  }
}
