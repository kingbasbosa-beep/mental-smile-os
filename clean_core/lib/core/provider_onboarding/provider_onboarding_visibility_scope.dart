enum ProviderOnboardingVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  onboardingPlanning,
}

extension ProviderOnboardingVisibilityScopeKey
    on ProviderOnboardingVisibilityScope {
  String get key {
    switch (this) {
      case ProviderOnboardingVisibilityScope.backendOnly:
        return 'backend_only';
      case ProviderOnboardingVisibilityScope.auditOnly:
        return 'audit_only';
      case ProviderOnboardingVisibilityScope.restrictedReview:
        return 'restricted_review';
      case ProviderOnboardingVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case ProviderOnboardingVisibilityScope.onboardingPlanning:
        return 'onboarding_planning';
    }
  }
}
