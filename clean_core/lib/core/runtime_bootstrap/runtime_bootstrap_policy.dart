import 'runtime_bootstrap_scope.dart';
import 'runtime_bootstrap_stage.dart';
import 'runtime_bootstrap_visibility_scope.dart';

class RuntimeBootstrapPolicy {
  const RuntimeBootstrapPolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.bootstrapAllowed,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<RuntimeBootstrapStage> allowedStages;
  final Set<RuntimeBootstrapScope> allowedScopes;
  final Set<RuntimeBootstrapVisibilityScope> allowedVisibilityScopes;
  final bool bootstrapAllowed;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = RuntimeBootstrapPolicy(
    policyVersion: '2026-05-os7j',
    allowedStages: <RuntimeBootstrapStage>{
      RuntimeBootstrapStage.bootstrapRequest,
      RuntimeBootstrapStage.governanceReview,
      RuntimeBootstrapStage.auditReview,
      RuntimeBootstrapStage.releaseVerification,
      RuntimeBootstrapStage.rollbackVerification,
      RuntimeBootstrapStage.observabilityVerification,
      RuntimeBootstrapStage.isolationVerification,
      RuntimeBootstrapStage.providerStartupReview,
      RuntimeBootstrapStage.bootstrapDenied,
      RuntimeBootstrapStage.bootstrapFallback,
    },
    allowedScopes: <RuntimeBootstrapScope>{
      RuntimeBootstrapScope.runtimeActivation,
      RuntimeBootstrapScope.runtimeEnablement,
      RuntimeBootstrapScope.executionRouting,
      RuntimeBootstrapScope.releaseGovernance,
      RuntimeBootstrapScope.rollbackGovernance,
      RuntimeBootstrapScope.observabilityGovernance,
      RuntimeBootstrapScope.isolationGovernance,
      RuntimeBootstrapScope.trustedBackend,
      RuntimeBootstrapScope.trustedPipeline,
      RuntimeBootstrapScope.providerGovernance,
      RuntimeBootstrapScope.secureRuntimeEnvelope,
      RuntimeBootstrapScope.environmentActivation,
    },
    allowedVisibilityScopes: <RuntimeBootstrapVisibilityScope>{
      RuntimeBootstrapVisibilityScope.backendOnly,
      RuntimeBootstrapVisibilityScope.auditOnly,
      RuntimeBootstrapVisibilityScope.architectureInternal,
      RuntimeBootstrapVisibilityScope.bootstrapPlanning,
    },
    bootstrapAllowed: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
