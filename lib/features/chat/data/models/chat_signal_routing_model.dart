class ChatSignalRoutingModel {
  const ChatSignalRoutingModel({
    required this.recommendedProviders,
    required this.recommendedSignals,
    required this.recommendedActions,
    required this.routingSignals,
    required this.safetyEscalationLevel,
  });

  final List<String> recommendedProviders;
  final List<String> recommendedSignals;
  final List<String> recommendedActions;
  final List<String> routingSignals;
  final String safetyEscalationLevel;

  Map<String, dynamic> toFirestore() {
    return {
      'recommendedProviders': recommendedProviders,
      'recommendedSignals': recommendedSignals,
      'recommendedActions': recommendedActions,
      'routingSignals': routingSignals,
      'safetyEscalationLevel': safetyEscalationLevel,
    };
  }
}
