enum EnvironmentActivationStage {
  environmentReview,
  ownershipReview,
  runtimePermissionReview,
  providerPermissionReview,
  backendPermissionReview,
  routingPermissionReview,
  governancePermissionReview,
  reviewCheckpoint,
  activationDenied,
  fallbackPlanning,
}

extension EnvironmentActivationStageKey on EnvironmentActivationStage {
  String get key {
    switch (this) {
      case EnvironmentActivationStage.environmentReview:
        return 'environment_review';
      case EnvironmentActivationStage.ownershipReview:
        return 'ownership_review';
      case EnvironmentActivationStage.runtimePermissionReview:
        return 'runtime_permission_review';
      case EnvironmentActivationStage.providerPermissionReview:
        return 'provider_permission_review';
      case EnvironmentActivationStage.backendPermissionReview:
        return 'backend_permission_review';
      case EnvironmentActivationStage.routingPermissionReview:
        return 'routing_permission_review';
      case EnvironmentActivationStage.governancePermissionReview:
        return 'governance_permission_review';
      case EnvironmentActivationStage.reviewCheckpoint:
        return 'review_checkpoint';
      case EnvironmentActivationStage.activationDenied:
        return 'activation_denied';
      case EnvironmentActivationStage.fallbackPlanning:
        return 'fallback_planning';
    }
  }
}
