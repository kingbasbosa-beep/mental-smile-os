enum RuntimeIsolationVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  isolationPlanning,
}

extension RuntimeIsolationVisibilityScopeKey
    on RuntimeIsolationVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeIsolationVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeIsolationVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeIsolationVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeIsolationVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case RuntimeIsolationVisibilityScope.isolationPlanning:
        return 'isolation_planning';
    }
  }
}
