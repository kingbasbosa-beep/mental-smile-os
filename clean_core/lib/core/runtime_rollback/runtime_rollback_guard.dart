import 'runtime_rollback_block_reason.dart';
import 'runtime_rollback_lock.dart';
import 'runtime_rollback_plan.dart';
import 'runtime_rollback_policy.dart';

class RuntimeRollbackGuard {
  const RuntimeRollbackGuard();

  RuntimeRollbackBlockReason? blockReason({
    required RuntimeRollbackPlan plan,
    RuntimeRollbackPolicy policy = RuntimeRollbackPolicy.safeDefault,
    RuntimeRollbackLock lock = RuntimeRollbackLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.rollbackBlocked) {
      return RuntimeRollbackBlockReason.rollbackLocked;
    }
    if (!policy.rollbackAllowed) {
      return RuntimeRollbackBlockReason.rollbackBlocked;
    }
    if (plan.requirement.signedAuthorityRequired && !plan.hasSignedAuthority) {
      return RuntimeRollbackBlockReason.missingAuthority;
    }
    if (plan.requirement.policyLinkRequired &&
        (plan.policyVersion != policy.policyVersion ||
            plan.auditLink.policyVersion != policy.policyVersion)) {
      return RuntimeRollbackBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        plan.runtimeMarker.runtimeMode != 'disabled') {
      return RuntimeRollbackBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        plan.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeRollbackBlockReason.providerBlocked;
    }
    if (plan.reviewMarker.reviewRequired) {
      return RuntimeRollbackBlockReason.reviewRequired;
    }
    if (plan.requirement.auditLinkRequired && !plan.auditLink.isLinked) {
      return RuntimeRollbackBlockReason.missingAuditLink;
    }
    if (plan.requirement.rollbackOwnerRequired &&
        !plan.candidate.hasRollbackOwner) {
      return RuntimeRollbackBlockReason.rollbackOwnerMissing;
    }
    if (plan.requirement.rollbackApprovalRequired &&
        !plan.candidate.hasRollbackApproval) {
      return RuntimeRollbackBlockReason.rollbackApprovalMissing;
    }
    if (plan.requirement.providerRollbackApprovalRequired &&
        !plan.candidate.hasProviderApproval) {
      return RuntimeRollbackBlockReason.providerBlocked;
    }
    if (plan.requirement.backendRollbackApprovalRequired &&
        !plan.candidate.hasBackendApproval) {
      return RuntimeRollbackBlockReason.missingAuthority;
    }
    if (plan.requirement.governanceRollbackOwnershipRequired &&
        !plan.candidate.hasGovernanceOwner) {
      return RuntimeRollbackBlockReason.rollbackOwnerMissing;
    }
    if (plan.requirement.environmentRollbackOwnershipRequired &&
        !plan.candidate.hasEnvironmentOwner) {
      return RuntimeRollbackBlockReason.rollbackOwnerMissing;
    }
    if (!policy.allowedStages.contains(plan.stage) ||
        !policy.allowedVisibilityScopes.contains(plan.visibilityScope) ||
        !plan.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return RuntimeRollbackBlockReason.unsafeRollback;
    }
    if (policy.backendGovernanceRequired &&
        !plan.runtimeMarker.backendGoverned) {
      return RuntimeRollbackBlockReason.unsafeRollback;
    }
    if (plan.runtimeMarker.rollbackActive) {
      return RuntimeRollbackBlockReason.unsafeRollback;
    }
    if (policy.failClosed) {
      return RuntimeRollbackBlockReason.failClosed;
    }
    return null;
  }
}
