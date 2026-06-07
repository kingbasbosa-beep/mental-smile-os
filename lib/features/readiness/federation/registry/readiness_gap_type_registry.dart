class ReadinessGapTypeRegistry {
  const ReadinessGapTypeRegistry._();

  static const String legacyGap = 'legacy_gap';
  static const String ghostGap = 'ghost_gap';
  static const String federationGap = 'federation_gap';

  static const Set<String> values = <String>{
    legacyGap,
    ghostGap,
    federationGap,
  };
}
