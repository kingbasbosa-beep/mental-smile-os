import 'governance_lifecycle_block_reason.dart';
import 'governance_lifecycle_lock.dart';
import 'governance_lifecycle_policy.dart';
import 'governance_lifecycle_transition.dart';

class GovernanceLifecycleGuard {
  const GovernanceLifecycleGuard();

  GovernanceLifecycleBlockReason? blockReason({
    required GovernanceLifecycleTransition transition,
    required GovernanceLifecyclePolicy policy,
    required GovernanceLifecycleLock lock,
  }) {
    if (lock.locked) return GovernanceLifecycleBlockReason.locked;
    if (!policy.allowedStates.contains(transition.toState)) {
      return GovernanceLifecycleBlockReason.invalidTransition;
    }
    if (transition.runtimeMarker.runtimeMode == 'disabled') {
      return GovernanceLifecycleBlockReason.runtimeDisabled;
    }
    if (transition.policyVersion != policy.policyVersion) {
      return GovernanceLifecycleBlockReason.policyMismatch;
    }
    if (!policy.providerAllowed &&
        transition.runtimeMarker.providerId.trim().isNotEmpty) {
      return GovernanceLifecycleBlockReason.providerBlocked;
    }
    if (policy.reviewRequired || transition.reviewMarker.reviewRequired) {
      return GovernanceLifecycleBlockReason.reviewRequired;
    }
    if (!policy.allowedScopes.contains(transition.scope) ||
        !policy.allowedVisibilityScopes.contains(
          transition.visibilityScope,
        )) {
      return GovernanceLifecycleBlockReason.restrictedEnvironment;
    }
    if (policy.auditRequired && !transition.auditLink.isLinked) {
      return GovernanceLifecycleBlockReason.missingAuditLink;
    }
    if (policy.backendGovernanceRequired &&
        !transition.runtimeMarker.backendGoverned) {
      return GovernanceLifecycleBlockReason.unsafeCoordination;
    }
    if (policy.failClosed) return GovernanceLifecycleBlockReason.failClosed;
    return null;
  }
}
