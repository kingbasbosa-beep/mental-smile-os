enum RuntimeExecutionBlockReason {
  runtimeDisabled,
  providerBlocked,
  policyMismatch,
  auditMissing,
  environmentRestricted,
  escalationRequired,
  failClosed,
}

extension RuntimeExecutionBlockReasonKey on RuntimeExecutionBlockReason {
  String get key {
    switch (this) {
      case RuntimeExecutionBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeExecutionBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeExecutionBlockReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeExecutionBlockReason.auditMissing:
        return 'audit_missing';
      case RuntimeExecutionBlockReason.environmentRestricted:
        return 'environment_restricted';
      case RuntimeExecutionBlockReason.escalationRequired:
        return 'escalation_required';
      case RuntimeExecutionBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
