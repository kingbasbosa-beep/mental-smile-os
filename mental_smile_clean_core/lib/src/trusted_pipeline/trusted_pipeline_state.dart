enum TrustedPipelineState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  archived,
}

extension TrustedPipelineStateKey on TrustedPipelineState {
  String get key {
    switch (this) {
      case TrustedPipelineState.inactive:
        return 'inactive';
      case TrustedPipelineState.restricted:
        return 'restricted';
      case TrustedPipelineState.reviewRequired:
        return 'review_required';
      case TrustedPipelineState.fallbackOnly:
        return 'fallback_only';
      case TrustedPipelineState.locked:
        return 'locked';
      case TrustedPipelineState.archived:
        return 'archived';
    }
  }
}
