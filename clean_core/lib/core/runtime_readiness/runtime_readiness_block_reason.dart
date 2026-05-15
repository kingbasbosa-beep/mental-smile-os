enum RuntimeReadinessBlockReason {
  readinessLocked,
  runtimeDisabled,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  restrictedEnvironment,
  unsafeActivation,
  missingAuditLink,
  failClosed,
}

extension RuntimeReadinessBlockReasonKey on RuntimeReadinessBlockReason {
  String get key {
    switch (this) {
      case RuntimeReadinessBlockReason.readinessLocked:
        return 'readiness_locked';
      case RuntimeReadinessBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeReadinessBlockReason.missingAuthority:
        return 'missing_authority';
      case RuntimeReadinessBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeReadinessBlockReason.reviewRequired:
        return 'review_required';
      case RuntimeReadinessBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case RuntimeReadinessBlockReason.unsafeActivation:
        return 'unsafe_activation';
      case RuntimeReadinessBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeReadinessBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
