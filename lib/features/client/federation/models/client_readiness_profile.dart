class ClientReadinessProfile {
  const ClientReadinessProfile({
    required this.clientId,
    required this.readinessStatus,
    required this.requiredActions,
    required this.separationMarkers,
  });

  final String clientId;
  final String readinessStatus;
  final List<String> requiredActions;
  final Set<String> separationMarkers;
}
