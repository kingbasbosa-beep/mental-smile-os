enum RuntimeEnablementVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  enablementPlanning,
}

extension RuntimeEnablementVisibilityScopeKey
    on RuntimeEnablementVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeEnablementVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeEnablementVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeEnablementVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeEnablementVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case RuntimeEnablementVisibilityScope.enablementPlanning:
        return 'enablement_planning';
    }
  }
}
