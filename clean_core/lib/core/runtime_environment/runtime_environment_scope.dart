enum RuntimeEnvironmentScope {
  app,
  aiRuntime,
  backendBoundary,
  safetyReview,
  storeReview,
}

extension RuntimeEnvironmentScopeKey on RuntimeEnvironmentScope {
  String get key {
    switch (this) {
      case RuntimeEnvironmentScope.app:
        return 'app';
      case RuntimeEnvironmentScope.aiRuntime:
        return 'ai_runtime';
      case RuntimeEnvironmentScope.backendBoundary:
        return 'backend_boundary';
      case RuntimeEnvironmentScope.safetyReview:
        return 'safety_review';
      case RuntimeEnvironmentScope.storeReview:
        return 'store_review';
    }
  }
}
