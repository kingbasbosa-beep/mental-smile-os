enum RuntimeWiringState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  wiringCandidate,
  archived,
}

extension RuntimeWiringStateKey on RuntimeWiringState {
  String get key {
    switch (this) {
      case RuntimeWiringState.inactive:
        return 'inactive';
      case RuntimeWiringState.restricted:
        return 'restricted';
      case RuntimeWiringState.reviewRequired:
        return 'review_required';
      case RuntimeWiringState.fallbackOnly:
        return 'fallback_only';
      case RuntimeWiringState.locked:
        return 'locked';
      case RuntimeWiringState.sealed:
        return 'sealed';
      case RuntimeWiringState.wiringCandidate:
        return 'wiring_candidate';
      case RuntimeWiringState.archived:
        return 'archived';
    }
  }
}
