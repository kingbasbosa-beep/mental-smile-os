enum RuntimeEnablementStage {
  candidateReview,
  governanceReview,
  auditReview,
  providerReview,
  environmentReview,
  secureEnvelopeReview,
  activationReview,
  rollbackPlanning,
  enablementDenied,
  fallbackPlanning,
}

extension RuntimeEnablementStageKey on RuntimeEnablementStage {
  String get key {
    switch (this) {
      case RuntimeEnablementStage.candidateReview:
        return 'candidate_review';
      case RuntimeEnablementStage.governanceReview:
        return 'governance_review';
      case RuntimeEnablementStage.auditReview:
        return 'audit_review';
      case RuntimeEnablementStage.providerReview:
        return 'provider_review';
      case RuntimeEnablementStage.environmentReview:
        return 'environment_review';
      case RuntimeEnablementStage.secureEnvelopeReview:
        return 'secure_envelope_review';
      case RuntimeEnablementStage.activationReview:
        return 'activation_review';
      case RuntimeEnablementStage.rollbackPlanning:
        return 'rollback_planning';
      case RuntimeEnablementStage.enablementDenied:
        return 'enablement_denied';
      case RuntimeEnablementStage.fallbackPlanning:
        return 'fallback_planning';
    }
  }
}
