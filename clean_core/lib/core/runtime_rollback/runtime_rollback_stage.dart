enum RuntimeRollbackStage {
  rollbackRequest,
  governanceReview,
  auditReview,
  providerRollbackReview,
  environmentRollbackReview,
  secureEnvelopeRollbackReview,
  activationRollbackReview,
  rollbackDenied,
  rollbackFallback,
}

extension RuntimeRollbackStageKey on RuntimeRollbackStage {
  String get key {
    switch (this) {
      case RuntimeRollbackStage.rollbackRequest:
        return 'rollback_request';
      case RuntimeRollbackStage.governanceReview:
        return 'governance_review';
      case RuntimeRollbackStage.auditReview:
        return 'audit_review';
      case RuntimeRollbackStage.providerRollbackReview:
        return 'provider_rollback_review';
      case RuntimeRollbackStage.environmentRollbackReview:
        return 'environment_rollback_review';
      case RuntimeRollbackStage.secureEnvelopeRollbackReview:
        return 'secure_envelope_rollback_review';
      case RuntimeRollbackStage.activationRollbackReview:
        return 'activation_rollback_review';
      case RuntimeRollbackStage.rollbackDenied:
        return 'rollback_denied';
      case RuntimeRollbackStage.rollbackFallback:
        return 'rollback_fallback';
    }
  }
}
