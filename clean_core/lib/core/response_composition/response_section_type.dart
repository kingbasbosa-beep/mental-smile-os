enum ResponseSectionType {
  supportGuidance,
  grounding,
  fallbackSupport,
  escalationSuggestion,
  policyNotice,
  runtimeBlockedNotice,
  reviewRequiredNotice,
}

extension ResponseSectionTypeKey on ResponseSectionType {
  String get key {
    switch (this) {
      case ResponseSectionType.supportGuidance:
        return 'support_guidance';
      case ResponseSectionType.grounding:
        return 'grounding';
      case ResponseSectionType.fallbackSupport:
        return 'fallback_support';
      case ResponseSectionType.escalationSuggestion:
        return 'escalation_suggestion';
      case ResponseSectionType.policyNotice:
        return 'policy_notice';
      case ResponseSectionType.runtimeBlockedNotice:
        return 'runtime_blocked_notice';
      case ResponseSectionType.reviewRequiredNotice:
        return 'review_required_notice';
    }
  }
}
