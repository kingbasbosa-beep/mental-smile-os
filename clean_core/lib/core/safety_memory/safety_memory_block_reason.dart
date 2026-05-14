enum SafetyMemoryBlockReason {
  retentionNotAllowed,
  unsafeContext,
  missingAuditLink,
  policyRestricted,
  restrictedEnvironment,
  reviewRequired,
  runtimeDisabled,
  failClosed,
}

extension SafetyMemoryBlockReasonKey on SafetyMemoryBlockReason {
  String get key {
    switch (this) {
      case SafetyMemoryBlockReason.retentionNotAllowed:
        return 'retention_not_allowed';
      case SafetyMemoryBlockReason.unsafeContext:
        return 'unsafe_context';
      case SafetyMemoryBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case SafetyMemoryBlockReason.policyRestricted:
        return 'policy_restricted';
      case SafetyMemoryBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case SafetyMemoryBlockReason.reviewRequired:
        return 'review_required';
      case SafetyMemoryBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case SafetyMemoryBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
