enum GovernanceComplianceScope {
  legal,
  storeReview,
  audit,
  policy,
  runtime,
  provider,
  environment,
}

extension GovernanceComplianceScopeKey on GovernanceComplianceScope {
  String get key {
    switch (this) {
      case GovernanceComplianceScope.legal:
        return 'legal';
      case GovernanceComplianceScope.storeReview:
        return 'store_review';
      case GovernanceComplianceScope.audit:
        return 'audit';
      case GovernanceComplianceScope.policy:
        return 'policy';
      case GovernanceComplianceScope.runtime:
        return 'runtime';
      case GovernanceComplianceScope.provider:
        return 'provider';
      case GovernanceComplianceScope.environment:
        return 'environment';
    }
  }
}
