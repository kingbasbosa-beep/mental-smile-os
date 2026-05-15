enum RuntimeReleaseBlockReason {
  releaseBlocked,
  releaseLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  rollbackMissing,
  observabilityMissing,
  isolationMissing,
  reviewRequired,
  unsafeRelease,
  missingAuditLink,
  releaseApprovalMissing,
  releaseOwnerMissing,
  failClosed,
}

extension RuntimeReleaseBlockReasonKey on RuntimeReleaseBlockReason {
  String get key {
    switch (this) {
      case RuntimeReleaseBlockReason.releaseBlocked:
        return 'release_blocked';
      case RuntimeReleaseBlockReason.releaseLocked:
        return 'release_locked';
      case RuntimeReleaseBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeReleaseBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeReleaseBlockReason.missingAuthority:
        return 'missing_authority';
      case RuntimeReleaseBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeReleaseBlockReason.rollbackMissing:
        return 'rollback_missing';
      case RuntimeReleaseBlockReason.observabilityMissing:
        return 'observability_missing';
      case RuntimeReleaseBlockReason.isolationMissing:
        return 'isolation_missing';
      case RuntimeReleaseBlockReason.reviewRequired:
        return 'review_required';
      case RuntimeReleaseBlockReason.unsafeRelease:
        return 'unsafe_release';
      case RuntimeReleaseBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeReleaseBlockReason.releaseApprovalMissing:
        return 'release_approval_missing';
      case RuntimeReleaseBlockReason.releaseOwnerMissing:
        return 'release_owner_missing';
      case RuntimeReleaseBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
