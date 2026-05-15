enum RuntimeReleaseState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  releaseCandidate,
  archived,
}

extension RuntimeReleaseStateKey on RuntimeReleaseState {
  String get key {
    switch (this) {
      case RuntimeReleaseState.inactive:
        return 'inactive';
      case RuntimeReleaseState.restricted:
        return 'restricted';
      case RuntimeReleaseState.reviewRequired:
        return 'review_required';
      case RuntimeReleaseState.fallbackOnly:
        return 'fallback_only';
      case RuntimeReleaseState.locked:
        return 'locked';
      case RuntimeReleaseState.sealed:
        return 'sealed';
      case RuntimeReleaseState.releaseCandidate:
        return 'release_candidate';
      case RuntimeReleaseState.archived:
        return 'archived';
    }
  }
}
