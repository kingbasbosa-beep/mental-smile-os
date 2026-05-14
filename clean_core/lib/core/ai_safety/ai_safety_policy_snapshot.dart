import 'package:cloud_firestore/cloud_firestore.dart';

import 'ai_safety_fields.dart';

class AiSafetyPolicySnapshot {
  const AiSafetyPolicySnapshot({
    required this.policyVersion,
    required this.createdBy,
    required this.hashPlaceholder,
    required this.runtimeMode,
    required this.enabledSafetyModules,
    this.createdAt,
  });

  final String policyVersion;
  final String createdBy;
  final String hashPlaceholder;
  final String runtimeMode;
  final List<String> enabledSafetyModules;
  final DateTime? createdAt;

  Map<String, Object?> toMap({bool useServerTimestamp = false}) {
    return {
      AiSafetyFields.policyVersion: policyVersion,
      AiSafetyFields.createdBy: createdBy,
      AiSafetyFields.hashPlaceholder: hashPlaceholder,
      AiSafetyFields.runtimeMode: runtimeMode,
      AiSafetyFields.enabledSafetyModules: enabledSafetyModules,
      AiSafetyFields.createdAt: useServerTimestamp
          ? FieldValue.serverTimestamp()
          : _timestampOrNull(createdAt),
    };
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    return value == null ? null : Timestamp.fromDate(value);
  }
}
