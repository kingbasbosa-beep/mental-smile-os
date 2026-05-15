enum SecureRuntimeState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  archived,
}

extension SecureRuntimeStateKey on SecureRuntimeState {
  String get key {
    switch (this) {
      case SecureRuntimeState.inactive:
        return 'inactive';
      case SecureRuntimeState.restricted:
        return 'restricted';
      case SecureRuntimeState.reviewRequired:
        return 'review_required';
      case SecureRuntimeState.fallbackOnly:
        return 'fallback_only';
      case SecureRuntimeState.locked:
        return 'locked';
      case SecureRuntimeState.sealed:
        return 'sealed';
      case SecureRuntimeState.archived:
        return 'archived';
    }
  }
}
