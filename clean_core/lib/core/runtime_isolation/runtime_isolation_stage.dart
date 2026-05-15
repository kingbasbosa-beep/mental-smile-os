enum RuntimeIsolationStage {
  isolationRequest,
  governanceReview,
  auditReview,
  runtimeIsolationReview,
  providerIsolationReview,
  environmentIsolationReview,
  boundaryIsolationReview,
  isolationDenied,
  isolationFallback,
}

extension RuntimeIsolationStageKey on RuntimeIsolationStage {
  String get key {
    switch (this) {
      case RuntimeIsolationStage.isolationRequest:
        return 'isolation_request';
      case RuntimeIsolationStage.governanceReview:
        return 'governance_review';
      case RuntimeIsolationStage.auditReview:
        return 'audit_review';
      case RuntimeIsolationStage.runtimeIsolationReview:
        return 'runtime_isolation_review';
      case RuntimeIsolationStage.providerIsolationReview:
        return 'provider_isolation_review';
      case RuntimeIsolationStage.environmentIsolationReview:
        return 'environment_isolation_review';
      case RuntimeIsolationStage.boundaryIsolationReview:
        return 'boundary_isolation_review';
      case RuntimeIsolationStage.isolationDenied:
        return 'isolation_denied';
      case RuntimeIsolationStage.isolationFallback:
        return 'isolation_fallback';
    }
  }
}
