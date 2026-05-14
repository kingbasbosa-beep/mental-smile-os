enum AiSafetySeverity {
  none,
  low,
  medium,
  high,
  urgent,
}

extension AiSafetySeverityKey on AiSafetySeverity {
  String get key {
    switch (this) {
      case AiSafetySeverity.none:
        return 'none';
      case AiSafetySeverity.low:
        return 'low';
      case AiSafetySeverity.medium:
        return 'medium';
      case AiSafetySeverity.high:
        return 'high';
      case AiSafetySeverity.urgent:
        return 'urgent';
    }
  }
}

AiSafetySeverity aiSafetySeverityFromKey(String value) {
  final key = value.trim();
  for (final severity in AiSafetySeverity.values) {
    if (severity.key == key) return severity;
  }
  return AiSafetySeverity.none;
}
