import 'provider_onboarding_block_reason.dart';
import 'provider_onboarding_lock.dart';
import 'provider_onboarding_policy.dart';
import 'provider_onboarding_profile.dart';

class ProviderOnboardingGuard {
  const ProviderOnboardingGuard();

  ProviderOnboardingBlockReason? blockReason({
    required ProviderOnboardingProfile profile,
    ProviderOnboardingPolicy policy = ProviderOnboardingPolicy.safeDefault,
    ProviderOnboardingLock lock = ProviderOnboardingLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.providerBlocked) {
      return ProviderOnboardingBlockReason.onboardingLocked;
    }
    if (!policy.onboardingAllowed) {
      return ProviderOnboardingBlockReason.providerBlocked;
    }
    if (profile.requirement.signedAuthorityRequired &&
        !profile.hasSignedAuthority) {
      return ProviderOnboardingBlockReason.missingAuthority;
    }
    if (profile.requirement.policyLinkRequired &&
        (profile.policyVersion != policy.policyVersion ||
            profile.auditLink.policyVersion != policy.policyVersion)) {
      return ProviderOnboardingBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed &&
        profile.runtimeMarker.runtimeMode != 'disabled') {
      return ProviderOnboardingBlockReason.runtimeDisabled;
    }
    if (!policy.networkingAllowed && profile.runtimeMarker.networkingEnabled) {
      return ProviderOnboardingBlockReason.networkingDisabled;
    }
    if (profile.reviewMarker.reviewRequired) {
      return ProviderOnboardingBlockReason.reviewRequired;
    }
    if (profile.requirement.auditLinkRequired && !profile.auditLink.isLinked) {
      return ProviderOnboardingBlockReason.missingAuditLink;
    }
    if (profile.requirement.providerOwnerRequired &&
        !profile.candidate.hasProviderOwner) {
      return ProviderOnboardingBlockReason.providerOwnerMissing;
    }
    if (profile.requirement.providerApprovalRequired &&
        !profile.candidate.hasProviderApproval) {
      return ProviderOnboardingBlockReason.providerApprovalMissing;
    }
    if (profile.requirement.providerIsolationRequired &&
        !profile.candidate.isolationApproved) {
      return ProviderOnboardingBlockReason.isolationMissing;
    }
    if (profile.requirement.observabilityRequired &&
        !profile.candidate.observabilityApproved) {
      return ProviderOnboardingBlockReason.observabilityMissing;
    }
    if (profile.requirement.rollbackReadinessRequired &&
        !profile.candidate.rollbackReady) {
      return ProviderOnboardingBlockReason.rollbackMissing;
    }
    if (!profile.candidate.hasCapabilityScope) {
      return ProviderOnboardingBlockReason.unsafeProvider;
    }
    if (!policy.allowedStages.contains(profile.stage) ||
        !policy.allowedVisibilityScopes.contains(profile.visibilityScope) ||
        !profile.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        ) ||
        !profile.candidate.capabilityScopes.every(policy.allowedScopes.contains)) {
      return ProviderOnboardingBlockReason.unsafeProvider;
    }
    if (policy.backendGovernanceRequired &&
        !profile.runtimeMarker.backendGoverned) {
      return ProviderOnboardingBlockReason.unsafeProvider;
    }
    if (profile.runtimeMarker.onboardingActive) {
      return ProviderOnboardingBlockReason.unsafeProvider;
    }
    if (policy.failClosed) {
      return ProviderOnboardingBlockReason.failClosed;
    }
    return null;
  }
}
