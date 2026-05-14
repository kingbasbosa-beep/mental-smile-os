enum SafetyRegistryBlockReason {
  registryLocked,
  policyMismatch,
  runtimeDisabled,
  providerBlocked,
  reviewRequired,
  missingAuditLink,
  unsafeRegistration,
  visibilityRestricted,
  failClosed,
}

extension SafetyRegistryBlockReasonKey on SafetyRegistryBlockReason {
  String get key {
    switch (this) {
      case SafetyRegistryBlockReason.registryLocked:
        return 'registry_locked';
      case SafetyRegistryBlockReason.policyMismatch:
        return 'policy_mismatch';
      case SafetyRegistryBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case SafetyRegistryBlockReason.providerBlocked:
        return 'provider_blocked';
      case SafetyRegistryBlockReason.reviewRequired:
        return 'review_required';
      case SafetyRegistryBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case SafetyRegistryBlockReason.unsafeRegistration:
        return 'unsafe_registration';
      case SafetyRegistryBlockReason.visibilityRestricted:
        return 'visibility_restricted';
      case SafetyRegistryBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
