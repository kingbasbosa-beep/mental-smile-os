enum GovernanceCapabilityScope {
  responseComposition,
  conversationSession,
  safetyDecision,
  runtimeExecution,
  providerGovernance,
  memoryBoundary,
  reviewSystem,
  complianceSystem,
  auditSystem,
}

extension GovernanceCapabilityScopeKey on GovernanceCapabilityScope {
  String get key {
    switch (this) {
      case GovernanceCapabilityScope.responseComposition:
        return 'response_composition';
      case GovernanceCapabilityScope.conversationSession:
        return 'conversation_session';
      case GovernanceCapabilityScope.safetyDecision:
        return 'safety_decision';
      case GovernanceCapabilityScope.runtimeExecution:
        return 'runtime_execution';
      case GovernanceCapabilityScope.providerGovernance:
        return 'provider_governance';
      case GovernanceCapabilityScope.memoryBoundary:
        return 'memory_boundary';
      case GovernanceCapabilityScope.reviewSystem:
        return 'review_system';
      case GovernanceCapabilityScope.complianceSystem:
        return 'compliance_system';
      case GovernanceCapabilityScope.auditSystem:
        return 'audit_system';
    }
  }
}
