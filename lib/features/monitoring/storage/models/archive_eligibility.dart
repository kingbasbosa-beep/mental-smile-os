class ArchiveEligibility {
  const ArchiveEligibility._();

  static const String eligible = 'eligible';
  static const String restricted = 'restricted';
  static const String constitutionalOnly = 'constitutional_only';
  static const String ownerOnly = 'owner_only';

  static const Set<String> values = <String>{
    eligible,
    restricted,
    constitutionalOnly,
    ownerOnly,
  };
}
