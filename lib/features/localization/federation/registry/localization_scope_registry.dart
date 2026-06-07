class LocalizationScopeRegistry {
  const LocalizationScopeRegistry._();

  static const String departmentLabels = 'department_labels';
  static const String reportSections = 'report_sections';
  static const String reportMetadata = 'report_metadata';
  static const String archiveLabels = 'archive_labels';
  static const String meetingPackLabels = 'meeting_pack_labels';
  static const String infoCardLabels = 'info_card_labels';
  static const String accessibilityLabels = 'accessibility_labels';
  static const String guidanceLabels = 'guidance_labels';
  static const String monitoringLabels = 'monitoring_labels';
  static const String commercialLabels = 'commercial_labels';
  static const String operationalLabels = 'operational_labels';

  static const Set<String> values = <String>{
    departmentLabels,
    reportSections,
    reportMetadata,
    archiveLabels,
    meetingPackLabels,
    infoCardLabels,
    accessibilityLabels,
    guidanceLabels,
    monitoringLabels,
    commercialLabels,
    operationalLabels,
  };
}
