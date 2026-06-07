class RegistrationFederationBoundary {
  const RegistrationFederationBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'booking_registration',
    'session_registration',
    'payment_registration',
    'admin_registration',
    'lifecycle_registration',
    'case_management_registration',
  };

  static bool allowsRegistrationName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
