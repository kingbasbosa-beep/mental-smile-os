class AuditSnapshot {
  const AuditSnapshot({
    required this.snapshotId,
    required this.policyVersion,
    required this.createdBy,
    required this.hashPlaceholder,
    required this.visibilityScope,
    required this.immutable,
    this.createdAt,
  });

  final String snapshotId;
  final String policyVersion;
  final String createdBy;
  final String hashPlaceholder;
  final String visibilityScope;
  final bool immutable;
  final DateTime? createdAt;
}
