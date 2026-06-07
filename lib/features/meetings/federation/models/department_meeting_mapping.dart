class DepartmentMeetingMapping {
  const DepartmentMeetingMapping({
    required this.department,
    required this.meetingTypes,
    required this.reportTypes,
    required this.archivePackageTypes,
  });

  final String department;
  final Set<String> meetingTypes;
  final Set<String> reportTypes;
  final Set<String> archivePackageTypes;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'department': department,
      'meetingTypes': meetingTypes.toList(),
      'reportTypes': reportTypes.toList(),
      'archivePackageTypes': archivePackageTypes.toList(),
    };
  }
}
