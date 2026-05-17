/// Passive review priority vocabulary.
///
/// Priority labels are metadata only. They do not guarantee scheduling, queue
/// order, response time, assignment, escalation, review execution, or backend
/// action.
enum ReviewPriority {
  low,
  medium,
  high,
  urgent,
}

extension ReviewPriorityKey on ReviewPriority {
  String get key {
    switch (this) {
      case ReviewPriority.low:
        return 'low';
      case ReviewPriority.medium:
        return 'medium';
      case ReviewPriority.high:
        return 'high';
      case ReviewPriority.urgent:
        return 'urgent';
    }
  }
}
