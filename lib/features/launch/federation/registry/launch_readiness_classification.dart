class LaunchReadinessClassification {
  const LaunchReadinessClassification._();

  static const String ready = 'ready';
  static const String partial = 'partial';
  static const String blocked = 'blocked';
  static const String legacyDependent = 'legacy_dependent';

  static const Set<String> values = <String>{
    ready,
    partial,
    blocked,
    legacyDependent,
  };
}
