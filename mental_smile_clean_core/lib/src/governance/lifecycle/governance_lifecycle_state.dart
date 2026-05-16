enum GovernanceLifecycleState {
  inactive,
  initializing,
  restricted,
  fallbackOnly,
  reviewRequired,
  locked,
  archived,
}

extension GovernanceLifecycleStateKey on GovernanceLifecycleState {
  String get key {
    switch (this) {
      case GovernanceLifecycleState.inactive:
        return 'inactive';
      case GovernanceLifecycleState.initializing:
        return 'initializing';
      case GovernanceLifecycleState.restricted:
        return 'restricted';
      case GovernanceLifecycleState.fallbackOnly:
        return 'fallback_only';
      case GovernanceLifecycleState.reviewRequired:
        return 'review_required';
      case GovernanceLifecycleState.locked:
        return 'locked';
      case GovernanceLifecycleState.archived:
        return 'archived';
    }
  }
}
