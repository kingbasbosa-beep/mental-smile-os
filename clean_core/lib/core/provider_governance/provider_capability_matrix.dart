import 'provider_capability.dart';
import 'provider_safety_profile.dart';

class ProviderCapabilityMatrix {
  const ProviderCapabilityMatrix({
    required this.providerCapabilities,
  });

  final Map<String, Set<ProviderCapability>> providerCapabilities;

  Set<ProviderCapability> capabilitiesFor(String providerId) {
    return providerCapabilities[providerId.trim()] ?? const {};
  }

  bool supports({
    required ProviderSafetyProfile profile,
    required ProviderCapability capability,
  }) {
    if (!profile.isUsable) return false;
    if (profile.restriction.blocksCapability(capability)) return false;
    return capabilitiesFor(profile.providerId).contains(capability);
  }
}
