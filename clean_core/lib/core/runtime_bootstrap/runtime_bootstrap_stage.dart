enum RuntimeBootstrapStage {
  bootstrapRequest,
  governanceReview,
  auditReview,
  releaseVerification,
  rollbackVerification,
  observabilityVerification,
  isolationVerification,
  providerStartupReview,
  bootstrapDenied,
  bootstrapFallback,
}

extension RuntimeBootstrapStageKey on RuntimeBootstrapStage {
  String get key {
    switch (this) {
      case RuntimeBootstrapStage.bootstrapRequest:
        return 'bootstrap_request';
      case RuntimeBootstrapStage.governanceReview:
        return 'governance_review';
      case RuntimeBootstrapStage.auditReview:
        return 'audit_review';
      case RuntimeBootstrapStage.releaseVerification:
        return 'release_verification';
      case RuntimeBootstrapStage.rollbackVerification:
        return 'rollback_verification';
      case RuntimeBootstrapStage.observabilityVerification:
        return 'observability_verification';
      case RuntimeBootstrapStage.isolationVerification:
        return 'isolation_verification';
      case RuntimeBootstrapStage.providerStartupReview:
        return 'provider_startup_review';
      case RuntimeBootstrapStage.bootstrapDenied:
        return 'bootstrap_denied';
      case RuntimeBootstrapStage.bootstrapFallback:
        return 'bootstrap_fallback';
    }
  }
}
