enum RuntimeWiringScope {
  runtimeActivationGateway,
  runtimeExecution,
  providerGovernance,
  trustedBackend,
  trustedPipeline,
  governanceFederation,
  runtimeReadiness,
  secureRuntimeEnvelope,
  safetyRegistry,
  auditSystems,
  humanReview,
  responseComposition,
}

extension RuntimeWiringScopeKey on RuntimeWiringScope {
  String get key {
    switch (this) {
      case RuntimeWiringScope.runtimeActivationGateway:
        return 'runtime_activation_gateway';
      case RuntimeWiringScope.runtimeExecution:
        return 'runtime_execution';
      case RuntimeWiringScope.providerGovernance:
        return 'provider_governance';
      case RuntimeWiringScope.trustedBackend:
        return 'trusted_backend';
      case RuntimeWiringScope.trustedPipeline:
        return 'trusted_pipeline';
      case RuntimeWiringScope.governanceFederation:
        return 'governance_federation';
      case RuntimeWiringScope.runtimeReadiness:
        return 'runtime_readiness';
      case RuntimeWiringScope.secureRuntimeEnvelope:
        return 'secure_runtime_envelope';
      case RuntimeWiringScope.safetyRegistry:
        return 'safety_registry';
      case RuntimeWiringScope.auditSystems:
        return 'audit_systems';
      case RuntimeWiringScope.humanReview:
        return 'human_review';
      case RuntimeWiringScope.responseComposition:
        return 'response_composition';
    }
  }
}
