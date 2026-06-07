class ReportClassification {
  const ReportClassification._();

  static const String public = 'public';
  static const String internal = 'internal';
  static const String restricted = 'restricted';
  static const String constitutional = 'constitutional';
  static const String ownerOnly = 'owner_only';

  static const Set<String> values = <String>{
    public,
    internal,
    restricted,
    constitutional,
    ownerOnly,
  };
}
