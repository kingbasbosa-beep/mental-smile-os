class ReadinessClassification {
  const ReadinessClassification._();

  static const String ready = 'ready';
  static const String mostlyReady = 'mostly_ready';
  static const String partial = 'partial';
  static const String blocked = 'blocked';
  static const String legacyDependent = 'legacy_dependent';

  static const Set<String> values = <String>{
    ready,
    mostlyReady,
    partial,
    blocked,
    legacyDependent,
  };
}
