enum RuntimeRollbackBlockReason {
  rollbackBlocked,
  rollbackLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  unsafeRollback,
  missingAuditLink,
  rollbackApprovalMissing,
  rollbackOwnerMissing,
  failClosed,
}

extension RuntimeRollbackBlockReasonKey on RuntimeRollbackBlockReason {
  String get key {
    switch (this) {
      case RuntimeRollbackBlockReason.rollbackBlocked:
        return 'rollback_blocked';
      case RuntimeRollbackBlockReason.rollbackLocked:
        return 'rollback_locked';
      case RuntimeRollbackBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeRollbackBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeRollbackBlockReason.missingAuthority:
        return 'missing_authority';
      case RuntimeRollbackBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeRollbackBlockReason.reviewRequired:
        return 'review_required';
      case RuntimeRollbackBlockReason.unsafeRollback:
        return 'unsafe_rollback';
      case RuntimeRollbackBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeRollbackBlockReason.rollbackApprovalMissing:
        return 'rollback_approval_missing';
      case RuntimeRollbackBlockReason.rollbackOwnerMissing:
        return 'rollback_owner_missing';
      case RuntimeRollbackBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
