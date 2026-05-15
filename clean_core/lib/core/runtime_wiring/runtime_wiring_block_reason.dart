enum RuntimeWiringBlockReason {
  wiringBlocked,
  wiringLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  unsafeWiring,
  missingAuditLink,
  missingOwner,
  unapprovedPath,
  failClosed,
}

extension RuntimeWiringBlockReasonKey on RuntimeWiringBlockReason {
  String get key {
    switch (this) {
      case RuntimeWiringBlockReason.wiringBlocked:
        return 'wiring_blocked';
      case RuntimeWiringBlockReason.wiringLocked:
        return 'wiring_locked';
      case RuntimeWiringBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeWiringBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeWiringBlockReason.missingAuthority:
        return 'missing_authority';
      case RuntimeWiringBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeWiringBlockReason.reviewRequired:
        return 'review_required';
      case RuntimeWiringBlockReason.unsafeWiring:
        return 'unsafe_wiring';
      case RuntimeWiringBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeWiringBlockReason.missingOwner:
        return 'missing_owner';
      case RuntimeWiringBlockReason.unapprovedPath:
        return 'unapproved_path';
      case RuntimeWiringBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
