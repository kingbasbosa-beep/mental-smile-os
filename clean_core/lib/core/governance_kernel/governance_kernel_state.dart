enum GovernanceKernelState {
  inactive,
  restricted,
  fallbackOnly,
  reviewRequired,
  locked,
  archived,
}

extension GovernanceKernelStateKey on GovernanceKernelState {
  String get key {
    switch (this) {
      case GovernanceKernelState.inactive:
        return 'inactive';
      case GovernanceKernelState.restricted:
        return 'restricted';
      case GovernanceKernelState.fallbackOnly:
        return 'fallback_only';
      case GovernanceKernelState.reviewRequired:
        return 'review_required';
      case GovernanceKernelState.locked:
        return 'locked';
      case GovernanceKernelState.archived:
        return 'archived';
    }
  }
}
