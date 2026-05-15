enum EnvironmentActivationScope {
  runtimeExecution,
  providerExecution,
  trustedBackend,
  trustedPipeline,
  runtimeActivation,
  runtimeEnablement,
  runtimeWiring,
  executionRouting,
  governanceFederation,
  runtimeReadiness,
  secureRuntimeEnvelope,
}

extension EnvironmentActivationScopeKey on EnvironmentActivationScope {
  String get key {
    switch (this) {
      case EnvironmentActivationScope.runtimeExecution:
        return 'runtime_execution';
      case EnvironmentActivationScope.providerExecution:
        return 'provider_execution';
      case EnvironmentActivationScope.trustedBackend:
        return 'trusted_backend';
      case EnvironmentActivationScope.trustedPipeline:
        return 'trusted_pipeline';
      case EnvironmentActivationScope.runtimeActivation:
        return 'runtime_activation';
      case EnvironmentActivationScope.runtimeEnablement:
        return 'runtime_enablement';
      case EnvironmentActivationScope.runtimeWiring:
        return 'runtime_wiring';
      case EnvironmentActivationScope.executionRouting:
        return 'execution_routing';
      case EnvironmentActivationScope.governanceFederation:
        return 'governance_federation';
      case EnvironmentActivationScope.runtimeReadiness:
        return 'runtime_readiness';
      case EnvironmentActivationScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
    }
  }
}
