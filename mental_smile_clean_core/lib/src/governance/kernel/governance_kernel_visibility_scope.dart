enum GovernanceKernelVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  governanceInternal,
}

extension GovernanceKernelVisibilityScopeKey
    on GovernanceKernelVisibilityScope {
  String get key {
    switch (this) {
      case GovernanceKernelVisibilityScope.backendOnly:
        return 'backend_only';
      case GovernanceKernelVisibilityScope.auditOnly:
        return 'audit_only';
      case GovernanceKernelVisibilityScope.restrictedReview:
        return 'restricted_review';
      case GovernanceKernelVisibilityScope.governanceInternal:
        return 'governance_internal';
    }
  }
}
