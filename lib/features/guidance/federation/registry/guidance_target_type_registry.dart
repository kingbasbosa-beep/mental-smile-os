class GuidanceTargetTypeRegistry {
  const GuidanceTargetTypeRegistry._();

  static const String tool = 'tool';
  static const String service = 'service';
  static const String provider = 'provider';
  static const String center = 'center';
  static const String externalApp = 'external_app';
  static const String libraryContent = 'library_content';
  static const String specialization = 'specialization';
  static const String department = 'department';
  static const String report = 'report';
  static const String workCard = 'work_card';
  static const String campaign = 'campaign';
  static const String complaintPath = 'complaint_path';
  static const String supportPath = 'support_path';

  static const Set<String> values = <String>{
    tool,
    service,
    provider,
    center,
    externalApp,
    libraryContent,
    specialization,
    department,
    report,
    workCard,
    campaign,
    complaintPath,
    supportPath,
  };
}
