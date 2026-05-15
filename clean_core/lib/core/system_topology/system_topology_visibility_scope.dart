enum SystemTopologyVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  governanceInternal,
}

extension SystemTopologyVisibilityScopeKey on SystemTopologyVisibilityScope {
  String get key {
    switch (this) {
      case SystemTopologyVisibilityScope.backendOnly:
        return 'backend_only';
      case SystemTopologyVisibilityScope.auditOnly:
        return 'audit_only';
      case SystemTopologyVisibilityScope.restrictedReview:
        return 'restricted_review';
      case SystemTopologyVisibilityScope.governanceInternal:
        return 'governance_internal';
    }
  }
}
