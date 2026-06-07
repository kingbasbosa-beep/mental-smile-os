class LaunchSurfaceBoundary {
  const LaunchSurfaceBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'booking_tab',
    'session_tab',
    'payment_tab',
    'admin_dashboard_tab',
    'legacy_runtime_surface',
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
