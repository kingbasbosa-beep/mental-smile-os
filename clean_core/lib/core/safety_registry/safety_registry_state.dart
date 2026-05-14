enum SafetyRegistryState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  archived,
}

extension SafetyRegistryStateKey on SafetyRegistryState {
  String get key {
    switch (this) {
      case SafetyRegistryState.inactive:
        return 'inactive';
      case SafetyRegistryState.restricted:
        return 'restricted';
      case SafetyRegistryState.reviewRequired:
        return 'review_required';
      case SafetyRegistryState.fallbackOnly:
        return 'fallback_only';
      case SafetyRegistryState.locked:
        return 'locked';
      case SafetyRegistryState.archived:
        return 'archived';
    }
  }
}
