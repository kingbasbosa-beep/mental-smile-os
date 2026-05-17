import 'package:cloud_firestore/cloud_firestore.dart';

import '../audit_actor_type.dart';
import '../audit_event.dart';
import '../audit_event_type.dart';
import '../audit_reference.dart';
import '../audit_runtime_marker.dart';
import '../audit_severity.dart';
import '../audit_visibility_scope.dart';

class AuditEventFirestoreMapper {
  const AuditEventFirestoreMapper._();

  static Map<String, Object?> toFirestoreMap(
    AuditEvent event, {
    bool useServerTimestamp = false,
  }) {
    return {
      'eventType': event.eventType.key,
      'severity': event.severity.key,
      'actorType': event.actorType.key,
      'actorId': event.actorId,
      'visibilityScope': event.visibilityScope.key,
      'sanitizedPreview': event.sanitizedPreview,
      'policyVersion': event.policyVersion,
      'references': event.references.map(_referenceToMap).toList(),
      'runtimeMarker': _runtimeMarkerToMap(event.runtimeMarker),
      'createdAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(event.createdAt),
    };
  }

  static AuditEvent fromFirestoreMap(
    Map<String, Object?> map,
  ) {
    return AuditEvent(
      eventType: _eventTypeOrDefault(map['eventType']),
      severity: _severityOrDefault(map['severity']),
      actorType: _actorTypeOrDefault(map['actorType']),
      actorId: map['actorId'] as String? ?? '',
      visibilityScope: _visibilityScopeOrDefault(map['visibilityScope']),
      sanitizedPreview: map['sanitizedPreview'] as String? ?? '',
      policyVersion: map['policyVersion'] as String? ?? '',
      references: _referencesOrEmpty(map['references']),
      runtimeMarker: _runtimeMarkerOrDefault(map['runtimeMarker']),
      createdAt: _dateTimeOrNull(map['createdAt']),
    );
  }

  static Map<String, Object?> _referenceToMap(AuditReference reference) {
    return {
      'collectionPath': reference.collectionPath,
      'documentId': reference.documentId,
      'hashPlaceholder': reference.hashPlaceholder,
    };
  }

  static List<AuditReference> _referencesOrEmpty(Object? value) {
    if (value is! Iterable) return const [];
    return value
        .whereType<Map>()
        .map((reference) => AuditReference(
              collectionPath: reference['collectionPath'] as String? ?? '',
              documentId: reference['documentId'] as String? ?? '',
              hashPlaceholder: reference['hashPlaceholder'] as String? ?? '',
            ))
        .toList();
  }

  static Map<String, Object?> _runtimeMarkerToMap(
    AuditRuntimeMarker marker,
  ) {
    return {
      'runtimeMode': marker.runtimeMode,
      'providerId': marker.providerId,
      'policyVersion': marker.policyVersion,
      'fallbackReason': marker.fallbackReason,
    };
  }

  static AuditRuntimeMarker _runtimeMarkerOrDefault(Object? value) {
    final marker = value is Map ? value : const <Object?, Object?>{};
    return AuditRuntimeMarker(
      runtimeMode: marker['runtimeMode'] as String? ?? '',
      providerId: marker['providerId'] as String? ?? '',
      policyVersion: marker['policyVersion'] as String? ?? '',
      fallbackReason: marker['fallbackReason'] as String? ?? '',
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

  static AuditEventType _eventTypeOrDefault(Object? value) {
    if (value is AuditEventType) return value;
    if (value is String) {
      for (final type in AuditEventType.values) {
        if (type.key == value) return type;
      }
    }
    return AuditEventType.policyBlocked;
  }

  static AuditSeverity _severityOrDefault(Object? value) {
    if (value is AuditSeverity) return value;
    if (value is String) {
      for (final severity in AuditSeverity.values) {
        if (severity.key == value) return severity;
      }
    }
    return AuditSeverity.info;
  }

  static AuditActorType _actorTypeOrDefault(Object? value) {
    if (value is AuditActorType) return value;
    if (value is String) {
      for (final actorType in AuditActorType.values) {
        if (actorType.key == value) return actorType;
      }
    }
    return AuditActorType.system;
  }

  static AuditVisibilityScope _visibilityScopeOrDefault(Object? value) {
    if (value is AuditVisibilityScope) return value;
    if (value is String) {
      for (final scope in AuditVisibilityScope.values) {
        if (scope.key == value) return scope;
      }
    }
    return AuditVisibilityScope.privateUser;
  }
}
