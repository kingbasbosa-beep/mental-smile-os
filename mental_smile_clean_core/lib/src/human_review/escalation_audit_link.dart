/// Passive escalation audit link metadata.
///
/// Audit references are metadata only. `auditId` does not prove audit
/// persistence, `traceHash` is not integrity proof, and `policyVersion` does
/// not enforce or approve policy.
class EscalationAuditLink {
  const EscalationAuditLink({
    required this.auditId,
    required this.traceHash,
    required this.policyVersion,
  });

  final String auditId;
  final String traceHash;
  final String policyVersion;
}
