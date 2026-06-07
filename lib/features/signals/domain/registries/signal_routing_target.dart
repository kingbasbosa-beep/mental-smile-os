class SignalRoutingTarget {
  const SignalRoutingTarget._();

  static const String residentialMonitoring = 'residential_monitoring';
  static const String commercialMonitoring = 'commercial_monitoring';
  static const String supportMonitoring = 'support_monitoring';
  static const String technicalMonitoring = 'technical_monitoring';
  static const String ownerSummary = 'owner_summary';
  static const String archive = 'archive';

  static const List<String> values = <String>[
    residentialMonitoring,
    commercialMonitoring,
    supportMonitoring,
    technicalMonitoring,
    ownerSummary,
    archive,
  ];
}
