enum RuntimeObservabilityVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  observabilityPlanning,
}

extension RuntimeObservabilityVisibilityScopeKey
    on RuntimeObservabilityVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeObservabilityVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeObservabilityVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeObservabilityVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeObservabilityVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case RuntimeObservabilityVisibilityScope.observabilityPlanning:
        return 'observability_planning';
    }
  }
}
