enum SecureRuntimeScope {
  execution,
  governance,
  provider,
  audit,
  review,
  fallback,
}

extension SecureRuntimeScopeKey on SecureRuntimeScope {
  String get key {
    switch (this) {
      case SecureRuntimeScope.execution:
        return 'execution';
      case SecureRuntimeScope.governance:
        return 'governance';
      case SecureRuntimeScope.provider:
        return 'provider';
      case SecureRuntimeScope.audit:
        return 'audit';
      case SecureRuntimeScope.review:
        return 'review';
      case SecureRuntimeScope.fallback:
        return 'fallback';
    }
  }
}
