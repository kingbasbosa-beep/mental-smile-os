class MeetingSystemReadinessSnapshot {
  const MeetingSystemReadinessSnapshot({
    required this.supportedMeetingTypes,
    required this.supportedPackageTypes,
    required this.supportedReports,
    required this.complianceStatus,
  });

  final Set<String> supportedMeetingTypes;
  final Set<String> supportedPackageTypes;
  final Set<String> supportedReports;
  final String complianceStatus;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'supportedMeetingTypes': supportedMeetingTypes.toList(),
      'supportedPackageTypes': supportedPackageTypes.toList(),
      'supportedReports': supportedReports.toList(),
      'complianceStatus': complianceStatus,
    };
  }
}
