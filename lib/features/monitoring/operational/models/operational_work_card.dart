class OperationalWorkCard {
  const OperationalWorkCard({
    required this.cardId,
    required this.departmentId,
    required this.cardType,
    required this.priority,
    required this.createdAt,
    required this.status,
    required this.summary,
    required this.sourceType,
    required this.sourceReference,
    required this.archiveCode,
    required this.reportPrefix,
    required this.period,
    this.receivedAt,
    this.acknowledgedAt,
    this.startedAt,
    this.resolvedAt,
    this.verifiedAt,
    this.archivedAt,
  });

  final String cardId;
  final String departmentId;
  final String cardType;
  final String priority;
  final DateTime createdAt;
  final DateTime? receivedAt;
  final DateTime? acknowledgedAt;
  final DateTime? startedAt;
  final DateTime? resolvedAt;
  final DateTime? verifiedAt;
  final DateTime? archivedAt;
  final String status;
  final String summary;
  final String sourceType;
  final String sourceReference;
  final String archiveCode;
  final String reportPrefix;
  final String period;

  bool get hasForbiddenSourceReference {
    final normalized = sourceReference.trim().toLowerCase();
    return normalized.contains('booking') ||
        normalized.contains('session') ||
        normalized.contains('payment') ||
        normalized.contains('payout') ||
        normalized.contains('assignment');
  }
}
