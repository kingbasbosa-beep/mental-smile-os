enum SafetyRegistryVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  registryInternal,
}

extension SafetyRegistryVisibilityScopeKey on SafetyRegistryVisibilityScope {
  String get key {
    switch (this) {
      case SafetyRegistryVisibilityScope.backendOnly:
        return 'backend_only';
      case SafetyRegistryVisibilityScope.auditOnly:
        return 'audit_only';
      case SafetyRegistryVisibilityScope.restrictedReview:
        return 'restricted_review';
      case SafetyRegistryVisibilityScope.registryInternal:
        return 'registry_internal';
    }
  }
}
