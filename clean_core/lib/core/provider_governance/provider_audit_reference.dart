class ProviderAuditReference {
  const ProviderAuditReference({
    required this.auditId,
    required this.traceHash,
    required this.visibilityScope,
  });

  final String auditId;
  final String traceHash;
  final String visibilityScope;

  Map<String, Object?> toMap() {
    return {
      'auditId': auditId,
      'traceHash': traceHash,
      'visibilityScope': visibilityScope,
    };
  }
}
