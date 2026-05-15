enum RuntimeRollbackVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  rollbackPlanning,
}

extension RuntimeRollbackVisibilityScopeKey on RuntimeRollbackVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeRollbackVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeRollbackVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeRollbackVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeRollbackVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case RuntimeRollbackVisibilityScope.rollbackPlanning:
        return 'rollback_planning';
    }
  }
}
