enum ResponseBlockReason {
  runtimeDisabled,
  providerBlocked,
  policyBlocked,
  lowConfidence,
  reviewRequired,
  escalationSuggested,
  failClosed,
}

extension ResponseBlockReasonKey on ResponseBlockReason {
  String get key {
    switch (this) {
      case ResponseBlockReason.runtimeDisabled:
        return 'runtime_disabled';
      case ResponseBlockReason.providerBlocked:
        return 'provider_blocked';
      case ResponseBlockReason.policyBlocked:
        return 'policy_blocked';
      case ResponseBlockReason.lowConfidence:
        return 'low_confidence';
      case ResponseBlockReason.reviewRequired:
        return 'review_required';
      case ResponseBlockReason.escalationSuggested:
        return 'escalation_suggested';
      case ResponseBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}
