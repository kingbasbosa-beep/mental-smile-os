enum ConversationSessionScope {
  safeSupport,
  crisisSafeCopy,
  bookingFollowup,
  humanReview,
  auditOnly,
}

extension ConversationSessionScopeKey on ConversationSessionScope {
  String get key {
    switch (this) {
      case ConversationSessionScope.safeSupport:
        return 'safe_support';
      case ConversationSessionScope.crisisSafeCopy:
        return 'crisis_safe_copy';
      case ConversationSessionScope.bookingFollowup:
        return 'booking_followup';
      case ConversationSessionScope.humanReview:
        return 'human_review';
      case ConversationSessionScope.auditOnly:
        return 'audit_only';
    }
  }
}
