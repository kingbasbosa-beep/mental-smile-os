enum ResponseVisibilityScope {
  userVisible,
  humanReview,
  auditOnly,
  backendOnly,
}

extension ResponseVisibilityScopeKey on ResponseVisibilityScope {
  String get key {
    switch (this) {
      case ResponseVisibilityScope.userVisible:
        return 'user_visible';
      case ResponseVisibilityScope.humanReview:
        return 'human_review';
      case ResponseVisibilityScope.auditOnly:
        return 'audit_only';
      case ResponseVisibilityScope.backendOnly:
        return 'backend_only';
    }
  }
}
