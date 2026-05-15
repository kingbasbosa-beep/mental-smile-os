enum EnvironmentActivationState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  activationCandidate,
  archived,
}

extension EnvironmentActivationStateKey on EnvironmentActivationState {
  String get key {
    switch (this) {
      case EnvironmentActivationState.inactive:
        return 'inactive';
      case EnvironmentActivationState.restricted:
        return 'restricted';
      case EnvironmentActivationState.reviewRequired:
        return 'review_required';
      case EnvironmentActivationState.fallbackOnly:
        return 'fallback_only';
      case EnvironmentActivationState.locked:
        return 'locked';
      case EnvironmentActivationState.sealed:
        return 'sealed';
      case EnvironmentActivationState.activationCandidate:
        return 'activation_candidate';
      case EnvironmentActivationState.archived:
        return 'archived';
    }
  }
}
