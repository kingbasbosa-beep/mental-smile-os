enum GovernanceComplianceVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  complianceInternal,
}

extension GovernanceComplianceVisibilityScopeKey
    on GovernanceComplianceVisibilityScope {
  String get key {
    switch (this) {
      case GovernanceComplianceVisibilityScope.backendOnly:
        return 'backend_only';
      case GovernanceComplianceVisibilityScope.auditOnly:
        return 'audit_only';
      case GovernanceComplianceVisibilityScope.restrictedReview:
        return 'restricted_review';
      case GovernanceComplianceVisibilityScope.complianceInternal:
        return 'compliance_internal';
    }
  }
}
