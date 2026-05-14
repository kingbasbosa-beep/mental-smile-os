import 'package:cloud_firestore/cloud_firestore.dart';

import 'ai_safety_fields.dart';

class AiSafetyTrace {
  const AiSafetyTrace({
    required this.uid,
    required this.eventId,
    required this.traceHash,
    required this.policyVersion,
    required this.runtimeMode,
    required this.sanitizedPreview,
    this.createdAt,
  });

  final String uid;
  final String eventId;
  final String traceHash;
  final String policyVersion;
  final String runtimeMode;
  final String sanitizedPreview;
  final DateTime? createdAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      AiSafetyFields.uid: uid,
      AiSafetyFields.eventId: eventId,
      AiSafetyFields.traceHash: traceHash,
      AiSafetyFields.policyVersion: policyVersion,
      AiSafetyFields.runtimeMode: runtimeMode,
      AiSafetyFields.sanitizedPreview: sanitizedPreview,
      AiSafetyFields.createdAt: useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(createdAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
