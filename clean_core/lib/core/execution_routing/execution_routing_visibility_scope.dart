enum ExecutionRoutingVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  routingPlanning,
}

extension ExecutionRoutingVisibilityScopeKey on ExecutionRoutingVisibilityScope {
  String get key {
    switch (this) {
      case ExecutionRoutingVisibilityScope.backendOnly:
        return 'backend_only';
      case ExecutionRoutingVisibilityScope.auditOnly:
        return 'audit_only';
      case ExecutionRoutingVisibilityScope.restrictedReview:
        return 'restricted_review';
      case ExecutionRoutingVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case ExecutionRoutingVisibilityScope.routingPlanning:
        return 'routing_planning';
    }
  }
}
