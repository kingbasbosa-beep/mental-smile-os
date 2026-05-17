/// Passive escalation level vocabulary.
///
/// Escalation level labels are metadata only. They do not guarantee routing,
/// escalation execution, emergency handling, review assignment, or backend
/// response.
enum EscalationLevel {
  none,
  low,
  medium,
  high,
  urgent,
}

extension EscalationLevelKey on EscalationLevel {
  String get key {
    switch (this) {
      case EscalationLevel.none:
        return 'none';
      case EscalationLevel.low:
        return 'low';
      case EscalationLevel.medium:
        return 'medium';
      case EscalationLevel.high:
        return 'high';
      case EscalationLevel.urgent:
        return 'urgent';
    }
  }
}
