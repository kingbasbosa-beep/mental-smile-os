enum RuntimeRollbackScope {
  runtimeActivation,
  runtimeEnablement,
  runtimeExecution,
  executionRouting,
  providerGovernance,
  trustedBackend,
  trustedPipeline,
  governanceFederation,
  runtimeReadiness,
  environmentActivation,
  secureRuntimeEnvelope,
}

extension RuntimeRollbackScopeKey on RuntimeRollbackScope {
  String get key {
    switch (this) {
      case RuntimeRollbackScope.runtimeActivation:
        return 'runtime_activation';
      case RuntimeRollbackScope.runtimeEnablement:
        return 'runtime_enablement';
      case RuntimeRollbackScope.runtimeExecution:
        return 'runtime_execution';
      case RuntimeRollbackScope.executionRouting:
        return 'execution_routing';
      case RuntimeRollbackScope.providerGovernance:
        return 'provider_governance';
      case RuntimeRollbackScope.trustedBackend:
        return 'trusted_backend';
      case RuntimeRollbackScope.trustedPipeline:
        return 'trusted_pipeline';
      case RuntimeRollbackScope.governanceFederation:
        return 'governance_federation';
      case RuntimeRollbackScope.runtimeReadiness:
        return 'runtime_readiness';
      case RuntimeRollbackScope.environmentActivation:
        return 'environment_activation';
      case RuntimeRollbackScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
    }
  }
}
