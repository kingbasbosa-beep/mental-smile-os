import 'provider_block_reason.dart';
import 'provider_capability_matrix.dart';
import 'provider_governance_policy.dart';
import 'provider_runtime_permission.dart';
import 'provider_safety_profile.dart';
import 'provider_trust_level.dart';

class ProviderGovernanceGuard {
  const ProviderGovernanceGuard();

  ProviderBlockReason? blockReason({
    required ProviderSafetyProfile profile,
    required ProviderGovernancePolicy policy,
    required ProviderCapabilityMatrix matrix,
    required ProviderRuntimePermission permission,
  }) {
    if (profile.trustLevel == ProviderTrustLevel.blocked) {
      return ProviderBlockReason.providerBlocked;
    }
    if (profile.trustLevel.index < policy.minimumTrustLevel.index) {
      return ProviderBlockReason.trustLevelInsufficient;
    }
    if (policy.policyLinkRequired && !profile.policyLink.isLinked) {
      return ProviderBlockReason.policyLinkMissing;
    }
    if (!matrix.supports(
      profile: profile,
      capability: permission.requestedCapability,
    )) {
      return ProviderBlockReason.capabilityBlocked;
    }
    if (profile.restriction.blockedRuntimeModes.contains(
      permission.runtimeMode,
    )) {
      return ProviderBlockReason.runtimeModeBlocked;
    }
    if (profile.restriction.blockedEnvironments.contains(
      permission.environment,
    )) {
      return ProviderBlockReason.environmentBlocked;
    }
    if (profile.restriction.restrictedAuditScopes.contains(
      permission.boundaryScope,
    )) {
      return ProviderBlockReason.auditScopeRestricted;
    }
    if (!profile.restriction.escalationAccessAllowed) {
      return ProviderBlockReason.escalationRestricted;
    }
    if (!profile.restriction.crisisHandlingAllowed) {
      return ProviderBlockReason.crisisHandlingRestricted;
    }
    if (policy.failClosed) return ProviderBlockReason.failClosed;
    return null;
  }
}
