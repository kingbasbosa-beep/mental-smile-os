enum ConversationControlMode {
  aiOnly,
  hybridSupport,
  humanPriority,
  lockedForReview,
}

extension ConversationControlModeKey on ConversationControlMode {
  String get key {
    switch (this) {
      case ConversationControlMode.aiOnly:
        return 'ai_only';
      case ConversationControlMode.hybridSupport:
        return 'hybrid_support';
      case ConversationControlMode.humanPriority:
        return 'human_priority';
      case ConversationControlMode.lockedForReview:
        return 'locked_for_review';
    }
  }
}
