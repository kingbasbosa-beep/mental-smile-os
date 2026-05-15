import 'runtime_isolation_scope.dart';
import 'runtime_isolation_stage.dart';
import 'runtime_isolation_visibility_scope.dart';

class RuntimeIsolationPolicy {
  const RuntimeIsolationPolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.isolationAllowed,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<RuntimeIsolationStage> allowedStages;
  final Set<RuntimeIsolationScope> allowedScopes;
  final Set<RuntimeIsolationVisibilityScope> allowedVisibilityScopes;
  final bool isolationAllowed;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = RuntimeIsolationPolicy(
    policyVersion: '2026-05-os7h',
    allowedStages: <RuntimeIsolationStage>{
      RuntimeIsolationStage.isolationRequest,
      RuntimeIsolationStage.governanceReview,
      RuntimeIsolationStage.auditReview,
      RuntimeIsolationStage.runtimeIsolationReview,
      RuntimeIsolationStage.providerIsolationReview,
      RuntimeIsolationStage.environmentIsolationReview,
      RuntimeIsolationStage.boundaryIsolationReview,
      RuntimeIsolationStage.isolationDenied,
      RuntimeIsolationStage.isolationFallback,
    },
    allowedScopes: <RuntimeIsolationScope>{
      RuntimeIsolationScope.executionRouting,
      RuntimeIsolationScope.activationFlows,
      RuntimeIsolationScope.enablementFlows,
      RuntimeIsolationScope.rollbackSystems,
      RuntimeIsolationScope.observabilitySystems,
      RuntimeIsolationScope.trustedBackend,
      RuntimeIsolationScope.trustedPipeline,
      RuntimeIsolationScope.governanceFederation,
      RuntimeIsolationScope.runtimeReadiness,
      RuntimeIsolationScope.secureRuntimeEnvelope,
      RuntimeIsolationScope.environmentActivation,
    },
    allowedVisibilityScopes: <RuntimeIsolationVisibilityScope>{
      RuntimeIsolationVisibilityScope.backendOnly,
      RuntimeIsolationVisibilityScope.auditOnly,
      RuntimeIsolationVisibilityScope.architectureInternal,
      RuntimeIsolationVisibilityScope.isolationPlanning,
    },
    isolationAllowed: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
