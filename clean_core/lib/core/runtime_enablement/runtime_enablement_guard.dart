import 'runtime_enablement_block_reason.dart';
import 'runtime_enablement_lock.dart';
import 'runtime_enablement_plan.dart';
import 'runtime_enablement_policy.dart';

class RuntimeEnablementGuard {
  const RuntimeEnablementGuard();

  RuntimeEnablementBlockReason? blockReason({
    required RuntimeEnablementPlan plan,
    RuntimeEnablementPolicy policy = RuntimeEnablementPolicy.safeDefault,
    RuntimeEnablementLock lock = RuntimeEnablementLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.enablementBlocked) {
      return RuntimeEnablementBlockReason.enablementLocked;
    }
    if (!policy.enablementAllowed) {
      return RuntimeEnablementBlockReason.enablementBlocked;
    }
    if (plan.requirement.signedAuthorityRequired && !plan.hasSignedAuthority) {
      return RuntimeEnablementBlockReason.missingAuthority;
    }
    if (plan.requirement.policyLinkRequired &&
        (plan.policyVersion != policy.policyVersion ||
            plan.auditLink.policyVersion != policy.policyVersion)) {
      return RuntimeEnablementBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        plan.runtimeMarker.runtimeMode != 'disabled') {
      return RuntimeEnablementBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        plan.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeEnablementBlockReason.providerBlocked;
    }
    if (plan.reviewMarker.reviewRequired) {
      return RuntimeEnablementBlockReason.reviewRequired;
    }
    if (plan.requirement.auditLinkRequired && !plan.auditLink.isLinked) {
      return RuntimeEnablementBlockReason.missingAuditLink;
    }
    if (plan.requirement.readinessRequired && !plan.readinessVerified) {
      return RuntimeEnablementBlockReason.readinessMissing;
    }
    if (plan.requirement.rollbackPlanRequired &&
        !plan.candidate.hasRollbackOwner) {
      return RuntimeEnablementBlockReason.rollbackPlanMissing;
    }
    if (plan.requirement.backendApprovalRequired &&
        !plan.candidate.hasBackendApproval) {
      return RuntimeEnablementBlockReason.missingAuthority;
    }
    if (plan.requirement.providerApprovalRequired &&
        !plan.candidate.hasProviderApproval) {
      return RuntimeEnablementBlockReason.providerBlocked;
    }
    if (plan.requirement.governanceOwnershipRequired &&
        !plan.candidate.hasGovernanceOwnership) {
      return RuntimeEnablementBlockReason.missingAuthority;
    }
    if (policy.restrictedEnvironments.contains(plan.runtimeMarker.environment)) {
      return RuntimeEnablementBlockReason.unsafeEnablement;
    }
    if (!policy.allowedStages.contains(plan.stage) ||
        !policy.allowedVisibilityScopes.contains(plan.visibilityScope) ||
        !plan.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return RuntimeEnablementBlockReason.unsafeEnablement;
    }
    if (policy.backendGovernanceRequired &&
        !plan.runtimeMarker.backendGoverned) {
      return RuntimeEnablementBlockReason.unsafeEnablement;
    }
    if (plan.runtimeMarker.enablementActive) {
      return RuntimeEnablementBlockReason.unsafeEnablement;
    }
    if (policy.failClosed) {
      return RuntimeEnablementBlockReason.failClosed;
    }
    return null;
  }
}
