enum ProviderOnboardingStage {
  onboardingRequest,
  governanceReview,
  auditReview,
  capabilityReview,
  isolationReview,
  observabilityReview,
  rollbackReview,
  providerDenied,
  onboardingFallback,
}

extension ProviderOnboardingStageKey on ProviderOnboardingStage {
  String get key {
    switch (this) {
      case ProviderOnboardingStage.onboardingRequest:
        return 'onboarding_request';
      case ProviderOnboardingStage.governanceReview:
        return 'governance_review';
      case ProviderOnboardingStage.auditReview:
        return 'audit_review';
      case ProviderOnboardingStage.capabilityReview:
        return 'capability_review';
      case ProviderOnboardingStage.isolationReview:
        return 'isolation_review';
      case ProviderOnboardingStage.observabilityReview:
        return 'observability_review';
      case ProviderOnboardingStage.rollbackReview:
        return 'rollback_review';
      case ProviderOnboardingStage.providerDenied:
        return 'provider_denied';
      case ProviderOnboardingStage.onboardingFallback:
        return 'onboarding_fallback';
    }
  }
}
