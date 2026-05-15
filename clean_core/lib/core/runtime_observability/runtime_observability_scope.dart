enum RuntimeObservabilityScope {
  runtimeExecution,
  providerGovernance,
  activationFlows,
  enablementFlows,
  routingFlows,
  rollbackFlows,
  environmentActivation,
  trustedBackend,
  trustedPipeline,
  governanceFederation,
  runtimeReadiness,
  secureRuntimeEnvelope,
}

extension RuntimeObservabilityScopeKey on RuntimeObservabilityScope {
  String get key {
    switch (this) {
      case RuntimeObservabilityScope.runtimeExecution:
        return 'runtime_execution';
      case RuntimeObservabilityScope.providerGovernance:
        return 'provider_governance';
      case RuntimeObservabilityScope.activationFlows:
        return 'activation_flows';
      case RuntimeObservabilityScope.enablementFlows:
        return 'enablement_flows';
      case RuntimeObservabilityScope.routingFlows:
        return 'routing_flows';
      case RuntimeObservabilityScope.rollbackFlows:
        return 'rollback_flows';
      case RuntimeObservabilityScope.environmentActivation:
        return 'environment_activation';
      case RuntimeObservabilityScope.trustedBackend:
        return 'trusted_backend';
      case RuntimeObservabilityScope.trustedPipeline:
        return 'trusted_pipeline';
      case RuntimeObservabilityScope.governanceFederation:
        return 'governance_federation';
      case RuntimeObservabilityScope.runtimeReadiness:
        return 'runtime_readiness';
      case RuntimeObservabilityScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
    }
  }
}
