enum RuntimeExecutionReason {
  runtimeDisabled,
  providerBlocked,
  policyMismatch,
  missingAuditLink,
  restrictedEnvironment,
  escalationRequired,
  unsafeExecution,
}

extension RuntimeExecutionReasonKey on RuntimeExecutionReason {
  String get key {
    switch (this) {
      case RuntimeExecutionReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimeExecutionReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeExecutionReason.policyMismatch:
        return 'policy_mismatch';
      case RuntimeExecutionReason.missingAuditLink:
        return 'missing_audit_link';
      case RuntimeExecutionReason.restrictedEnvironment:
        return 'restricted_environment';
      case RuntimeExecutionReason.escalationRequired:
        return 'escalation_required';
      case RuntimeExecutionReason.unsafeExecution:
        return 'unsafe_execution';
    }
  }
}
