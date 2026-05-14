enum ProviderBoundaryScope {
  aiRuntime,
  safetyReview,
  crisisSupport,
  auditOnly,
  backendOnly,
}

extension ProviderBoundaryScopeKey on ProviderBoundaryScope {
  String get key {
    switch (this) {
      case ProviderBoundaryScope.aiRuntime:
        return 'ai_runtime';
      case ProviderBoundaryScope.safetyReview:
        return 'safety_review';
      case ProviderBoundaryScope.crisisSupport:
        return 'crisis_support';
      case ProviderBoundaryScope.auditOnly:
        return 'audit_only';
      case ProviderBoundaryScope.backendOnly:
        return 'backend_only';
    }
  }
}
