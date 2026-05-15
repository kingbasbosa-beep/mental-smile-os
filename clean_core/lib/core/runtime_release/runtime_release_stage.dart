enum RuntimeReleaseStage {
  releaseRequest,
  governanceReview,
  auditReview,
  providerReview,
  environmentReview,
  rollbackReview,
  observabilityReview,
  isolationReview,
  releaseDenied,
  releaseFallback,
}

extension RuntimeReleaseStageKey on RuntimeReleaseStage {
  String get key {
    switch (this) {
      case RuntimeReleaseStage.releaseRequest:
        return 'release_request';
      case RuntimeReleaseStage.governanceReview:
        return 'governance_review';
      case RuntimeReleaseStage.auditReview:
        return 'audit_review';
      case RuntimeReleaseStage.providerReview:
        return 'provider_review';
      case RuntimeReleaseStage.environmentReview:
        return 'environment_review';
      case RuntimeReleaseStage.rollbackReview:
        return 'rollback_review';
      case RuntimeReleaseStage.observabilityReview:
        return 'observability_review';
      case RuntimeReleaseStage.isolationReview:
        return 'isolation_review';
      case RuntimeReleaseStage.releaseDenied:
        return 'release_denied';
      case RuntimeReleaseStage.releaseFallback:
        return 'release_fallback';
    }
  }
}
