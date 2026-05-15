enum SystemTopologyBlockReason {
  topologyLocked,
  runtimeDisabled,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  restrictedEnvironment,
  unsafeDependency,
  missingAuditLink,
  failClosed,
}

extension SystemTopologyBlockReasonKey on SystemTopologyBlockReason {
  String get key {
    switch (this) {
      case SystemTopologyBlockReason.topologyLocked:
        return 'topology_locked';
      case SystemTopologyBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case SystemTopologyBlockReason.missingAuthority:
        return 'missing_authority';
      case SystemTopologyBlockReason.policyMismatch:
        return 'policy_mismatch';
      case SystemTopologyBlockReason.reviewRequired:
        return 'review_required';
      case SystemTopologyBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case SystemTopologyBlockReason.unsafeDependency:
        return 'unsafe_dependency';
      case SystemTopologyBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case SystemTopologyBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
