enum RuntimeIsolationScope {
  runtimeExecution,
  providerGovernance,
  executionRouting,
  activationFlows,
  enablementFlows,
  rollbackSystems,
  observabilitySystems,
  trustedBackend,
  trustedPipeline,
  governanceFederation,
  runtimeReadiness,
  secureRuntimeEnvelope,
  environmentActivation,
}

extension RuntimeIsolationScopeKey on RuntimeIsolationScope {
  String get key {
    switch (this) {
      case RuntimeIsolationScope.runtimeExecution:
        return 'runtime_execution';
      case RuntimeIsolationScope.providerGovernance:
        return 'provider_governance';
      case RuntimeIsolationScope.executionRouting:
        return 'execution_routing';
      case RuntimeIsolationScope.activationFlows:
        return 'activation_flows';
      case RuntimeIsolationScope.enablementFlows:
        return 'enablement_flows';
      case RuntimeIsolationScope.rollbackSystems:
        return 'rollback_systems';
      case RuntimeIsolationScope.observabilitySystems:
        return 'observability_systems';
      case RuntimeIsolationScope.trustedBackend:
        return 'trusted_backend';
      case RuntimeIsolationScope.trustedPipeline:
        return 'trusted_pipeline';
      case RuntimeIsolationScope.governanceFederation:
        return 'governance_federation';
      case RuntimeIsolationScope.runtimeReadiness:
        return 'runtime_readiness';
      case RuntimeIsolationScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case RuntimeIsolationScope.environmentActivation:
        return 'environment_activation';
    }
  }
}
