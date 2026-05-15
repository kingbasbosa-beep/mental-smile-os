enum RuntimeEnablementBlockReason {
  enablementBlocked,
  enablementLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  unsafeEnablement,
  missingAuditLink,
  readinessMissing,
  rollbackPlanMissing,
  failClosed,
}

extension RuntimeEnablementBlockReasonKey on RuntimeEnablementBlockReason {
  String get key {
    switch (this) {
      case RuntimeEnablementBlockReason.enablementBlocked:
        return 'enablement_blocked';
      case RuntimeEnablementBlockReason.enablementLocked:
        return 'enablement_locked';
      case RuntimeEnablementBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeEnablementBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeEnablementBlockReason.missingAuthority:
        return 'missing_authority';
      case RuntimeEnablementBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeEnablementBlockReason.reviewRequired:
        return 'review_required';
      case RuntimeEnablementBlockReason.unsafeEnablement:
        return 'unsafe_enablement';
      case RuntimeEnablementBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeEnablementBlockReason.readinessMissing:
        return 'readiness_missing';
      case RuntimeEnablementBlockReason.rollbackPlanMissing:
        return 'rollback_plan_missing';
      case RuntimeEnablementBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
