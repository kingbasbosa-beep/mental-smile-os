enum GovernanceCapabilityVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  governanceInternal,
}

extension GovernanceCapabilityVisibilityScopeKey
    on GovernanceCapabilityVisibilityScope {
  String get key {
    switch (this) {
      case GovernanceCapabilityVisibilityScope.backendOnly:
        return 'backend_only';
      case GovernanceCapabilityVisibilityScope.auditOnly:
        return 'audit_only';
      case GovernanceCapabilityVisibilityScope.restrictedReview:
        return 'restricted_review';
      case GovernanceCapabilityVisibilityScope.governanceInternal:
        return 'governance_internal';
    }
  }
}
