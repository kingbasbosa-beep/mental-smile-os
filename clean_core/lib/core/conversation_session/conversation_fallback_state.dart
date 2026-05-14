enum ConversationFallbackState {
  runtimeDisabled,
  policyBlocked,
  providerBlocked,
  auditMissing,
  reviewRequired,
  failClosed,
}

extension ConversationFallbackStateKey on ConversationFallbackState {
  String get key {
    switch (this) {
      case ConversationFallbackState.runtimeDisabled:
        return 'runtime_disabled';
      case ConversationFallbackState.policyBlocked:
        return 'policy_blocked';
      case ConversationFallbackState.providerBlocked:
        return 'provider_blocked';
      case ConversationFallbackState.auditMissing:
        return 'audit_missing';
      case ConversationFallbackState.reviewRequired:
        return 'review_required';
      case ConversationFallbackState.failClosed:
        return 'fail_closed';
    }
  }
}
