enum RuntimeExecutionState {
  disabled,
  blocked,
  fallbackOnly,
  restricted,
  reviewRequired,
  archived,
}

extension RuntimeExecutionStateKey on RuntimeExecutionState {
  String get key {
    switch (this) {
      case RuntimeExecutionState.disabled:
        return 'disabled';
      case RuntimeExecutionState.blocked:
        return 'blocked';
      case RuntimeExecutionState.fallbackOnly:
        return 'fallback_only';
      case RuntimeExecutionState.restricted:
        return 'restricted';
      case RuntimeExecutionState.reviewRequired:
        return 'review_required';
      case RuntimeExecutionState.archived:
        return 'archived';
    }
  }
}
