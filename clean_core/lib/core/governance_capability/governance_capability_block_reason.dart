enum GovernanceCapabilityBlockReason {
  capabilityBlocked,
  runtimeDisabled,
  policyMismatch,
  providerBlocked,
  reviewRequired,
  restrictedEnvironment,
  unsafeCapability,
  missingAuditLink,
  failClosed,
}

extension GovernanceCapabilityBlockReasonKey
    on GovernanceCapabilityBlockReason {
  String get key {
    switch (this) {
      case GovernanceCapabilityBlockReason.capabilityBlocked:
        return 'capability_blocked';
      case GovernanceCapabilityBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case GovernanceCapabilityBlockReason.policyMismatch:
        return 'policy_mismatch';
      case GovernanceCapabilityBlockReason.providerBlocked:
        return 'provider_blocked';
      case GovernanceCapabilityBlockReason.reviewRequired:
        return 'review_required';
      case GovernanceCapabilityBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case GovernanceCapabilityBlockReason.unsafeCapability:
        return 'unsafe_capability';
      case GovernanceCapabilityBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case GovernanceCapabilityBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
