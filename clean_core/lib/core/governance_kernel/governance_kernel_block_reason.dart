enum GovernanceKernelBlockReason {
  runtimeDisabled,
  policyMismatch,
  providerBlocked,
  missingAuditLink,
  restrictedEnvironment,
  reviewRequired,
  unsafeCoordination,
  memoryBoundaryBlocked,
  conversationBoundaryBlocked,
  failClosed,
}

extension GovernanceKernelBlockReasonKey on GovernanceKernelBlockReason {
  String get key {
    switch (this) {
      case GovernanceKernelBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case GovernanceKernelBlockReason.policyMismatch:
        return 'policy_mismatch';
      case GovernanceKernelBlockReason.providerBlocked:
        return 'provider_blocked';
      case GovernanceKernelBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case GovernanceKernelBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case GovernanceKernelBlockReason.reviewRequired:
        return 'review_required';
      case GovernanceKernelBlockReason.unsafeCoordination:
        return 'unsafe_coordination';
      case GovernanceKernelBlockReason.memoryBoundaryBlocked:
        return 'memory_boundary_blocked';
      case GovernanceKernelBlockReason.conversationBoundaryBlocked:
        return 'conversation_boundary_blocked';
      case GovernanceKernelBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
