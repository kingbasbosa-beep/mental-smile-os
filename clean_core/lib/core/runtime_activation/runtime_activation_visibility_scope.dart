enum RuntimeActivationVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  architectureInternal,
  activationPlanning,
}

extension RuntimeActivationVisibilityScopeKey
    on RuntimeActivationVisibilityScope {
  String get key {
    switch (this) {
      case RuntimeActivationVisibilityScope.backendOnly:
        return 'backend_only';
      case RuntimeActivationVisibilityScope.auditOnly:
        return 'audit_only';
      case RuntimeActivationVisibilityScope.restrictedReview:
        return 'restricted_review';
      case RuntimeActivationVisibilityScope.architectureInternal:
        return 'architecture_internal';
      case RuntimeActivationVisibilityScope.activationPlanning:
        return 'activation_planning';
    }
  }
}
