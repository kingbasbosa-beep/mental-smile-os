enum SecureRuntimeVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  governanceInternal,
}

extension SecureRuntimeVisibilityScopeKey on SecureRuntimeVisibilityScope {
  String get key {
    switch (this) {
      case SecureRuntimeVisibilityScope.backendOnly:
        return 'backend_only';
      case SecureRuntimeVisibilityScope.auditOnly:
        return 'audit_only';
      case SecureRuntimeVisibilityScope.restrictedReview:
        return 'restricted_review';
      case SecureRuntimeVisibilityScope.governanceInternal:
        return 'governance_internal';
    }
  }
}
