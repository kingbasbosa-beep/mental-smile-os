class LaunchRoadmapBoundary {
  const LaunchRoadmapBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'booking_roadmap',
    'session_roadmap',
    'payment_roadmap',
    'admin_roadmap',
    'booking workflow',
    'session workflow',
    'payment workflow',
    'admin workflow',
  };

  static bool allowsRoadmapNaming(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
