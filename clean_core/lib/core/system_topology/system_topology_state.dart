enum SystemTopologyState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  archived,
  mappedPlaceholder,
}

extension SystemTopologyStateKey on SystemTopologyState {
  String get key {
    switch (this) {
      case SystemTopologyState.inactive:
        return 'inactive';
      case SystemTopologyState.restricted:
        return 'restricted';
      case SystemTopologyState.reviewRequired:
        return 'review_required';
      case SystemTopologyState.fallbackOnly:
        return 'fallback_only';
      case SystemTopologyState.locked:
        return 'locked';
      case SystemTopologyState.sealed:
        return 'sealed';
      case SystemTopologyState.archived:
        return 'archived';
      case SystemTopologyState.mappedPlaceholder:
        return 'mapped_placeholder';
    }
  }
}
