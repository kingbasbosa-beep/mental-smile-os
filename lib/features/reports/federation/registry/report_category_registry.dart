class ReportCategoryRegistry {
  const ReportCategoryRegistry._();

  static const String operational = 'operational';
  static const String residential = 'residential';
  static const String commercial = 'commercial';
  static const String strategic = 'strategic';
  static const String constitutional = 'constitutional';
  static const String archive = 'archive';
  static const String monitoring = 'monitoring';
  static const String reputationReport = 'reputation_report';
  static const String toolMeterReport = 'tool_meter_report';

  static const Set<String> values = <String>{
    operational,
    residential,
    commercial,
    strategic,
    constitutional,
    archive,
    monitoring,
    reputationReport,
    toolMeterReport,
  };
}
