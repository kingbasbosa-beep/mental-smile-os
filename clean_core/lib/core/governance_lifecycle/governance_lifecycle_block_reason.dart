enum GovernanceLifecycleBlockReason {
  invalidTransition,
  runtimeDisabled,
  policyMismatch,
  providerBlocked,
  reviewRequired,
  restrictedEnvironment,
  unsafeCoordination,
  missingAuditLink,
  locked,
  failClosed,
}

extension GovernanceLifecycleBlockReasonKey on GovernanceLifecycleBlockReason {
  String get key {
    switch (this) {
      case GovernanceLifecycleBlockReason.invalidTransition:
        return 'invalid_transition';
      case GovernanceLifecycleBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case GovernanceLifecycleBlockReason.policyMismatch:
        return 'policy_mismatch';
      case GovernanceLifecycleBlockReason.providerBlocked:
        return 'provider_blocked';
      case GovernanceLifecycleBlockReason.reviewRequired:
        return 'review_required';
      case GovernanceLifecycleBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case GovernanceLifecycleBlockReason.unsafeCoordination:
        return 'unsafe_coordination';
      case GovernanceLifecycleBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case GovernanceLifecycleBlockReason.locked:
        return 'locked';
      case GovernanceLifecycleBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
