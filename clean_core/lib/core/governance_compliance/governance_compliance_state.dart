enum GovernanceComplianceState {
  inactive,
  restricted,
  reviewRequired,
  auditRequired,
  fallbackOnly,
  locked,
  archived,
}

extension GovernanceComplianceStateKey on GovernanceComplianceState {
  String get key {
    switch (this) {
      case GovernanceComplianceState.inactive:
        return 'inactive';
      case GovernanceComplianceState.restricted:
        return 'restricted';
      case GovernanceComplianceState.reviewRequired:
        return 'review_required';
      case GovernanceComplianceState.auditRequired:
        return 'audit_required';
      case GovernanceComplianceState.fallbackOnly:
        return 'fallback_only';
      case GovernanceComplianceState.locked:
        return 'locked';
      case GovernanceComplianceState.archived:
        return 'archived';
    }
  }
}
