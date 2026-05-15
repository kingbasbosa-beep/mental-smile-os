enum RuntimeBootstrapScope {
  runtimeActivation,
  runtimeEnablement,
  runtimeExecution,
  executionRouting,
  releaseGovernance,
  rollbackGovernance,
  observabilityGovernance,
  isolationGovernance,
  trustedBackend,
  trustedPipeline,
  providerGovernance,
  secureRuntimeEnvelope,
  environmentActivation,
}

extension RuntimeBootstrapScopeKey on RuntimeBootstrapScope {
  String get key {
    switch (this) {
      case RuntimeBootstrapScope.runtimeActivation:
        return 'runtime_activation';
      case RuntimeBootstrapScope.runtimeEnablement:
        return 'runtime_enablement';
      case RuntimeBootstrapScope.runtimeExecution:
        return 'runtime_execution';
      case RuntimeBootstrapScope.executionRouting:
        return 'execution_routing';
      case RuntimeBootstrapScope.releaseGovernance:
        return 'release_governance';
      case RuntimeBootstrapScope.rollbackGovernance:
        return 'rollback_governance';
      case RuntimeBootstrapScope.observabilityGovernance:
        return 'observability_governance';
      case RuntimeBootstrapScope.isolationGovernance:
        return 'isolation_governance';
      case RuntimeBootstrapScope.trustedBackend:
        return 'trusted_backend';
      case RuntimeBootstrapScope.trustedPipeline:
        return 'trusted_pipeline';
      case RuntimeBootstrapScope.providerGovernance:
        return 'provider_governance';
      case RuntimeBootstrapScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case RuntimeBootstrapScope.environmentActivation:
        return 'environment_activation';
    }
  }
}
