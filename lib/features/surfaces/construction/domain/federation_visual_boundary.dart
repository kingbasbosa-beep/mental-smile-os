class FederationVisualBoundary {
  const FederationVisualBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'booking_banner',
    'session_banner',
    'payment_banner',
    'admin_background',
    'legacy_visual_surface',
  };

  static bool allowsName(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
