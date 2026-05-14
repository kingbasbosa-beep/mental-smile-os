enum SafetyDecisionReason {
  policyMismatch,
  missingSafetyModule,
  blockedProvider,
  restrictedEnvironment,
  escalationRequired,
  unsafeRuntime,
  auditRequirementMissing,
  lowConfidence,
  backendUnavailable,
}

extension SafetyDecisionReasonKey on SafetyDecisionReason {
  String get key {
    switch (this) {
      case SafetyDecisionReason.policyMismatch:
        return 'policy_mismatch';
      case SafetyDecisionReason.missingSafetyModule:
        return 'missing_safety_module';
      case SafetyDecisionReason.blockedProvider:
        return 'blocked_provider';
      case SafetyDecisionReason.restrictedEnvironment:
        return 'restricted_environment';
      case SafetyDecisionReason.escalationRequired:
        return 'escalation_required';
      case SafetyDecisionReason.unsafeRuntime:
        return 'unsafe_runtime';
      case SafetyDecisionReason.auditRequirementMissing:
        return 'audit_requirement_missing';
      case SafetyDecisionReason.lowConfidence:
        return 'low_confidence';
      case SafetyDecisionReason.backendUnavailable:
        return 'backend_unavailable';
    }
  }
}
