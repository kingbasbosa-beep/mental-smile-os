class ProviderCenterFederationBoundary {
  const ProviderCenterFederationBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'booking_provider',
    'booking_center',
    'session_provider',
    'session_center',
    'payment_provider',
    'payment_center',
    'admin_provider',
    'admin_center',
    'booking',
    'request',
    'session_request',
    'appointment',
  };

  static bool allowsFoundationName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
