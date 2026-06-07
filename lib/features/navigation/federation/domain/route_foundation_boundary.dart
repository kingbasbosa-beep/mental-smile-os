class RouteFoundationBoundary {
  const RouteFoundationBoundary._();

  static const Set<String> forbiddenNewNames = <String>{
    'booking workflow',
    'session workflow',
    'payment workflow',
    'admin operations',
    'booking_workflow',
    'session_workflow',
    'payment_workflow',
    'admin_operations',
  };

  static bool allowsNewRouteNaming(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenNewNames) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
