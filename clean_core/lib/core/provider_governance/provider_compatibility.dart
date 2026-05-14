import 'provider_capability_matrix.dart';
import 'provider_governance_policy.dart';
import 'provider_runtime_permission.dart';
import 'provider_safety_profile.dart';

class ProviderCompatibility {
  const ProviderCompatibility({
    required this.profile,
    required this.policy,
    required this.matrix,
  });

  final ProviderSafetyProfile profile;
  final ProviderGovernancePolicy policy;
  final ProviderCapabilityMatrix matrix;

  bool isCompatible(ProviderRuntimePermission permission) {
    if (policy.backendGovernanceRequired && !permission.backendGoverned) {
      return false;
    }
    if (policy.policyLinkRequired && !profile.policyLink.isLinked) {
      return false;
    }
    if (!matrix.supports(
      profile: profile,
      capability: permission.requestedCapability,
    )) {
      return false;
    }
    if (profile.restriction.blockedRuntimeModes.contains(
      permission.runtimeMode,
    )) {
      return false;
    }
    if (profile.restriction.blockedEnvironments.contains(
      permission.environment,
    )) {
      return false;
    }
    if (profile.restriction.restrictedAuditScopes.contains(
      permission.boundaryScope,
    )) {
      return false;
    }
    return !policy.failClosed;
  }
}
