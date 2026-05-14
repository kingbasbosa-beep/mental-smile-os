enum GovernanceLifecycleVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  governanceInternal,
}

extension GovernanceLifecycleVisibilityScopeKey
    on GovernanceLifecycleVisibilityScope {
  String get key {
    switch (this) {
      case GovernanceLifecycleVisibilityScope.backendOnly:
        return 'backend_only';
      case GovernanceLifecycleVisibilityScope.auditOnly:
        return 'audit_only';
      case GovernanceLifecycleVisibilityScope.restrictedReview:
        return 'restricted_review';
      case GovernanceLifecycleVisibilityScope.governanceInternal:
        return 'governance_internal';
    }
  }
}
