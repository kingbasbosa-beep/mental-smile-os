enum RuntimeReleaseScope {
  runtimeActivation,
  runtimeEnablement,
  runtimeExecution,
  executionRouting,
  environmentActivation,
  rollbackReadiness,
  observabilityReadiness,
  isolationReadiness,
  trustedBackend,
  trustedPipeline,
  providerGovernance,
  secureRuntimeEnvelope,
}

extension RuntimeReleaseScopeKey on RuntimeReleaseScope {
  String get key {
    switch (this) {
      case RuntimeReleaseScope.runtimeActivation:
        return 'runtime_activation';
      case RuntimeReleaseScope.runtimeEnablement:
        return 'runtime_enablement';
      case RuntimeReleaseScope.runtimeExecution:
        return 'runtime_execution';
      case RuntimeReleaseScope.executionRouting:
        return 'execution_routing';
      case RuntimeReleaseScope.environmentActivation:
        return 'environment_activation';
      case RuntimeReleaseScope.rollbackReadiness:
        return 'rollback_readiness';
      case RuntimeReleaseScope.observabilityReadiness:
        return 'observability_readiness';
      case RuntimeReleaseScope.isolationReadiness:
        return 'isolation_readiness';
      case RuntimeReleaseScope.trustedBackend:
        return 'trusted_backend';
      case RuntimeReleaseScope.trustedPipeline:
        return 'trusted_pipeline';
      case RuntimeReleaseScope.providerGovernance:
        return 'provider_governance';
      case RuntimeReleaseScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
    }
  }
}
