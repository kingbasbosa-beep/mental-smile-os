enum RuntimePolicyModule {
  inputSafety,
  injectionGuard,
  outputValidation,
  crisisDetection,
  escalationReview,
  auditTracing,
  providerIsolation,
}

extension RuntimePolicyModuleKey on RuntimePolicyModule {
  String get key {
    switch (this) {
      case RuntimePolicyModule.inputSafety:
        return 'input_safety';
      case RuntimePolicyModule.injectionGuard:
        return 'injection_guard';
      case RuntimePolicyModule.outputValidation:
        return 'output_validation';
      case RuntimePolicyModule.crisisDetection:
        return 'crisis_detection';
      case RuntimePolicyModule.escalationReview:
        return 'escalation_review';
      case RuntimePolicyModule.auditTracing:
        return 'audit_tracing';
      case RuntimePolicyModule.providerIsolation:
        return 'provider_isolation';
    }
  }
}
