import 'governance_capability.dart';
import 'governance_capability_block_reason.dart';
import 'governance_capability_policy.dart';

class GovernanceCapabilityGuard {
  const GovernanceCapabilityGuard();

  GovernanceCapabilityBlockReason? blockReason({
    required GovernanceCapability capability,
    required GovernanceCapabilityPolicy policy,
  }) {
    if (!policy.capabilityEnabled) {
      return GovernanceCapabilityBlockReason.capabilityBlocked;
    }
    if (policy.policyVersion != capability.policyVersion ||
        capability.auditLink.policyVersion != policy.policyVersion) {
      return GovernanceCapabilityBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        capability.runtimeMarker.runtimeMode != 'disabled') {
      return GovernanceCapabilityBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        capability.runtimeMarker.providerId.trim().isNotEmpty) {
      return GovernanceCapabilityBlockReason.providerBlocked;
    }
    if (capability.reviewMarker.reviewRequired) {
      return GovernanceCapabilityBlockReason.reviewRequired;
    }
    if (policy.restrictedEnvironments.contains(
      capability.runtimeMarker.environment,
    )) {
      return GovernanceCapabilityBlockReason.restrictedEnvironment;
    }
    if (!capability.requirement.allowedScopes.contains(capability.scope) ||
        !policy.allowedVisibilityScopes.contains(capability.visibilityScope)) {
      return GovernanceCapabilityBlockReason.unsafeCapability;
    }
    if (capability.requirement.auditLinkRequired &&
        !capability.auditLink.isLinked) {
      return GovernanceCapabilityBlockReason.failClosed;
    }
    if (policy.backendGovernanceRequired &&
        !capability.runtimeMarker.backendGoverned) {
      return GovernanceCapabilityBlockReason.unsafeCapability;
    }
    if (policy.failClosed) return GovernanceCapabilityBlockReason.failClosed;
    return null;
  }
}
