enum SafetyMemoryScope {
  sessionOnly,
  temporarySafeContext,
  auditReferenceOnly,
  restrictedReview,
  backendGoverned,
}

extension SafetyMemoryScopeKey on SafetyMemoryScope {
  String get key {
    switch (this) {
      case SafetyMemoryScope.sessionOnly:
        return 'session_only';
      case SafetyMemoryScope.temporarySafeContext:
        return 'temporary_safe_context';
      case SafetyMemoryScope.auditReferenceOnly:
        return 'audit_reference_only';
      case SafetyMemoryScope.restrictedReview:
        return 'restricted_review';
      case SafetyMemoryScope.backendGoverned:
        return 'backend_governed';
    }
  }
}
