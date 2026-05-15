enum RuntimeObservabilityState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  observationCandidate,
  archived,
}

extension RuntimeObservabilityStateKey on RuntimeObservabilityState {
  String get key {
    switch (this) {
      case RuntimeObservabilityState.inactive:
        return 'inactive';
      case RuntimeObservabilityState.restricted:
        return 'restricted';
      case RuntimeObservabilityState.reviewRequired:
        return 'review_required';
      case RuntimeObservabilityState.fallbackOnly:
        return 'fallback_only';
      case RuntimeObservabilityState.locked:
        return 'locked';
      case RuntimeObservabilityState.sealed:
        return 'sealed';
      case RuntimeObservabilityState.observationCandidate:
        return 'observation_candidate';
      case RuntimeObservabilityState.archived:
        return 'archived';
    }
  }
}
