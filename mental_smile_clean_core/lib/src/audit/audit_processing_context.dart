class AuditProcessingContext {
  const AuditProcessingContext({
    required this.processingModeLabel,
    required this.providerLabel,
    required this.policyReferenceLabel,
    required this.fallbackReasonLabel,
  });

  // Passive audit labels only. These values do not prove runtime execution,
  // provider guarantees, orchestration ownership, or fallback approval.
  final String processingModeLabel;
  final String providerLabel;
  final String policyReferenceLabel;
  final String fallbackReasonLabel;
}
