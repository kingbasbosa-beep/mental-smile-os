enum ArchitectureManifestScope {
  legalFoundation,
  aiGovernance,
  aiSafetyCore,
  crisisSafeUx,
  backendBoundaries,
  runtimeIsolation,
  auditSystems,
  policyRuntime,
  humanReview,
  providerGovernance,
  safetyDecision,
  conversationSession,
  responseComposition,
  safetyMemory,
  runtimeExecution,
  governanceKernel,
  governanceLifecycle,
  governanceCompliance,
  safetyRegistry,
  governanceCapability,
  trustedBackend,
  trustedPipeline,
  secureRuntimeEnvelope,
  governanceFederation,
  runtimeReadiness,
  systemTopology,
}

extension ArchitectureManifestScopeKey on ArchitectureManifestScope {
  String get key {
    switch (this) {
      case ArchitectureManifestScope.legalFoundation:
        return 'legal_foundation';
      case ArchitectureManifestScope.aiGovernance:
        return 'ai_governance';
      case ArchitectureManifestScope.aiSafetyCore:
        return 'ai_safety_core';
      case ArchitectureManifestScope.crisisSafeUx:
        return 'crisis_safe_ux';
      case ArchitectureManifestScope.backendBoundaries:
        return 'backend_boundaries';
      case ArchitectureManifestScope.runtimeIsolation:
        return 'runtime_isolation';
      case ArchitectureManifestScope.auditSystems:
        return 'audit_systems';
      case ArchitectureManifestScope.policyRuntime:
        return 'policy_runtime';
      case ArchitectureManifestScope.humanReview:
        return 'human_review';
      case ArchitectureManifestScope.providerGovernance:
        return 'provider_governance';
      case ArchitectureManifestScope.safetyDecision:
        return 'safety_decision';
      case ArchitectureManifestScope.conversationSession:
        return 'conversation_session';
      case ArchitectureManifestScope.responseComposition:
        return 'response_composition';
      case ArchitectureManifestScope.safetyMemory:
        return 'safety_memory';
      case ArchitectureManifestScope.runtimeExecution:
        return 'runtime_execution';
      case ArchitectureManifestScope.governanceKernel:
        return 'governance_kernel';
      case ArchitectureManifestScope.governanceLifecycle:
        return 'governance_lifecycle';
      case ArchitectureManifestScope.governanceCompliance:
        return 'governance_compliance';
      case ArchitectureManifestScope.safetyRegistry:
        return 'safety_registry';
      case ArchitectureManifestScope.governanceCapability:
        return 'governance_capability';
      case ArchitectureManifestScope.trustedBackend:
        return 'trusted_backend';
      case ArchitectureManifestScope.trustedPipeline:
        return 'trusted_pipeline';
      case ArchitectureManifestScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case ArchitectureManifestScope.governanceFederation:
        return 'governance_federation';
      case ArchitectureManifestScope.runtimeReadiness:
        return 'runtime_readiness';
      case ArchitectureManifestScope.systemTopology:
        return 'system_topology';
    }
  }
}
