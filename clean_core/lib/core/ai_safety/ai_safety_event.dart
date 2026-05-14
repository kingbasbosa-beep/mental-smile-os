import 'package:cloud_firestore/cloud_firestore.dart';

import 'ai_safety_event_type.dart';
import 'ai_safety_fields.dart';
import 'ai_safety_severity.dart';

class AiSafetyEvent {
  const AiSafetyEvent({
    required this.uid,
    required this.eventType,
    required this.severity,
    required this.riskLevel,
    required this.confidence,
    required this.triggers,
    required this.responseMode,
    required this.escalationSuggested,
    required this.outputValidated,
    required this.policyVersion,
    required this.reviewedByAdmin,
    required this.sanitizedPreview,
    required this.traceHash,
    required this.runtimeMode,
    this.createdAt,
  });

  final String uid;
  final AiSafetyEventType eventType;
  final AiSafetySeverity severity;
  final String riskLevel;
  final double confidence;
  final List<String> triggers;
  final String responseMode;
  final bool escalationSuggested;
  final bool outputValidated;
  final String policyVersion;
  final bool reviewedByAdmin;
  final String sanitizedPreview;
  final String traceHash;
  final String runtimeMode;
  final DateTime? createdAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      AiSafetyFields.uid: uid,
      AiSafetyFields.eventType: eventType.key,
      AiSafetyFields.severity: severity.key,
      AiSafetyFields.riskLevel: riskLevel,
      AiSafetyFields.confidence: confidence,
      AiSafetyFields.triggers: triggers,
      AiSafetyFields.responseMode: responseMode,
      AiSafetyFields.escalationSuggested: escalationSuggested,
      AiSafetyFields.outputValidated: outputValidated,
      AiSafetyFields.policyVersion: policyVersion,
      AiSafetyFields.reviewedByAdmin: reviewedByAdmin,
      AiSafetyFields.sanitizedPreview: sanitizedPreview,
      AiSafetyFields.traceHash: traceHash,
      AiSafetyFields.runtimeMode: runtimeMode,
      AiSafetyFields.createdAt: useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(createdAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
