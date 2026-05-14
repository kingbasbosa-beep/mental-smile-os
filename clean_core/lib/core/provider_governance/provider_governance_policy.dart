import 'provider_capability.dart';
import 'provider_trust_level.dart';

class ProviderGovernancePolicy {
  const ProviderGovernancePolicy({
    required this.minimumTrustLevel,
    required this.requiredCapabilities,
    required this.backendGovernanceRequired,
    required this.policyLinkRequired,
    required this.failClosed,
  });

  static const ProviderGovernancePolicy safeDefault = ProviderGovernancePolicy(
    minimumTrustLevel: ProviderTrustLevel.approved,
    requiredCapabilities: <ProviderCapability>{
      ProviderCapability.auditTracing,
    },
    backendGovernanceRequired: true,
    policyLinkRequired: true,
    failClosed: true,
  );

  final ProviderTrustLevel minimumTrustLevel;
  final Set<ProviderCapability> requiredCapabilities;
  final bool backendGovernanceRequired;
  final bool policyLinkRequired;
  final bool failClosed;
}
