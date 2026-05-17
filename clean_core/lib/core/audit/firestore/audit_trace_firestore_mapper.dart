import 'package:cloud_firestore/cloud_firestore.dart';

import '../audit_reference.dart';
import '../audit_runtime_marker.dart';
import '../audit_trace.dart';

class AuditTraceFirestoreMapper {
  const AuditTraceFirestoreMapper._();

  static Map<String, Object?> toFirestoreMap(
    AuditTrace trace, {
    bool useServerTimestamp = false,
  }) {
    return {
      'traceId': trace.traceId,
      'traceHash': trace.traceHash,
      'policyVersion': trace.policyVersion,
      'runtimeMarker': _runtimeMarkerToMap(trace.runtimeMarker),
      'references': trace.references.map(_referenceToMap).toList(),
      'sanitizedPreview': trace.sanitizedPreview,
      'createdAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(trace.createdAt),
    };
  }

  static AuditTrace fromFirestoreMap(
    Map<String, Object?> map,
  ) {
    return AuditTrace(
      traceId: map['traceId'] as String? ?? '',
      traceHash: map['traceHash'] as String? ?? '',
      policyVersion: map['policyVersion'] as String? ?? '',
      runtimeMarker: _runtimeMarkerOrDefault(map['runtimeMarker']),
      references: _referencesOrEmpty(map['references']),
      sanitizedPreview: map['sanitizedPreview'] as String? ?? '',
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
    final processingLabels = _runtimeMarkerToProcessingLabels(marker);
    return {
      'runtimeMode': processingLabels['processingModeLabel'],
      'providerId': processingLabels['providerLabel'],
      'policyVersion': processingLabels['policyReferenceLabel'],
      'fallbackReason': processingLabels['fallbackReasonLabel'],
    };
  }

  static Map<String, String> _runtimeMarkerToProcessingLabels(
    AuditRuntimeMarker marker,
  ) {
    return {
      'processingModeLabel': marker.runtimeMode,
      'providerLabel': marker.providerId,
      'policyReferenceLabel': marker.policyVersion,
      'fallbackReasonLabel': marker.fallbackReason,
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
}
