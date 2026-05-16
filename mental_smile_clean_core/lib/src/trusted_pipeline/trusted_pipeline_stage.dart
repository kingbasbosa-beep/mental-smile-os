enum TrustedPipelineStage {
  intake,
  policyReview,
  auditVerification,
  governanceVerification,
  reviewCheckpoint,
  fallbackStage,
  blockedStage,
}

extension TrustedPipelineStageKey on TrustedPipelineStage {
  String get key {
    switch (this) {
      case TrustedPipelineStage.intake:
        return 'intake';
      case TrustedPipelineStage.policyReview:
        return 'policy_review';
      case TrustedPipelineStage.auditVerification:
        return 'audit_verification';
      case TrustedPipelineStage.governanceVerification:
        return 'governance_verification';
      case TrustedPipelineStage.reviewCheckpoint:
        return 'review_checkpoint';
      case TrustedPipelineStage.fallbackStage:
        return 'fallback_stage';
      case TrustedPipelineStage.blockedStage:
        return 'blocked_stage';
    }
  }
}
