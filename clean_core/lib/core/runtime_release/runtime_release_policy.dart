import 'runtime_release_scope.dart';
import 'runtime_release_stage.dart';
import 'runtime_release_visibility_scope.dart';

class RuntimeReleasePolicy {
  const RuntimeReleasePolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.releaseAllowed,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<RuntimeReleaseStage> allowedStages;
  final Set<RuntimeReleaseScope> allowedScopes;
  final Set<RuntimeReleaseVisibilityScope> allowedVisibilityScopes;
  final bool releaseAllowed;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = RuntimeReleasePolicy(
    policyVersion: '2026-05-os7i',
    allowedStages: <RuntimeReleaseStage>{
      RuntimeReleaseStage.releaseRequest,
      RuntimeReleaseStage.governanceReview,
      RuntimeReleaseStage.auditReview,
      RuntimeReleaseStage.providerReview,
      RuntimeReleaseStage.environmentReview,
      RuntimeReleaseStage.rollbackReview,
      RuntimeReleaseStage.observabilityReview,
      RuntimeReleaseStage.isolationReview,
      RuntimeReleaseStage.releaseDenied,
      RuntimeReleaseStage.releaseFallback,
    },
    allowedScopes: <RuntimeReleaseScope>{
      RuntimeReleaseScope.runtimeActivation,
      RuntimeReleaseScope.runtimeEnablement,
      RuntimeReleaseScope.executionRouting,
      RuntimeReleaseScope.environmentActivation,
      RuntimeReleaseScope.rollbackReadiness,
      RuntimeReleaseScope.observabilityReadiness,
      RuntimeReleaseScope.isolationReadiness,
      RuntimeReleaseScope.trustedBackend,
      RuntimeReleaseScope.trustedPipeline,
      RuntimeReleaseScope.providerGovernance,
      RuntimeReleaseScope.secureRuntimeEnvelope,
    },
    allowedVisibilityScopes: <RuntimeReleaseVisibilityScope>{
      RuntimeReleaseVisibilityScope.backendOnly,
      RuntimeReleaseVisibilityScope.auditOnly,
      RuntimeReleaseVisibilityScope.architectureInternal,
      RuntimeReleaseVisibilityScope.releasePlanning,
    },
    releaseAllowed: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
