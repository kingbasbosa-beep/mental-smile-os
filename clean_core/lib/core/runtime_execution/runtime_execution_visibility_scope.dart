enum RuntimeExecutionVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  runtimeInternal,
}

extension RuntimeExecutionVisibilityScopeKey on RuntimeExecutionVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeExecutionVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeExecutionVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeExecutionVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeExecutionVisibilityScope.runtimeInternal:
        return 'runtime_internal';
    }
  }
}
