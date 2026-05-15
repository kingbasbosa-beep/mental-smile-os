enum RuntimeReleaseVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  releasePlanning,
}

extension RuntimeReleaseVisibilityScopeKey on RuntimeReleaseVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeReleaseVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeReleaseVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeReleaseVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeReleaseVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case RuntimeReleaseVisibilityScope.releasePlanning:
        return 'release_planning';
    }
  }
}
