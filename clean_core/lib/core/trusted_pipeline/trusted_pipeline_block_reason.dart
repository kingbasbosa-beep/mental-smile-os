enum TrustedPipelineBlockReason {
  pipelineBlocked,
  runtimeDisabled,
  missingAuthority,
  policyMismatch,
  reviewRequired,
  restrictedEnvironment,
  unsafeExecution,
  missingAuditLink,
  failClosed,
}

extension TrustedPipelineBlockReasonKey on TrustedPipelineBlockReason {
  String get key {
    switch (this) {
      case TrustedPipelineBlockReason.pipelineBlocked:
        return 'pipeline_blocked';
      case TrustedPipelineBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case TrustedPipelineBlockReason.missingAuthority:
        return 'missing_authority';
      case TrustedPipelineBlockReason.policyMismatch:
        return 'policy_mismatch';
      case TrustedPipelineBlockReason.reviewRequired:
        return 'review_required';
      case TrustedPipelineBlockReason.restrictedEnvironment:
        return 'restricted_environment';
      case TrustedPipelineBlockReason.unsafeExecution:
        return 'unsafe_execution';
      case TrustedPipelineBlockReason.missingAuditLink:
        return 'missing_audit_link';
      case TrustedPipelineBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
