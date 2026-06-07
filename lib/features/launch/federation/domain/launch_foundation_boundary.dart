class LaunchFoundationBoundary {
  const LaunchFoundationBoundary._();

  static const Set<String> forbiddenLaunchTerms = <String>{
    'booking_launch',
    'session_launch',
    'payment_launch',
    'admin_launch',
  };

  static bool allowsLaunchName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenLaunchTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
