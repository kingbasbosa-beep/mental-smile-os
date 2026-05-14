enum AiSafetyEventType {
  unknown,
  consentChecked,
  safetyDisclosureShown,
  fallbackResponseUsed,
  riskSignalDetected,
  escalationSuggested,
  outputValidationFailed,
  policySnapshotApplied,
}

extension AiSafetyEventTypeKey on AiSafetyEventType {
  String get key {
    switch (this) {
      case AiSafetyEventType.unknown:
        return 'unknown';
      case AiSafetyEventType.consentChecked:
        return 'consent_checked';
      case AiSafetyEventType.safetyDisclosureShown:
        return 'safety_disclosure_shown';
      case AiSafetyEventType.fallbackResponseUsed:
        return 'fallback_response_used';
      case AiSafetyEventType.riskSignalDetected:
        return 'risk_signal_detected';
      case AiSafetyEventType.escalationSuggested:
        return 'escalation_suggested';
      case AiSafetyEventType.outputValidationFailed:
        return 'output_validation_failed';
      case AiSafetyEventType.policySnapshotApplied:
        return 'policy_snapshot_applied';
    }
  }
}

AiSafetyEventType aiSafetyEventTypeFromKey(String value) {
  final key = value.trim();
  for (final type in AiSafetyEventType.values) {
    if (type.key == key) return type;
  }
  return AiSafetyEventType.unknown;
}
