class FederationSurfaceBoundary {
  const FederationSurfaceBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'admin_dashboard',
    'booking_surface',
    'session_surface',
    'payment_surface',
    'admin_runtime',
  };

  static bool allowsSurfaceName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
