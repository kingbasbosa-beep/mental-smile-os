enum ProviderOnboardingState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  onboardingCandidate,
  archived,
}

extension ProviderOnboardingStateKey on ProviderOnboardingState {
  String get key {
    switch (this) {
      case ProviderOnboardingState.inactive:
        return 'inactive';
      case ProviderOnboardingState.restricted:
        return 'restricted';
      case ProviderOnboardingState.reviewRequired:
        return 'review_required';
      case ProviderOnboardingState.fallbackOnly:
        return 'fallback_only';
      case ProviderOnboardingState.locked:
        return 'locked';
      case ProviderOnboardingState.sealed:
        return 'sealed';
      case ProviderOnboardingState.onboardingCandidate:
        return 'onboarding_candidate';
      case ProviderOnboardingState.archived:
        return 'archived';
    }
  }
}
