enum RuntimeObservabilityStage {
  observationRequest,
  governanceReview,
  auditReview,
  providerObservationReview,
  activationObservationReview,
  rollbackObservationReview,
  fallbackObservationReview,
  observationDenied,
  observationFallback,
}

extension RuntimeObservabilityStageKey on RuntimeObservabilityStage {
  String get key {
    switch (this) {
      case RuntimeObservabilityStage.observationRequest:
        return 'observation_request';
      case RuntimeObservabilityStage.governanceReview:
        return 'governance_review';
      case RuntimeObservabilityStage.auditReview:
        return 'audit_review';
      case RuntimeObservabilityStage.providerObservationReview:
        return 'provider_observation_review';
      case RuntimeObservabilityStage.activationObservationReview:
        return 'activation_observation_review';
      case RuntimeObservabilityStage.rollbackObservationReview:
        return 'rollback_observation_review';
      case RuntimeObservabilityStage.fallbackObservationReview:
        return 'fallback_observation_review';
      case RuntimeObservabilityStage.observationDenied:
        return 'observation_denied';
      case RuntimeObservabilityStage.observationFallback:
        return 'observation_fallback';
    }
  }
}
