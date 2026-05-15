enum RuntimeActivationScope {
  runtimeExecution,
  providerExecution,
  trustedPipeline,
  trustedBackend,
  governanceFederation,
  runtimeReadiness,
  secureRuntimeEnvelope,
  providerGovernance,
  reviewSystems,
  auditSystems,
}

extension RuntimeActivationScopeKey on RuntimeActivationScope {
  String get key {
    switch (this) {
      case RuntimeActivationScope.runtimeExecution:
        return 'runtime_execution';
      case RuntimeActivationScope.providerExecution:
        return 'provider_execution';
      case RuntimeActivationScope.trustedPipeline:
        return 'trusted_pipeline';
      case RuntimeActivationScope.trustedBackend:
        return 'trusted_backend';
      case RuntimeActivationScope.governanceFederation:
        return 'governance_federation';
      case RuntimeActivationScope.runtimeReadiness:
        return 'runtime_readiness';
      case RuntimeActivationScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case RuntimeActivationScope.providerGovernance:
        return 'provider_governance';
      case RuntimeActivationScope.reviewSystems:
        return 'review_systems';
      case RuntimeActivationScope.auditSystems:
        return 'audit_systems';
    }
  }
}
