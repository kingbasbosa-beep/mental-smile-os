class RuntimePolicyAuditLink {
  const RuntimePolicyAuditLink({
    required this.auditId,
    required this.traceHash,
    required this.policyVersion,
  });

  final String auditId;
  final String traceHash;
  final String policyVersion;

  Map<String, Object?> toMap() {
    return {
      'auditId': auditId,
      'traceHash': traceHash,
      'policyVersion': policyVersion,
    };
  }
}
