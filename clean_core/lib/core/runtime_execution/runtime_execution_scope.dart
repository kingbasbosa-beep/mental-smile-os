enum RuntimeExecutionScope {
  safeSupport,
  providerBoundary,
  policyCheck,
  fallbackExecution,
  humanReview,
}

extension RuntimeExecutionScopeKey on RuntimeExecutionScope {
  String get key {
    switch (this) {
      case RuntimeExecutionScope.safeSupport:
        return 'safe_support';
      case RuntimeExecutionScope.providerBoundary:
        return 'provider_boundary';
      case RuntimeExecutionScope.policyCheck:
        return 'policy_check';
      case RuntimeExecutionScope.fallbackExecution:
        return 'fallback_execution';
      case RuntimeExecutionScope.humanReview:
        return 'human_review';
    }
  }
}
