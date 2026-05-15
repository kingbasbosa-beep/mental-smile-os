enum ExecutionRoutingState {
  inactive,
  restricted,
  reviewRequired,
  fallbackOnly,
  locked,
  sealed,
  routingCandidate,
  archived,
}

extension ExecutionRoutingStateKey on ExecutionRoutingState {
  String get key {
    switch (this) {
      case ExecutionRoutingState.inactive:
        return 'inactive';
      case ExecutionRoutingState.restricted:
        return 'restricted';
      case ExecutionRoutingState.reviewRequired:
        return 'review_required';
      case ExecutionRoutingState.fallbackOnly:
        return 'fallback_only';
      case ExecutionRoutingState.locked:
        return 'locked';
      case ExecutionRoutingState.sealed:
        return 'sealed';
      case ExecutionRoutingState.routingCandidate:
        return 'routing_candidate';
      case ExecutionRoutingState.archived:
        return 'archived';
    }
  }
}
