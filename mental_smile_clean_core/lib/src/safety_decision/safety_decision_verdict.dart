enum SafetyDecisionVerdict {
  allow,
  fallbackOnly,
  requireReview,
  block,
  escalate,
  failSafe,
}

extension SafetyDecisionVerdictKey on SafetyDecisionVerdict {
  String get key {
    switch (this) {
      case SafetyDecisionVerdict.allow:
        return 'allow';
      case SafetyDecisionVerdict.fallbackOnly:
        return 'fallback_only';
      case SafetyDecisionVerdict.requireReview:
        return 'require_review';
      case SafetyDecisionVerdict.block:
        return 'block';
      case SafetyDecisionVerdict.escalate:
        return 'escalate';
      case SafetyDecisionVerdict.failSafe:
        return 'fail_safe';
    }
  }
}
