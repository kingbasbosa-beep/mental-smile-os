enum RuntimeEnablementScope {
  runtimeExecution,
  providerExecution,
  trustedBackend,
  trustedPipeline,
  activationGateway,
  runtimeWiring,
  governanceFederation,
  runtimeReadiness,
  secureRuntimeEnvelope,
  providerGovernance,
  auditSystems,
  reviewSystems,
}

extension RuntimeEnablementScopeKey on RuntimeEnablementScope {
  String get key {
    switch (this) {
      case RuntimeEnablementScope.runtimeExecution:
        return 'runtime_execution';
      case RuntimeEnablementScope.providerExecution:
        return 'provider_execution';
      case RuntimeEnablementScope.trustedBackend:
        return 'trusted_backend';
      case RuntimeEnablementScope.trustedPipeline:
        return 'trusted_pipeline';
      case RuntimeEnablementScope.activationGateway:
        return 'activation_gateway';
      case RuntimeEnablementScope.runtimeWiring:
        return 'runtime_wiring';
      case RuntimeEnablementScope.governanceFederation:
        return 'governance_federation';
      case RuntimeEnablementScope.runtimeReadiness:
        return 'runtime_readiness';
      case RuntimeEnablementScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case RuntimeEnablementScope.providerGovernance:
        return 'provider_governance';
      case RuntimeEnablementScope.auditSystems:
        return 'audit_systems';
      case RuntimeEnablementScope.reviewSystems:
        return 'review_systems';
    }
  }
}
