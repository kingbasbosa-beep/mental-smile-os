class OperationalObservatoryBoundary {
  const OperationalObservatoryBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'booking_observatory',
    'session_observatory',
    'payment_observatory',
    'admin_observatory',
    'admin_dashboard',
  };

  static bool allowsObservatoryName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
