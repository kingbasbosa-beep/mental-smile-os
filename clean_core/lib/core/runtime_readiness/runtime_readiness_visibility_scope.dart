enum RuntimeReadinessVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  governanceInternal,
}

extension RuntimeReadinessVisibilityScopeKey
    on RuntimeReadinessVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeReadinessVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeReadinessVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeReadinessVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeReadinessVisibilityScope.governanceInternal:
        return 'governance_internal';
    }
  }
}
