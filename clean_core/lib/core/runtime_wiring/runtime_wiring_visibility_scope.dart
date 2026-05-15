enum RuntimeWiringVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  wiringPlanning,
}

extension RuntimeWiringVisibilityScopeKey on RuntimeWiringVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeWiringVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeWiringVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeWiringVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeWiringVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case RuntimeWiringVisibilityScope.wiringPlanning:
        return 'wiring_planning';
    }
  }
}
