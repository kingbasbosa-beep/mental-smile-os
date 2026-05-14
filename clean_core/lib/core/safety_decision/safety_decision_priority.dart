enum SafetyDecisionPriority {
  low,
  medium,
  high,
  urgent,
}

extension SafetyDecisionPriorityKey on SafetyDecisionPriority {
  String get key {
    switch (this) {
      case SafetyDecisionPriority.low:
        return 'low';
      case SafetyDecisionPriority.medium:
        return 'medium';
      case SafetyDecisionPriority.high:
        return 'high';
      case SafetyDecisionPriority.urgent:
        return 'urgent';
    }
  }
}
