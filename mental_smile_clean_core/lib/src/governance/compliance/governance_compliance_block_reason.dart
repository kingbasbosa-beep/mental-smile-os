enum GovernanceComplianceBlockReason {
  policyMismatch,
  runtimeDisabled,
  providerBlocked,
  missingAuditLink,
  reviewRequired,
  restrictedEnvironment,
  complianceRestricted,
  missingLegalDisclaimer,
  failClosed,
}

extension GovernanceComplianceBlockReasonKey
    on GovernanceComplianceBlockReason {
  String get key {
    switch (this) {
      case GovernanceComplianceBlockReason.policyMismatch:
        return 'policy_mismatch';
      case GovernanceComplianceBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case GovernanceComplianceBlockReason.providerBlocked:
        return 'provider_blocked';
      case GovernanceComplianceBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case GovernanceComplianceBlockReason.reviewRequired:
        return 'review_required';
      case GovernanceComplianceBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case GovernanceComplianceBlockReason.complianceRestricted:
        return 'compliance_restricted';
      case GovernanceComplianceBlockReason.missingLegalDisclaimer:
        return 'missing_legal_disclaimer';
      case GovernanceComplianceBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
