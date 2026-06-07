class ProviderReadinessProfile {
  const ProviderReadinessProfile({
    required this.providerId,
    required this.readinessStatus,
    required this.requiredActions,
    required this.separationMarkers,
  });

  final String providerId;
  final String readinessStatus;
  final List<String> requiredActions;
  final Set<String> separationMarkers;
}
