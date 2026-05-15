enum GovernanceFederationVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  governanceInternal,
}

extension GovernanceFederationVisibilityScopeKey
    on GovernanceFederationVisibilityScope {
  String get key {
    switch (this) {
      case GovernanceFederationVisibilityScope.backendOnly:
        return 'backend_only';
      case GovernanceFederationVisibilityScope.auditOnly:
        return 'audit_only';
      case GovernanceFederationVisibilityScope.restrictedReview:
        return 'restricted_review';
      case GovernanceFederationVisibilityScope.governanceInternal:
        return 'governance_internal';
    }
  }
}
