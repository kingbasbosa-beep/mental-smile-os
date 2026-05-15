enum RuntimeActivationStage {
  activationRequest,
  governanceVerification,
  auditVerification,
  providerVerification,
  environmentVerification,
  reviewCheckpoint,
  activationDenied,
  activationFallback,
}

extension RuntimeActivationStageKey on RuntimeActivationStage {
  String get key {
    switch (this) {
      case RuntimeActivationStage.activationRequest:
        return 'activation_request';
      case RuntimeActivationStage.governanceVerification:
        return 'governance_verification';
      case RuntimeActivationStage.auditVerification:
        return 'audit_verification';
      case RuntimeActivationStage.providerVerification:
        return 'provider_verification';
      case RuntimeActivationStage.environmentVerification:
        return 'environment_verification';
      case RuntimeActivationStage.reviewCheckpoint:
        return 'review_checkpoint';
      case RuntimeActivationStage.activationDenied:
        return 'activation_denied';
      case RuntimeActivationStage.activationFallback:
        return 'activation_fallback';
    }
  }
}
