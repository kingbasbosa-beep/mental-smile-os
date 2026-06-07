class ClientAccessibilityProfile {
  const ClientAccessibilityProfile({
    required this.clientId,
    required this.accessibilitySignals,
    required this.communicationSignals,
    required this.supportPreferences,
  });

  final String clientId;
  final Set<String> accessibilitySignals;
  final Set<String> communicationSignals;
  final Set<String> supportPreferences;
}
