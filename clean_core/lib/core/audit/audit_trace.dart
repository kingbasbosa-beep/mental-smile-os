import 'package:cloud_firestore/cloud_firestore.dart';

import 'audit_reference.dart';
import 'audit_runtime_marker.dart';

class AuditTrace {
  const AuditTrace({
    required this.traceId,
    required this.traceHash,
    required this.policyVersion,
    required this.runtimeMarker,
    required this.references,
    required this.sanitizedPreview,
    this.createdAt,
  });

  final String traceId;
  final String traceHash;
  final String policyVersion;
  final AuditRuntimeMarker runtimeMarker;
  final List<AuditReference> references;
  final String sanitizedPreview;
  final DateTime? createdAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      'traceId': traceId,
      'traceHash': traceHash,
      'policyVersion': policyVersion,
      'runtimeMarker': runtimeMarker.toMap(),
      'references': references.map((reference) => reference.toMap()).toList(),
      'sanitizedPreview': sanitizedPreview,
      'createdAt': useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(createdAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
