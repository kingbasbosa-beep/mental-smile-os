import 'runtime_rollback_scope.dart';
import 'runtime_rollback_stage.dart';
import 'runtime_rollback_visibility_scope.dart';

class RuntimeRollbackPolicy {
  const RuntimeRollbackPolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.rollbackAllowed,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<RuntimeRollbackStage> allowedStages;
  final Set<RuntimeRollbackScope> allowedScopes;
  final Set<RuntimeRollbackVisibilityScope> allowedVisibilityScopes;
  final bool rollbackAllowed;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = RuntimeRollbackPolicy(
    policyVersion: '2026-05-os7f',
    allowedStages: <RuntimeRollbackStage>{
      RuntimeRollbackStage.rollbackRequest,
      RuntimeRollbackStage.governanceReview,
      RuntimeRollbackStage.auditReview,
      RuntimeRollbackStage.providerRollbackReview,
      RuntimeRollbackStage.environmentRollbackReview,
      RuntimeRollbackStage.secureEnvelopeRollbackReview,
      RuntimeRollbackStage.activationRollbackReview,
      RuntimeRollbackStage.rollbackDenied,
      RuntimeRollbackStage.rollbackFallback,
    },
    allowedScopes: <RuntimeRollbackScope>{
      RuntimeRollbackScope.runtimeActivation,
      RuntimeRollbackScope.runtimeEnablement,
      RuntimeRollbackScope.executionRouting,
      RuntimeRollbackScope.providerGovernance,
      RuntimeRollbackScope.trustedBackend,
      RuntimeRollbackScope.trustedPipeline,
      RuntimeRollbackScope.governanceFederation,
      RuntimeRollbackScope.runtimeReadiness,
      RuntimeRollbackScope.environmentActivation,
      RuntimeRollbackScope.secureRuntimeEnvelope,
    },
    allowedVisibilityScopes: <RuntimeRollbackVisibilityScope>{
      RuntimeRollbackVisibilityScope.backendOnly,
      RuntimeRollbackVisibilityScope.auditOnly,
      RuntimeRollbackVisibilityScope.architectureInternal,
      RuntimeRollbackVisibilityScope.rollbackPlanning,
    },
    rollbackAllowed: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
