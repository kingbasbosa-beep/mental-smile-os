import 'package:cloud_firestore/cloud_firestore.dart';

import 'ai_safety_fields.dart';
import 'ai_safety_severity.dart';

class AiSafetyIncident {
  const AiSafetyIncident({
    required this.uid,
    required this.severity,
    required this.riskLevel,
    required this.escalationSuggested,
    required this.policyVersion,
    required this.reviewedByAdmin,
    required this.sanitizedPreview,
    required this.traceHash,
    required this.runtimeMode,
    required this.status,
    this.createdAt,
  });

  final String uid;
  final AiSafetySeverity severity;
  final String riskLevel;
  final bool escalationSuggested;
  final String policyVersion;
  final bool reviewedByAdmin;
  final String sanitizedPreview;
  final String traceHash;
  final String runtimeMode;
  final String status;
  final DateTime? createdAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      AiSafetyFields.uid: uid,
      AiSafetyFields.severity: severity.key,
      AiSafetyFields.riskLevel: riskLevel,
      AiSafetyFields.escalationSuggested: escalationSuggested,
      AiSafetyFields.policyVersion: policyVersion,
      AiSafetyFields.reviewedByAdmin: reviewedByAdmin,
      AiSafetyFields.sanitizedPreview: sanitizedPreview,
      AiSafetyFields.traceHash: traceHash,
      AiSafetyFields.runtimeMode: runtimeMode,
      AiSafetyFields.status: status,
      AiSafetyFields.createdAt: useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(createdAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
