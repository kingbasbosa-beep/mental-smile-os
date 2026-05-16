enum AuditEventType {
  policyBlocked,
  runtimeDisabled,
  escalationSuggested,
  fallbackTriggered,
  providerRejected,
  consentAccepted,
  protectedWriteDenied,
  safetyReviewRequired,
}

extension AuditEventTypeKey on AuditEventType {
  // Passive event label only. This does not execute runtime/provider behavior,
  // enforce policy, deny writes, trigger escalation, or approve fallback.
  String get key {
    switch (this) {
      case AuditEventType.policyBlocked:
        return 'policy_blocked';
      case AuditEventType.runtimeDisabled:
        return 'runtime_disabled';
      case AuditEventType.escalationSuggested:
        return 'escalation_suggested';
      case AuditEventType.fallbackTriggered:
        return 'fallback_triggered';
      case AuditEventType.providerRejected:
        return 'provider_rejected';
      case AuditEventType.consentAccepted:
        return 'consent_accepted';
      case AuditEventType.protectedWriteDenied:
        return 'protected_write_denied';
      case AuditEventType.safetyReviewRequired:
        return 'safety_review_required';
    }
  }
}
