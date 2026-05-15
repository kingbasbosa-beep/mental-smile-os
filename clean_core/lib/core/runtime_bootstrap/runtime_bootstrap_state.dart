enum RuntimeBootstrapState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  bootstrapCandidate,
  archived,
}

extension RuntimeBootstrapStateKey on RuntimeBootstrapState {
  String get key {
    switch (this) {
      case RuntimeBootstrapState.inactive:
        return 'inactive';
      case RuntimeBootstrapState.restricted:
        return 'restricted';
      case RuntimeBootstrapState.reviewRequired:
        return 'review_required';
      case RuntimeBootstrapState.fallbackOnly:
        return 'fallback_only';
      case RuntimeBootstrapState.locked:
        return 'locked';
      case RuntimeBootstrapState.sealed:
        return 'sealed';
      case RuntimeBootstrapState.bootstrapCandidate:
        return 'bootstrap_candidate';
      case RuntimeBootstrapState.archived:
        return 'archived';
    }
  }
}
