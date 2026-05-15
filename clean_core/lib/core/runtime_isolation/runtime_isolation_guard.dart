import 'runtime_isolation_block_reason.dart';
import 'runtime_isolation_lock.dart';
import 'runtime_isolation_policy.dart';
import 'runtime_isolation_profile.dart';

class RuntimeIsolationGuard {
  const RuntimeIsolationGuard();

  RuntimeIsolationBlockReason? blockReason({
    required RuntimeIsolationProfile profile,
    RuntimeIsolationPolicy policy = RuntimeIsolationPolicy.safeDefault,
    RuntimeIsolationLock lock = RuntimeIsolationLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.isolationBlocked) {
      return RuntimeIsolationBlockReason.isolationLocked;
    }
    if (!policy.isolationAllowed) {
      return RuntimeIsolationBlockReason.isolationBlocked;
    }
    if (profile.requirement.signedAuthorityRequired &&
        !profile.hasSignedAuthority) {
      return RuntimeIsolationBlockReason.missingAuthority;
    }
    if (profile.requirement.policyLinkRequired &&
        (profile.policyVersion != policy.policyVersion ||
            profile.auditLink.policyVersion != policy.policyVersion)) {
      return RuntimeIsolationBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        profile.runtimeMarker.runtimeMode != 'disabled') {
      return RuntimeIsolationBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        profile.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeIsolationBlockReason.providerBlocked;
    }
    if (profile.reviewMarker.reviewRequired) {
      return RuntimeIsolationBlockReason.reviewRequired;
    }
    if (profile.requirement.auditLinkRequired && !profile.auditLink.isLinked) {
      return RuntimeIsolationBlockReason.missingAuditLink;
    }
    if (profile.requirement.boundaryIsolationRequired &&
        !profile.boundary.isCompletePlaceholder) {
      return RuntimeIsolationBlockReason.isolationBoundaryMissing;
    }
    if (profile.requirement.runtimeIsolationRequired &&
        !profile.boundary.runtimeIsolated) {
      return RuntimeIsolationBlockReason.unsafeIsolation;
    }
    if (profile.requirement.providerIsolationRequired &&
        !profile.boundary.providerIsolated) {
      return RuntimeIsolationBlockReason.unsafeIsolation;
    }
    if (profile.requirement.environmentIsolationRequired &&
        !profile.boundary.environmentIsolated) {
      return RuntimeIsolationBlockReason.unsafeIsolation;
    }
    if (profile.requirement.fallbackIsolationRequired &&
        !profile.boundary.fallbackIsolated) {
      return RuntimeIsolationBlockReason.unsafeIsolation;
    }
    if (!policy.allowedStages.contains(profile.stage) ||
        !policy.allowedVisibilityScopes.contains(profile.visibilityScope) ||
        !profile.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return RuntimeIsolationBlockReason.unsafeIsolation;
    }
    if (policy.backendGovernanceRequired &&
        !profile.runtimeMarker.backendGoverned) {
      return RuntimeIsolationBlockReason.unsafeIsolation;
    }
    if (profile.runtimeMarker.isolationActive) {
      return RuntimeIsolationBlockReason.unsafeIsolation;
    }
    if (policy.failClosed) {
      return RuntimeIsolationBlockReason.failClosed;
    }
    return null;
  }
}
