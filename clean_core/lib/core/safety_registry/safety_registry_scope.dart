enum SafetyRegistryScope {
  governanceKernel,
  governanceLifecycle,
  governanceCompliance,
  runtimeExecution,
  responseComposition,
  conversationSession,
  safetyMemory,
  providerGovernance,
  audit,
  humanReview,
  safetyDecision,
}

extension SafetyRegistryScopeKey on SafetyRegistryScope {
  String get key {
    switch (this) {
      case SafetyRegistryScope.governanceKernel:
        return 'governance_kernel';
      case SafetyRegistryScope.governanceLifecycle:
        return 'governance_lifecycle';
      case SafetyRegistryScope.governanceCompliance:
        return 'governance_compliance';
      case SafetyRegistryScope.runtimeExecution:
        return 'runtime_execution';
      case SafetyRegistryScope.responseComposition:
        return 'response_composition';
      case SafetyRegistryScope.conversationSession:
        return 'conversation_session';
      case SafetyRegistryScope.safetyMemory:
        return 'safety_memory';
      case SafetyRegistryScope.providerGovernance:
        return 'provider_governance';
      case SafetyRegistryScope.audit:
        return 'audit';
      case SafetyRegistryScope.humanReview:
        return 'human_review';
      case SafetyRegistryScope.safetyDecision:
        return 'safety_decision';
    }
  }
}
