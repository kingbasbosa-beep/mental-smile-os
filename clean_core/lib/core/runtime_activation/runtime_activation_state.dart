enum RuntimeActivationState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  activationCandidate,
  archived,
}

extension RuntimeActivationStateKey on RuntimeActivationState {
  String get key {
    switch (this) {
      case RuntimeActivationState.inactive:
        return 'inactive';
      case RuntimeActivationState.restricted:
        return 'restricted';
      case RuntimeActivationState.reviewRequired:
        return 'review_required';
      case RuntimeActivationState.fallbackOnly:
        return 'fallback_only';
      case RuntimeActivationState.locked:
        return 'locked';
      case RuntimeActivationState.sealed:
        return 'sealed';
      case RuntimeActivationState.activationCandidate:
        return 'activation_candidate';
      case RuntimeActivationState.archived:
        return 'archived';
    }
  }
}
