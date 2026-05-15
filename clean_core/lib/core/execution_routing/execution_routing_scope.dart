enum ExecutionRoutingScope {
  runtimeExecution,
  providerGovernance,
  trustedBackend,
  trustedPipeline,
  runtimeActivation,
  runtimeEnablement,
  runtimeWiring,
  governanceFederation,
  runtimeReadiness,
  secureRuntimeEnvelope,
  auditSystems,
  reviewSystems,
  responseComposition,
}

extension ExecutionRoutingScopeKey on ExecutionRoutingScope {
  String get key {
    switch (this) {
      case ExecutionRoutingScope.runtimeExecution:
        return 'runtime_execution';
      case ExecutionRoutingScope.providerGovernance:
        return 'provider_governance';
      case ExecutionRoutingScope.trustedBackend:
        return 'trusted_backend';
      case ExecutionRoutingScope.trustedPipeline:
        return 'trusted_pipeline';
      case ExecutionRoutingScope.runtimeActivation:
        return 'runtime_activation';
      case ExecutionRoutingScope.runtimeEnablement:
        return 'runtime_enablement';
      case ExecutionRoutingScope.runtimeWiring:
        return 'runtime_wiring';
      case ExecutionRoutingScope.governanceFederation:
        return 'governance_federation';
      case ExecutionRoutingScope.runtimeReadiness:
        return 'runtime_readiness';
      case ExecutionRoutingScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case ExecutionRoutingScope.auditSystems:
        return 'audit_systems';
      case ExecutionRoutingScope.reviewSystems:
        return 'review_systems';
      case ExecutionRoutingScope.responseComposition:
        return 'response_composition';
    }
  }
}
