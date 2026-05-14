enum ConversationSessionMode {
  aiDisabled,
  fallbackOnly,
  humanPriority,
  restrictedReview,
}

extension ConversationSessionModeKey on ConversationSessionMode {
  String get key {
    switch (this) {
      case ConversationSessionMode.aiDisabled:
        return 'ai_disabled';
      case ConversationSessionMode.fallbackOnly:
        return 'fallback_only';
      case ConversationSessionMode.humanPriority:
        return 'human_priority';
      case ConversationSessionMode.restrictedReview:
        return 'restricted_review';
    }
  }
}
