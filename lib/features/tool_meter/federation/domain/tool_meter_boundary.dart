class ToolMeterBoundary {
  const ToolMeterBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'session success',
    'treatment success',
    'clinical outcome',
    'booking conversion',
    'payment conversion',
    'admin performance',
    'session_success',
    'treatment_success',
    'clinical_outcome',
    'booking_conversion',
    'payment_conversion',
    'admin_performance',
  };

  static bool allowsText(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
