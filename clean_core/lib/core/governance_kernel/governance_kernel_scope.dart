enum GovernanceKernelScope {
  policyRuntime,
  executionBoundary,
  providerGovernance,
  safetyDecision,
  humanReview,
  safetyMemory,
  conversationSession,
  audit,
}

extension GovernanceKernelScopeKey on GovernanceKernelScope {
  String get key {
    switch (this) {
      case GovernanceKernelScope.policyRuntime:
        return 'policy_runtime';
      case GovernanceKernelScope.executionBoundary:
        return 'execution_boundary';
      case GovernanceKernelScope.providerGovernance:
        return 'provider_governance';
      case GovernanceKernelScope.safetyDecision:
        return 'safety_decision';
      case GovernanceKernelScope.humanReview:
        return 'human_review';
      case GovernanceKernelScope.safetyMemory:
        return 'safety_memory';
      case GovernanceKernelScope.conversationSession:
        return 'conversation_session';
      case GovernanceKernelScope.audit:
        return 'audit';
    }
  }
}
