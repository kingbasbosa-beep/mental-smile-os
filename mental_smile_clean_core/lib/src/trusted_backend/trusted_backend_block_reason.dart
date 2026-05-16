enum TrustedBackendBlockReason {
  backendBlocked,
  runtimeDisabled,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  restrictedEnvironment,
  unsafeExecution,
  missingAuditLink,
  failClosed,
}

extension TrustedBackendBlockReasonKey on TrustedBackendBlockReason {
  String get key {
    switch (this) {
      case TrustedBackendBlockReason.backendBlocked:
        return 'backend_blocked';
      case TrustedBackendBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case TrustedBackendBlockReason.missingAuthority:
        return 'missing_authority';
      case TrustedBackendBlockReason.policyMismatch:
        return 'policy_mismatch';
      case TrustedBackendBlockReason.reviewRequired:
        return 'review_required';
      case TrustedBackendBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case TrustedBackendBlockReason.unsafeExecution:
        return 'unsafe_execution';
      case TrustedBackendBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case TrustedBackendBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
