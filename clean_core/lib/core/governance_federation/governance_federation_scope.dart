enum GovernanceFederationScope {
  governanceKernel,
  governanceLifecycle,
  governanceCompliance,
  runtimeExecution,
  secureRuntimeEnvelope,
  trustedPipeline,
  trustedBackend,
  providerGovernance,
  safetyRegistry,
  audit,
}

extension GovernanceFederationScopeKey on GovernanceFederationScope {
  String get key {
    switch (this) {
      case GovernanceFederationScope.governanceKernel:
        return 'governance_kernel';
      case GovernanceFederationScope.governanceLifecycle:
        return 'governance_lifecycle';
      case GovernanceFederationScope.governanceCompliance:
        return 'governance_compliance';
      case GovernanceFederationScope.runtimeExecution:
        return 'runtime_execution';
      case GovernanceFederationScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case GovernanceFederationScope.trustedPipeline:
        return 'trusted_pipeline';
      case GovernanceFederationScope.trustedBackend:
        return 'trusted_backend';
      case GovernanceFederationScope.providerGovernance:
        return 'provider_governance';
      case GovernanceFederationScope.safetyRegistry:
        return 'safety_registry';
      case GovernanceFederationScope.audit:
        return 'audit';
    }
  }
}
