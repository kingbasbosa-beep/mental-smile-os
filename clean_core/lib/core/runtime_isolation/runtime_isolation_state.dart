enum RuntimeIsolationState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  isolationCandidate,
  archived,
}

extension RuntimeIsolationStateKey on RuntimeIsolationState {
  String get key {
    switch (this) {
      case RuntimeIsolationState.inactive:
        return 'inactive';
      case RuntimeIsolationState.restricted:
        return 'restricted';
      case RuntimeIsolationState.reviewRequired:
        return 'review_required';
      case RuntimeIsolationState.fallbackOnly:
        return 'fallback_only';
      case RuntimeIsolationState.locked:
        return 'locked';
      case RuntimeIsolationState.sealed:
        return 'sealed';
      case RuntimeIsolationState.isolationCandidate:
        return 'isolation_candidate';
      case RuntimeIsolationState.archived:
        return 'archived';
    }
  }
}
