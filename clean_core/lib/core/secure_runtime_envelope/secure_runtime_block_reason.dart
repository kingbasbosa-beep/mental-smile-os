enum SecureRuntimeBlockReason {
  runtimeSealed,
  runtimeDisabled,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  restrictedEnvironment,
  unsafeExecution,
  missingAuditLink,
  failClosed,
}

extension SecureRuntimeBlockReasonKey on SecureRuntimeBlockReason {
  String get key {
    switch (this) {
      case SecureRuntimeBlockReason.runtimeSealed:
        return 'runtime_sealed';
      case SecureRuntimeBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case SecureRuntimeBlockReason.missingAuthority:
        return 'missing_authority';
      case SecureRuntimeBlockReason.policyMismatch:
        return 'policy_mismatch';
      case SecureRuntimeBlockReason.reviewRequired:
        return 'review_required';
      case SecureRuntimeBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case SecureRuntimeBlockReason.unsafeExecution:
        return 'unsafe_execution';
      case SecureRuntimeBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case SecureRuntimeBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
