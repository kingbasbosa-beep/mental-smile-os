enum ProviderOnboardingBlockReason {
  providerBlocked,
  onboardingLocked,
  runtimeDisabled,
  networkingDisabled,
  missingAuthority,
  policyMismatch,
  isolationMissing,
  observabilityMissing,
  rollbackMissing,
  reviewRequired,
  unsafeProvider,
  missingAuditLink,
  providerApprovalMissing,
  providerOwnerMissing,
  failClosed,
}

extension ProviderOnboardingBlockReasonKey on ProviderOnboardingBlockReason {
  String get key {
    switch (this) {
      case ProviderOnboardingBlockReason.providerBlocked:
        return 'provider_blocked';
      case ProviderOnboardingBlockReason.onboardingLocked:
        return 'onboarding_locked';
      case ProviderOnboardingBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case ProviderOnboardingBlockReason.networkingDisabled:
        return 'networking_disabled';
      case ProviderOnboardingBlockReason.missingAuthority:
        return 'missing_authority';
      case ProviderOnboardingBlockReason.policyMismatch:
        return 'policy_mismatch';
      case ProviderOnboardingBlockReason.isolationMissing:
        return 'isolation_missing';
      case ProviderOnboardingBlockReason.observabilityMissing:
        return 'observability_missing';
      case ProviderOnboardingBlockReason.rollbackMissing:
        return 'rollback_missing';
      case ProviderOnboardingBlockReason.reviewRequired:
        return 'review_required';
      case ProviderOnboardingBlockReason.unsafeProvider:
        return 'unsafe_provider';
      case ProviderOnboardingBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case ProviderOnboardingBlockReason.providerApprovalMissing:
        return 'provider_approval_missing';
      case ProviderOnboardingBlockReason.providerOwnerMissing:
        return 'provider_owner_missing';
      case ProviderOnboardingBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
