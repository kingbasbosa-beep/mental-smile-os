class CenterCapabilityProfile {
  const CenterCapabilityProfile({
    required this.centerId,
    required this.serviceSignals,
    required this.capabilitySignals,
    required this.accessibilitySignals,
  });

  final String centerId;
  final Set<String> serviceSignals;
  final Set<String> capabilitySignals;
  final Set<String> accessibilitySignals;
}
