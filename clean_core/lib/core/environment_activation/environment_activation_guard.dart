import 'environment_activation_block_reason.dart';
import 'environment_activation_lock.dart';
import 'environment_activation_policy.dart';
import 'environment_activation_profile.dart';

class EnvironmentActivationGuard {
  const EnvironmentActivationGuard();

  EnvironmentActivationBlockReason? blockReason({
    required EnvironmentActivationProfile profile,
    EnvironmentActivationPolicy policy =
        EnvironmentActivationPolicy.safeDefault,
    EnvironmentActivationLock lock = EnvironmentActivationLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.environmentBlocked) {
      return EnvironmentActivationBlockReason.environmentLocked;
    }
    if (!policy.environmentAllowed) {
      return EnvironmentActivationBlockReason.environmentBlocked;
    }
    if (profile.requirement.policyLinkRequired &&
        (profile.policyVersion != policy.policyVersion ||
            profile.auditLink.policyVersion != policy.policyVersion)) {
      return EnvironmentActivationBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        profile.runtimeMarker.runtimeMode != 'disabled') {
      return EnvironmentActivationBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        profile.runtimeMarker.providerId.trim().isNotEmpty) {
      return EnvironmentActivationBlockReason.providerBlocked;
    }
    if (profile.reviewMarker.reviewRequired) {
      return EnvironmentActivationBlockReason.reviewRequired;
    }
    if (profile.requirement.auditLinkRequired && !profile.auditLink.isLinked) {
      return EnvironmentActivationBlockReason.missingAuditLink;
    }
    if (profile.requirement.ownerRequired &&
        !profile.environment.hasTrustedOwner) {
      return EnvironmentActivationBlockReason.missingOwner;
    }
    if (profile.requirement.runtimePermissionRequired &&
        !profile.hasRuntimePermission) {
      return EnvironmentActivationBlockReason.permissionDenied;
    }
    if (profile.requirement.providerPermissionRequired &&
        !profile.hasProviderPermission) {
      return EnvironmentActivationBlockReason.permissionDenied;
    }
    if (profile.requirement.backendPermissionRequired &&
        !profile.hasBackendPermission) {
      return EnvironmentActivationBlockReason.permissionDenied;
    }
    if (profile.requirement.routingPermissionRequired &&
        !profile.hasRoutingPermission) {
      return EnvironmentActivationBlockReason.permissionDenied;
    }
    if (profile.requirement.governancePermissionRequired &&
        !profile.hasGovernancePermission) {
      return EnvironmentActivationBlockReason.permissionDenied;
    }
    if (!policy.allowedStages.contains(profile.stage) ||
        !policy.allowedEnvironmentTypes
            .contains(profile.environment.environmentType) ||
        !policy.allowedVisibilityScopes.contains(profile.visibilityScope) ||
        !profile.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return EnvironmentActivationBlockReason.unsafeEnvironment;
    }
    if (policy.backendGovernanceRequired &&
        !profile.runtimeMarker.backendGoverned) {
      return EnvironmentActivationBlockReason.unsafeEnvironment;
    }
    if (profile.runtimeMarker.environmentActive) {
      return EnvironmentActivationBlockReason.unsafeEnvironment;
    }
    if (policy.failClosed) {
      return EnvironmentActivationBlockReason.failClosed;
    }
    return null;
  }
}
