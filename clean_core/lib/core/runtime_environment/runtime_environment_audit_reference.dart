class RuntimeEnvironmentAuditReference {
  const RuntimeEnvironmentAuditReference({
    required this.auditId,
    required this.traceHash,
    required this.policySnapshotId,
  });

  final String auditId;
  final String traceHash;
  final String policySnapshotId;

  Map<String, Object?> toMap() {
    return {
      'auditId': auditId,
      'traceHash': traceHash,
      'policySnapshotId': policySnapshotId,
    };
  }
}
