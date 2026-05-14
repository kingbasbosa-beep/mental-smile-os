enum TrustedBackendState {
  unavailable,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  archived,
}

extension TrustedBackendStateKey on TrustedBackendState {
  String get key {
    switch (this) {
      case TrustedBackendState.unavailable:
        return 'unavailable';
      case TrustedBackendState.restricted:
        return 'restricted';
      case TrustedBackendState.reviewRequired:
        return 'review_required';
      case TrustedBackendState.fallbackOnly:
        return 'fallback_only';
      case TrustedBackendState.locked:
        return 'locked';
      case TrustedBackendState.archived:
        return 'archived';
    }
  }
}
