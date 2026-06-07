class OwnerGovernanceBoundary {
  const OwnerGovernanceBoundary._();

  static const Set<String> forbiddenTerms = <String>{
    'owner_god_mode',
    'admin_capsule',
    'booking_capsule',
    'session_capsule',
    'payment_capsule',
    'admin_recovery',
  };

  static bool allowsGovernanceName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    for (final term in forbiddenTerms) {
      if (normalized.contains(term)) return false;
    }
    return true;
  }
}
