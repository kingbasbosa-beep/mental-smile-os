enum ExecutionRoutingBlockReason {
  routingBlocked,
  routingLocked,
  runtimeDisabled,
  providerBlocked,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  unsafeRouting,
  missingAuditLink,
  missingOwner,
  unapprovedRoute,
  failClosed,
}

extension ExecutionRoutingBlockReasonKey on ExecutionRoutingBlockReason {
  String get key {
    switch (this) {
      case ExecutionRoutingBlockReason.routingBlocked:
        return 'routing_blocked';
      case ExecutionRoutingBlockReason.routingLocked:
        return 'routing_locked';
      case ExecutionRoutingBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case ExecutionRoutingBlockReason.providerBlocked:
        return 'provider_blocked';
      case ExecutionRoutingBlockReason.missingAuthority:
        return 'missing_authority';
      case ExecutionRoutingBlockReason.policyMismatch:
        return 'policy_mismatch';
      case ExecutionRoutingBlockReason.reviewRequired:
        return 'review_required';
      case ExecutionRoutingBlockReason.unsafeRouting:
        return 'unsafe_routing';
      case ExecutionRoutingBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case ExecutionRoutingBlockReason.missingOwner:
        return 'missing_owner';
      case ExecutionRoutingBlockReason.unapprovedRoute:
        return 'unapproved_route';
      case ExecutionRoutingBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
