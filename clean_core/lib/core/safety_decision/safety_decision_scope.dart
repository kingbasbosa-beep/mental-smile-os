enum SafetyDecisionScope {
  runtime,
  provider,
  policy,
  environment,
  escalation,
  audit,
}

extension SafetyDecisionScopeKey on SafetyDecisionScope {
  String get key {
    switch (this) {
      case SafetyDecisionScope.runtime:
        return 'runtime';
      case SafetyDecisionScope.provider:
        return 'provider';
      case SafetyDecisionScope.policy:
        return 'policy';
      case SafetyDecisionScope.environment:
        return 'environment';
      case SafetyDecisionScope.escalation:
        return 'escalation';
      case SafetyDecisionScope.audit:
        return 'audit';
    }
  }
}
