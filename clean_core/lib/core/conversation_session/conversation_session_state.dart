enum ConversationSessionState {
  initialized,
  restricted,
  fallbackOnly,
  reviewRequired,
  locked,
  archived,
}

extension ConversationSessionStateKey on ConversationSessionState {
  String get key {
    switch (this) {
      case ConversationSessionState.initialized:
        return 'initialized';
      case ConversationSessionState.restricted:
        return 'restricted';
      case ConversationSessionState.fallbackOnly:
        return 'fallback_only';
      case ConversationSessionState.reviewRequired:
        return 'review_required';
      case ConversationSessionState.locked:
        return 'locked';
      case ConversationSessionState.archived:
        return 'archived';
    }
  }
}
