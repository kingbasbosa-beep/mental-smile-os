enum EnvironmentActivationBlockReason {
  environmentBlocked,
  environmentLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  unsafeEnvironment,
  missingAuditLink,
  missingOwner,
  permissionDenied,
  failClosed,
}

extension EnvironmentActivationBlockReasonKey
    on EnvironmentActivationBlockReason {
  String get key {
    switch (this) {
      case EnvironmentActivationBlockReason.environmentBlocked:
        return 'environment_blocked';
      case EnvironmentActivationBlockReason.environmentLocked:
        return 'environment_locked';
      case EnvironmentActivationBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case EnvironmentActivationBlockReason.providerBlocked:
        return 'provider_blocked';
      case EnvironmentActivationBlockReason.missingAuthority:
        return 'missing_authority';
      case EnvironmentActivationBlockReason.policyMismatch:
        return 'policy_mismatch';
      case EnvironmentActivationBlockReason.reviewRequired:
        return 'review_required';
      case EnvironmentActivationBlockReason.unsafeEnvironment:
        return 'unsafe_environment';
      case EnvironmentActivationBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case EnvironmentActivationBlockReason.missingOwner:
        return 'missing_owner';
      case EnvironmentActivationBlockReason.permissionDenied:
        return 'permission_denied';
      case EnvironmentActivationBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
