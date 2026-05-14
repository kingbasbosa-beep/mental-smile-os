enum ConversationInteractionType {
  safeSupport,
  fallbackResponse,
  escalationSuggestion,
  policyBlock,
  runtimeBlocked,
  reviewRequired,
}

extension ConversationInteractionTypeKey on ConversationInteractionType {
  String get key {
    switch (this) {
      case ConversationInteractionType.safeSupport:
        return 'safe_support';
      case ConversationInteractionType.fallbackResponse:
        return 'fallback_response';
      case ConversationInteractionType.escalationSuggestion:
        return 'escalation_suggestion';
      case ConversationInteractionType.policyBlock:
        return 'policy_block';
      case ConversationInteractionType.runtimeBlocked:
        return 'runtime_blocked';
      case ConversationInteractionType.reviewRequired:
        return 'review_required';
    }
  }
}
