enum RuntimeBootstrapBlockReason {
  bootstrapBlocked,
  bootstrapLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  releaseMissing,
  rollbackMissing,
  observabilityMissing,
  isolationMissing,
  reviewRequired,
  unsafeBootstrap,
  missingAuditLink,
  bootstrapApprovalMissing,
  bootstrapOwnerMissing,
  failClosed,
}

extension RuntimeBootstrapBlockReasonKey on RuntimeBootstrapBlockReason {
  String get key {
    switch (this) {
      case RuntimeBootstrapBlockReason.bootstrapBlocked:
        return 'bootstrap_blocked';
      case RuntimeBootstrapBlockReason.bootstrapLocked:
        return 'bootstrap_locked';
      case RuntimeBootstrapBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeBootstrapBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeBootstrapBlockReason.missingAuthority:
        return 'missing_authority';
      case RuntimeBootstrapBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeBootstrapBlockReason.releaseMissing:
        return 'release_missing';
      case RuntimeBootstrapBlockReason.rollbackMissing:
        return 'rollback_missing';
      case RuntimeBootstrapBlockReason.observabilityMissing:
        return 'observability_missing';
      case RuntimeBootstrapBlockReason.isolationMissing:
        return 'isolation_missing';
      case RuntimeBootstrapBlockReason.reviewRequired:
        return 'review_required';
      case RuntimeBootstrapBlockReason.unsafeBootstrap:
        return 'unsafe_bootstrap';
      case RuntimeBootstrapBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeBootstrapBlockReason.bootstrapApprovalMissing:
        return 'bootstrap_approval_missing';
      case RuntimeBootstrapBlockReason.bootstrapOwnerMissing:
        return 'bootstrap_owner_missing';
      case RuntimeBootstrapBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
