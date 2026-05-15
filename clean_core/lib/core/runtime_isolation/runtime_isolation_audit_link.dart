class RuntimeIsolationAuditLink {
  const RuntimeIsolationAuditLink({
    required this.auditId,
    required this.traceHashPlaceholder,
    required this.policyVersion,
  });

  final String auditId;
  final String traceHashPlaceholder;
  final String policyVersion;

  bool get isLinked =>
      auditId.trim().isNotEmpty &&
      traceHashPlaceholder.trim().isNotEmpty &&
      policyVersion.trim().isNotEmpty;

  static const empty = RuntimeIsolationAuditLink(
    auditId: '',
    traceHashPlaceholder: '',
    policyVersion: '',
  );
}
