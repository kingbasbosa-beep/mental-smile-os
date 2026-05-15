enum SystemTopologyScope {
  governanceKernel,
  governanceFederation,
  runtimeReadiness,
  runtimeExecution,
  providerGovernance,
  secureRuntimeEnvelope,
  trustedPipeline,
  trustedBackend,
  safetyRegistry,
  responseComposition,
  conversationSystems,
  safetyMemory,
  auditSystems,
}

extension SystemTopologyScopeKey on SystemTopologyScope {
  String get key {
    switch (this) {
      case SystemTopologyScope.governanceKernel:
        return 'governance_kernel';
      case SystemTopologyScope.governanceFederation:
        return 'governance_federation';
      case SystemTopologyScope.runtimeReadiness:
        return 'runtime_readiness';
      case SystemTopologyScope.runtimeExecution:
        return 'runtime_execution';
      case SystemTopologyScope.providerGovernance:
        return 'provider_governance';
      case SystemTopologyScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case SystemTopologyScope.trustedPipeline:
        return 'trusted_pipeline';
      case SystemTopologyScope.trustedBackend:
        return 'trusted_backend';
      case SystemTopologyScope.safetyRegistry:
        return 'safety_registry';
      case SystemTopologyScope.responseComposition:
        return 'response_composition';
      case SystemTopologyScope.conversationSystems:
        return 'conversation_systems';
      case SystemTopologyScope.safetyMemory:
        return 'safety_memory';
      case SystemTopologyScope.auditSystems:
        return 'audit_systems';
    }
  }
}
