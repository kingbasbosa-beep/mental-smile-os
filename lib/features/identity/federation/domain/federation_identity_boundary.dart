class FederationIdentityBoundary {
  const FederationIdentityBoundary._();

  static const List<String> forbiddenNamingFragments = <String>[
    'booking',
    'session',
    'payment',
    'admin lifecycle',
    'admin_lifecycle',
  ];

  static bool acceptsName(String value) {
    final normalized = value.trim().toLowerCase();
    return !forbiddenNamingFragments.any(normalized.contains);
  }
}
