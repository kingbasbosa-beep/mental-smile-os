enum EnvironmentActivationVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  environmentPlanning,
}

extension EnvironmentActivationVisibilityScopeKey
    on EnvironmentActivationVisibilityScope {
  String get key {
    switch (this) {
      case EnvironmentActivationVisibilityScope.backendOnly:
        return 'backend_only';
      case EnvironmentActivationVisibilityScope.auditOnly:
        return 'audit_only';
      case EnvironmentActivationVisibilityScope.restrictedReview:
        return 'restricted_review';
      case EnvironmentActivationVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case EnvironmentActivationVisibilityScope.environmentPlanning:
        return 'environment_planning';
    }
  }
}
