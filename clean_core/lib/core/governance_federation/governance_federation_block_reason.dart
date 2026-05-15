enum GovernanceFederationBlockReason {
  federationLocked,
  runtimeDisabled,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  restrictedEnvironment,
  unsafeFederation,
  missingAuditLink,
  failClosed,
}

extension GovernanceFederationBlockReasonKey
    on GovernanceFederationBlockReason {
  String get key {
    switch (this) {
      case GovernanceFederationBlockReason.federationLocked:
        return 'federation_locked';
      case GovernanceFederationBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case GovernanceFederationBlockReason.missingAuthority:
        return 'missing_authority';
      case GovernanceFederationBlockReason.policyMismatch:
        return 'policy_mismatch';
      case GovernanceFederationBlockReason.reviewRequired:
        return 'review_required';
      case GovernanceFederationBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case GovernanceFederationBlockReason.unsafeFederation:
        return 'unsafe_federation';
      case GovernanceFederationBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case GovernanceFederationBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
