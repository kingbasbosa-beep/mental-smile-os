enum SafetyMemoryVisibilityScope {
  privateSession,
  humanReview,
  auditOnly,
  backendOnly,
}

extension SafetyMemoryVisibilityScopeKey on SafetyMemoryVisibilityScope {
  String get key {
    switch (this) {
      case SafetyMemoryVisibilityScope.privateSession:
        return 'private_session';
      case SafetyMemoryVisibilityScope.humanReview:
        return 'human_review';
      case SafetyMemoryVisibilityScope.auditOnly:
        return 'audit_only';
      case SafetyMemoryVisibilityScope.backendOnly:
        return 'backend_only';
    }
  }
}
