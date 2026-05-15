import 'runtime_observability_scope.dart';
import 'runtime_observability_stage.dart';
import 'runtime_observability_visibility_scope.dart';

class RuntimeObservabilityPolicy {
  const RuntimeObservabilityPolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.observabilityAllowed,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<RuntimeObservabilityStage> allowedStages;
  final Set<RuntimeObservabilityScope> allowedScopes;
  final Set<RuntimeObservabilityVisibilityScope> allowedVisibilityScopes;
  final bool observabilityAllowed;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = RuntimeObservabilityPolicy(
    policyVersion: '2026-05-os7g',
    allowedStages: <RuntimeObservabilityStage>{
      RuntimeObservabilityStage.observationRequest,
      RuntimeObservabilityStage.governanceReview,
      RuntimeObservabilityStage.auditReview,
      RuntimeObservabilityStage.providerObservationReview,
      RuntimeObservabilityStage.activationObservationReview,
      RuntimeObservabilityStage.rollbackObservationReview,
      RuntimeObservabilityStage.fallbackObservationReview,
      RuntimeObservabilityStage.observationDenied,
      RuntimeObservabilityStage.observationFallback,
    },
    allowedScopes: <RuntimeObservabilityScope>{
      RuntimeObservabilityScope.activationFlows,
      RuntimeObservabilityScope.enablementFlows,
      RuntimeObservabilityScope.routingFlows,
      RuntimeObservabilityScope.rollbackFlows,
      RuntimeObservabilityScope.environmentActivation,
      RuntimeObservabilityScope.trustedBackend,
      RuntimeObservabilityScope.trustedPipeline,
      RuntimeObservabilityScope.governanceFederation,
      RuntimeObservabilityScope.runtimeReadiness,
      RuntimeObservabilityScope.secureRuntimeEnvelope,
    },
    allowedVisibilityScopes: <RuntimeObservabilityVisibilityScope>{
      RuntimeObservabilityVisibilityScope.backendOnly,
      RuntimeObservabilityVisibilityScope.auditOnly,
      RuntimeObservabilityVisibilityScope.architectureInternal,
      RuntimeObservabilityVisibilityScope.observabilityPlanning,
    },
    observabilityAllowed: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
