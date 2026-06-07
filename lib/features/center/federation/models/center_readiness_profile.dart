class CenterReadinessProfile {
  const CenterReadinessProfile({
    required this.centerId,
    required this.readinessStatus,
    required this.requiredActions,
    required this.separationMarkers,
  });

  final String centerId;
  final String readinessStatus;
  final List<String> requiredActions;
  final Set<String> separationMarkers;
}
