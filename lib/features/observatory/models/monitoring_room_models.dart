class MonitoringRoomProfile {
  const MonitoringRoomProfile({
    required this.roomId,
    required this.purpose,
    required this.sections,
    required this.readinessStatus,
  });

  final String roomId;
  final String purpose;
  final List<String> sections;
  final String readinessStatus;
}

class MonitoringRoomSection {
  const MonitoringRoomSection({
    required this.sectionId,
    required this.title,
    required this.source,
    required this.visibleInFoundation,
  });

  final String sectionId;
  final String title;
  final String source;
  final bool visibleInFoundation;
}

class MonitoringRoomReadiness {
  const MonitoringRoomReadiness({
    required this.status,
    required this.blockers,
    required this.requiredActions,
  });

  final String status;
  final List<String> blockers;
  final List<String> requiredActions;
}
