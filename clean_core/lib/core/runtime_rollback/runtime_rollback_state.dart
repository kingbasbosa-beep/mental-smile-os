enum RuntimeRollbackState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  rollbackCandidate,
  archived,
}

extension RuntimeRollbackStateKey on RuntimeRollbackState {
  String get key {
    switch (this) {
      case RuntimeRollbackState.inactive:
        return 'inactive';
      case RuntimeRollbackState.restricted:
        return 'restricted';
      case RuntimeRollbackState.reviewRequired:
        return 'review_required';
      case RuntimeRollbackState.fallbackOnly:
        return 'fallback_only';
      case RuntimeRollbackState.locked:
        return 'locked';
      case RuntimeRollbackState.sealed:
        return 'sealed';
      case RuntimeRollbackState.rollbackCandidate:
        return 'rollback_candidate';
      case RuntimeRollbackState.archived:
        return 'archived';
    }
  }
}
