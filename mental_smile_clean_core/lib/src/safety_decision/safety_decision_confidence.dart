enum SafetyDecisionConfidence {
  unknown,
  low,
  medium,
  high,
}

extension SafetyDecisionConfidenceKey on SafetyDecisionConfidence {
  String get key {
    switch (this) {
      case SafetyDecisionConfidence.unknown:
        return 'unknown';
      case SafetyDecisionConfidence.low:
        return 'low';
      case SafetyDecisionConfidence.medium:
        return 'medium';
      case SafetyDecisionConfidence.high:
        return 'high';
    }
  }
}
