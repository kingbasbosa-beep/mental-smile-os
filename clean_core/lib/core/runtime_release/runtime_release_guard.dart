import 'runtime_release_block_reason.dart';
import 'runtime_release_lock.dart';
import 'runtime_release_plan.dart';
import 'runtime_release_policy.dart';

class RuntimeReleaseGuard {
  const RuntimeReleaseGuard();

  RuntimeReleaseBlockReason? blockReason({
    required RuntimeReleasePlan plan,
    RuntimeReleasePolicy policy = RuntimeReleasePolicy.safeDefault,
    RuntimeReleaseLock lock = RuntimeReleaseLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.releaseBlocked) {
      return RuntimeReleaseBlockReason.releaseLocked;
    }
    if (!policy.releaseAllowed) {
      return RuntimeReleaseBlockReason.releaseBlocked;
    }
    if (plan.requirement.signedAuthorityRequired && !plan.hasSignedAuthority) {
      return RuntimeReleaseBlockReason.missingAuthority;
    }
    if (plan.requirement.policyLinkRequired &&
        (plan.policyVersion != policy.policyVersion ||
            plan.auditLink.policyVersion != policy.policyVersion)) {
      return RuntimeReleaseBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        plan.runtimeMarker.runtimeMode != 'disabled') {
      return RuntimeReleaseBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        plan.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeReleaseBlockReason.providerBlocked;
    }
    if (plan.reviewMarker.reviewRequired) {
      return RuntimeReleaseBlockReason.reviewRequired;
    }
    if (plan.requirement.auditLinkRequired && !plan.auditLink.isLinked) {
      return RuntimeReleaseBlockReason.missingAuditLink;
    }
    if (plan.requirement.releaseOwnerRequired &&
        !plan.candidate.hasReleaseOwner) {
      return RuntimeReleaseBlockReason.releaseOwnerMissing;
    }
    if (plan.requirement.releaseApprovalRequired &&
        !plan.candidate.hasReleaseApproval) {
      return RuntimeReleaseBlockReason.releaseApprovalMissing;
    }
    if (plan.requirement.providerApprovalRequired &&
        !plan.candidate.hasProviderApproval) {
      return RuntimeReleaseBlockReason.providerBlocked;
    }
    if (plan.requirement.backendApprovalRequired &&
        !plan.candidate.hasBackendApproval) {
      return RuntimeReleaseBlockReason.missingAuthority;
    }
    if (plan.requirement.rollbackReadinessRequired &&
        !plan.candidate.rollbackReady) {
      return RuntimeReleaseBlockReason.rollbackMissing;
    }
    if (plan.requirement.observabilityReadinessRequired &&
        !plan.candidate.observabilityReady) {
      return RuntimeReleaseBlockReason.observabilityMissing;
    }
    if (plan.requirement.isolationReadinessRequired &&
        !plan.candidate.isolationReady) {
      return RuntimeReleaseBlockReason.isolationMissing;
    }
    if (!policy.allowedStages.contains(plan.stage) ||
        !policy.allowedVisibilityScopes.contains(plan.visibilityScope) ||
        !plan.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return RuntimeReleaseBlockReason.unsafeRelease;
    }
    if (policy.backendGovernanceRequired &&
        !plan.runtimeMarker.backendGoverned) {
      return RuntimeReleaseBlockReason.unsafeRelease;
    }
    if (plan.runtimeMarker.releaseActive) {
      return RuntimeReleaseBlockReason.unsafeRelease;
    }
    if (policy.failClosed) {
      return RuntimeReleaseBlockReason.failClosed;
    }
    return null;
  }
}
