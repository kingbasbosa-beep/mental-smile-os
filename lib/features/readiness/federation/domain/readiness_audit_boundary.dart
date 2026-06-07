class ReadinessAuditBoundary {
  const ReadinessAuditBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'booking_readiness',
    'session_readiness',
    'payment_readiness',
    'admin_readiness',
  };

  static bool allowsReadinessName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
