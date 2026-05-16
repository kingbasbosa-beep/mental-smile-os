enum GovernanceCapabilityState {
  unavailable,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  archived,
}

extension GovernanceCapabilityStateKey on GovernanceCapabilityState {
  String get key {
    switch (this) {
      case GovernanceCapabilityState.unavailable:
        return 'unavailable';
      case GovernanceCapabilityState.restricted:
        return 'restricted';
      case GovernanceCapabilityState.reviewRequired:
        return 'review_required';
      case GovernanceCapabilityState.fallbackOnly:
        return 'fallback_only';
      case GovernanceCapabilityState.locked:
        return 'locked';
      case GovernanceCapabilityState.archived:
        return 'archived';
    }
  }
}
