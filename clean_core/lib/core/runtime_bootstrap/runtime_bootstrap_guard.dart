import 'runtime_bootstrap_block_reason.dart';
import 'runtime_bootstrap_lock.dart';
import 'runtime_bootstrap_plan.dart';
import 'runtime_bootstrap_policy.dart';

class RuntimeBootstrapGuard {
  const RuntimeBootstrapGuard();

  RuntimeBootstrapBlockReason? blockReason({
    required RuntimeBootstrapPlan plan,
    RuntimeBootstrapPolicy policy = RuntimeBootstrapPolicy.safeDefault,
    RuntimeBootstrapLock lock = RuntimeBootstrapLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.bootstrapBlocked) {
      return RuntimeBootstrapBlockReason.bootstrapLocked;
    }
    if (!policy.bootstrapAllowed) {
      return RuntimeBootstrapBlockReason.bootstrapBlocked;
    }
    if (plan.requirement.signedAuthorityRequired && !plan.hasSignedAuthority) {
      return RuntimeBootstrapBlockReason.missingAuthority;
    }
    if (plan.requirement.policyLinkRequired &&
        (plan.policyVersion != policy.policyVersion ||
            plan.auditLink.policyVersion != policy.policyVersion)) {
      return RuntimeBootstrapBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        plan.runtimeMarker.runtimeMode != 'disabled') {
      return RuntimeBootstrapBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        plan.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeBootstrapBlockReason.providerBlocked;
    }
    if (plan.reviewMarker.reviewRequired) {
      return RuntimeBootstrapBlockReason.reviewRequired;
    }
    if (plan.requirement.auditLinkRequired && !plan.auditLink.isLinked) {
      return RuntimeBootstrapBlockReason.missingAuditLink;
    }
    if (plan.requirement.bootstrapOwnerRequired &&
        !plan.candidate.hasBootstrapOwner) {
      return RuntimeBootstrapBlockReason.bootstrapOwnerMissing;
    }
    if (plan.requirement.bootstrapApprovalRequired &&
        !plan.candidate.hasBootstrapApproval) {
      return RuntimeBootstrapBlockReason.bootstrapApprovalMissing;
    }
    if (plan.requirement.releaseApprovalRequired &&
        !plan.candidate.hasReleaseApproval) {
      return RuntimeBootstrapBlockReason.releaseMissing;
    }
    if (plan.requirement.providerStartupApprovalRequired &&
        !plan.candidate.hasProviderStartupApproval) {
      return RuntimeBootstrapBlockReason.providerBlocked;
    }
    if (plan.requirement.backendStartupApprovalRequired &&
        !plan.candidate.hasBackendStartupApproval) {
      return RuntimeBootstrapBlockReason.missingAuthority;
    }
    if (plan.requirement.rollbackReadinessRequired &&
        !plan.candidate.rollbackReady) {
      return RuntimeBootstrapBlockReason.rollbackMissing;
    }
    if (plan.requirement.observabilityReadinessRequired &&
        !plan.candidate.observabilityReady) {
      return RuntimeBootstrapBlockReason.observabilityMissing;
    }
    if (plan.requirement.isolationReadinessRequired &&
        !plan.candidate.isolationReady) {
      return RuntimeBootstrapBlockReason.isolationMissing;
    }
    if (!policy.allowedStages.contains(plan.stage) ||
        !policy.allowedVisibilityScopes.contains(plan.visibilityScope) ||
        !plan.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return RuntimeBootstrapBlockReason.unsafeBootstrap;
    }
    if (policy.backendGovernanceRequired &&
        !plan.runtimeMarker.backendGoverned) {
      return RuntimeBootstrapBlockReason.unsafeBootstrap;
    }
    if (plan.runtimeMarker.bootstrapActive) {
      return RuntimeBootstrapBlockReason.unsafeBootstrap;
    }
    if (policy.failClosed) {
      return RuntimeBootstrapBlockReason.failClosed;
    }
    return null;
  }
}
