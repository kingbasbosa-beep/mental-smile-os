enum RuntimeReadinessScope {
  governanceSystems,
  runtimeExecution,
  providerGovernance,
  safetyRegistry,
  secureRuntimeEnvelope,
  trustedBackend,
  trustedPipeline,
  responseComposition,
  conversationSystems,
  safetyMemory,
  auditSystems,
}

extension RuntimeReadinessScopeKey on RuntimeReadinessScope {
  String get key {
    switch (this) {
      case RuntimeReadinessScope.governanceSystems:
        return 'governance_systems';
      case RuntimeReadinessScope.runtimeExecution:
        return 'runtime_execution';
      case RuntimeReadinessScope.providerGovernance:
        return 'provider_governance';
      case RuntimeReadinessScope.safetyRegistry:
        return 'safety_registry';
      case RuntimeReadinessScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case RuntimeReadinessScope.trustedBackend:
        return 'trusted_backend';
      case RuntimeReadinessScope.trustedPipeline:
        return 'trusted_pipeline';
      case RuntimeReadinessScope.responseComposition:
        return 'response_composition';
      case RuntimeReadinessScope.conversationSystems:
        return 'conversation_systems';
      case RuntimeReadinessScope.safetyMemory:
        return 'safety_memory';
      case RuntimeReadinessScope.auditSystems:
        return 'audit_systems';
    }
  }
}
