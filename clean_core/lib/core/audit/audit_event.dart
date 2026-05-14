import 'package:cloud_firestore/cloud_firestore.dart';

import 'audit_actor_type.dart';
import 'audit_event_type.dart';
import 'audit_reference.dart';
import 'audit_runtime_marker.dart';
import 'audit_severity.dart';
import 'audit_visibility_scope.dart';

class AuditEvent {
  const AuditEvent({
    required this.eventType,
    required this.severity,
    required this.actorType,
    required this.actorId,
    required this.visibilityScope,
    required this.sanitizedPreview,
    required this.policyVersion,
    required this.references,
    required this.runtimeMarker,
    this.createdAt,
  });

  final AuditEventType eventType;
  final AuditSeverity severity;
  final AuditActorType actorType;
  final String actorId;
  final AuditVisibilityScope visibilityScope;
  final String sanitizedPreview;
  final String policyVersion;
  final List<AuditReference> references;
  final AuditRuntimeMarker runtimeMarker;
  final DateTime? createdAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      'eventType': eventType.key,
      'severity': severity.key,
      'actorType': actorType.key,
      'actorId': actorId,
      'visibilityScope': visibilityScope.key,
      'sanitizedPreview': sanitizedPreview,
      'policyVersion': policyVersion,
      'references': references.map((reference) => reference.toMap()).toList(),
      'runtimeMarker': runtimeMarker.toMap(),
      'createdAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(createdAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
