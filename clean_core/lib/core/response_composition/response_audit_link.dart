class ResponseAuditLink {
  const ResponseAuditLink({
    required this.auditId,
    required this.traceHash,
    required this.visibilityScope,
  });

  final String auditId;
  final String traceHash;
  final String visibilityScope;

  bool get isLinked {
    return auditId.trim().isNotEmpty && traceHash.trim().isNotEmpty;
  }

  Map<String, Object?> toMap() {
    return {
      'auditId': auditId,
      'traceHash': traceHash,
      'visibilityScope': visibilityScope,
    };
  }
}
