enum TrustedBackendVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  governanceInternal,
}

extension TrustedBackendVisibilityScopeKey on TrustedBackendVisibilityScope {
  String get key {
    switch (this) {
      case TrustedBackendVisibilityScope.backendOnly:
        return 'backend_only';
      case TrustedBackendVisibilityScope.auditOnly:
        return 'audit_only';
      case TrustedBackendVisibilityScope.restrictedReview:
        return 'restricted_review';
      case TrustedBackendVisibilityScope.governanceInternal:
        return 'governance_internal';
    }
  }
}
