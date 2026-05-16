enum GovernanceFederationState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  archived,
}

extension GovernanceFederationStateKey on GovernanceFederationState {
  String get key {
    switch (this) {
      case GovernanceFederationState.inactive:
        return 'inactive';
      case GovernanceFederationState.restricted:
        return 'restricted';
      case GovernanceFederationState.reviewRequired:
        return 'review_required';
      case GovernanceFederationState.fallbackOnly:
        return 'fallback_only';
      case GovernanceFederationState.locked:
        return 'locked';
      case GovernanceFederationState.sealed:
        return 'sealed';
      case GovernanceFederationState.archived:
        return 'archived';
    }
  }
}
