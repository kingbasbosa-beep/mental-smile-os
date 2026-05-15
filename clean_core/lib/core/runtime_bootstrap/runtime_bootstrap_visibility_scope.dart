enum RuntimeBootstrapVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  bootstrapPlanning,
}

extension RuntimeBootstrapVisibilityScopeKey
    on RuntimeBootstrapVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeBootstrapVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeBootstrapVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeBootstrapVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeBootstrapVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case RuntimeBootstrapVisibilityScope.bootstrapPlanning:
        return 'bootstrap_planning';
    }
  }
}
