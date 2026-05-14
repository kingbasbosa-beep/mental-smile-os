class SafetyRegistryAuditLink {
  const SafetyRegistryAuditLink({
    required this.auditId,
    required this.traceHash,
    required this.policyVersion,
  });

  final String auditId;
  final String traceHash;
  final String policyVersion;

  bool get isLinked {
    return auditId.trim().isNotEmpty &&
        traceHash.trim().isNotEmpty &&
        policyVersion.trim().isNotEmpty;
  }
}
