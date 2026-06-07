class PublicReputationBoundary {
  const PublicReputationBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'sessionRatings',
    'session_rating',
    'booking ratings',
    'booking_rating',
    'appointment ratings',
    'appointment_rating',
    'session review',
    'session_review',
    'booking review',
    'appointment review',
    'booking',
    'appointment',
    'session',
  };

  static bool allowsText(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }

  static bool allowsTarget({
    required String targetType,
    required String targetId,
  }) {
    return allowsText(targetType) && allowsText(targetId);
  }
}
