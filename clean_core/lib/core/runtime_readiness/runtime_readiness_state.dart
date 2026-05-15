enum RuntimeReadinessState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  archived,
  readyPlaceholder,
}

extension RuntimeReadinessStateKey on RuntimeReadinessState {
  String get key {
    switch (this) {
      case RuntimeReadinessState.inactive:
        return 'inactive';
      case RuntimeReadinessState.restricted:
        return 'restricted';
      case RuntimeReadinessState.reviewRequired:
        return 'review_required';
      case RuntimeReadinessState.fallbackOnly:
        return 'fallback_only';
      case RuntimeReadinessState.locked:
        return 'locked';
      case RuntimeReadinessState.sealed:
        return 'sealed';
      case RuntimeReadinessState.archived:
        return 'archived';
      case RuntimeReadinessState.readyPlaceholder:
        return 'ready_placeholder';
    }
  }
}
