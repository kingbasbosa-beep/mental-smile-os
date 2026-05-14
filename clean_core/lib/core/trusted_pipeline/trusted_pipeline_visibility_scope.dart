enum TrustedPipelineVisibilityScope {
  backendOnly,
  auditOnly,
  restrictedReview,
  governanceInternal,
}

extension TrustedPipelineVisibilityScopeKey on TrustedPipelineVisibilityScope {
  String get key {
    switch (this) {
      case TrustedPipelineVisibilityScope.backendOnly:
        return 'backend_only';
      case TrustedPipelineVisibilityScope.auditOnly:
        return 'audit_only';
      case TrustedPipelineVisibilityScope.restrictedReview:
        return 'restricted_review';
      case TrustedPipelineVisibilityScope.governanceInternal:
        return 'governance_internal';
    }
  }
}
