enum RuntimeEnablementState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  enablementCandidate,
  archived,
}

extension RuntimeEnablementStateKey on RuntimeEnablementState {
  String get key {
    switch (this) {
      case RuntimeEnablementState.inactive:
        return 'inactive';
      case RuntimeEnablementState.restricted:
        return 'restricted';
      case RuntimeEnablementState.reviewRequired:
        return 'review_required';
      case RuntimeEnablementState.fallbackOnly:
        return 'fallback_only';
      case RuntimeEnablementState.locked:
        return 'locked';
      case RuntimeEnablementState.sealed:
        return 'sealed';
      case RuntimeEnablementState.enablementCandidate:
        return 'enablement_candidate';
      case RuntimeEnablementState.archived:
        return 'archived';
    }
  }
}
