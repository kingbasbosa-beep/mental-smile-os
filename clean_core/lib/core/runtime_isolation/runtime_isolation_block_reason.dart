enum RuntimeIsolationBlockReason {
  isolationBlocked,
  isolationLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  unsafeIsolation,
  missingAuditLink,
  isolationBoundaryMissing,
  failClosed,
}

extension RuntimeIsolationBlockReasonKey on RuntimeIsolationBlockReason {
  String get key {
    switch (this) {
      case RuntimeIsolationBlockReason.isolationBlocked:
        return 'isolation_blocked';
      case RuntimeIsolationBlockReason.isolationLocked:
        return 'isolation_locked';
      case RuntimeIsolationBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeIsolationBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeIsolationBlockReason.missingAuthority:
        return 'missing_authority';
      case RuntimeIsolationBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeIsolationBlockReason.reviewRequired:
        return 'review_required';
      case RuntimeIsolationBlockReason.unsafeIsolation:
        return 'unsafe_isolation';
      case RuntimeIsolationBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeIsolationBlockReason.isolationBoundaryMissing:
        return 'isolation_boundary_missing';
      case RuntimeIsolationBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
