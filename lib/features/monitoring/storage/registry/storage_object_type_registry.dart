class StorageObjectTypeRegistry {
  const StorageObjectTypeRegistry._();

  static const String residentialSnapshot = 'residential_snapshot';
  static const String commercialSnapshot = 'commercial_snapshot';
  static const String operationalSnapshot = 'operational_snapshot';
  static const String residentialReport = 'residential_report';
  static const String commercialReport = 'commercial_report';
  static const String operationalReport = 'operational_report';
  static const String strategicSummary = 'strategic_summary';
  static const String constitutionalReport = 'constitutional_report';

  static const Set<String> snapshotTypes = <String>{
    residentialSnapshot,
    commercialSnapshot,
    operationalSnapshot,
  };

  static const Set<String> reportTypes = <String>{
    residentialReport,
    commercialReport,
    operationalReport,
    strategicSummary,
    constitutionalReport,
  };

  static const Set<String> values = <String>{
    ...snapshotTypes,
    ...reportTypes,
  };
}
