class RouteClassification {
  const RouteClassification._();

  static const String federation = 'federation';
  static const String legacy = 'legacy';
  static const String transitional = 'transitional';
  static const String owner = 'owner';
  static const String monitoring = 'monitoring';
  static const String archive = 'archive';

  static const Set<String> values = <String>{
    federation,
    legacy,
    transitional,
    owner,
    monitoring,
    archive,
  };
}
