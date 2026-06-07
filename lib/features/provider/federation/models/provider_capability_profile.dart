class ProviderCapabilityProfile {
  const ProviderCapabilityProfile({
    required this.providerId,
    required this.capabilitySignals,
    required this.specialtySignals,
    required this.languageSignals,
    required this.accessibilitySignals,
  });

  final String providerId;
  final Set<String> capabilitySignals;
  final Set<String> specialtySignals;
  final Set<String> languageSignals;
  final Set<String> accessibilitySignals;
}
