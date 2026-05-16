import 'trusted_pipeline_stage.dart';
import 'trusted_pipeline_visibility_scope.dart';

class TrustedPipelinePolicy {
  const TrustedPipelinePolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.pipelineEnabled,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.auditRequired,
    required this.reviewRequired,
    required this.signedAuthorityRequired,
    required this.failClosed,
  });

  static const TrustedPipelinePolicy safeDefault = TrustedPipelinePolicy(
    policyVersion: '2026-05-os6b',
    allowedStages: <TrustedPipelineStage>{
      TrustedPipelineStage.policyReview,
      TrustedPipelineStage.auditVerification,
      TrustedPipelineStage.governanceVerification,
      TrustedPipelineStage.reviewCheckpoint,
      TrustedPipelineStage.fallbackStage,
      TrustedPipelineStage.blockedStage,
    },
    allowedVisibilityScopes: <TrustedPipelineVisibilityScope>{
      TrustedPipelineVisibilityScope.backendOnly,
      TrustedPipelineVisibilityScope.auditOnly,
      TrustedPipelineVisibilityScope.governanceInternal,
    },
    restrictedEnvironments: <String>{'production'},
    pipelineEnabled: false,
    runtimeAllowed: false,
    providerAllowed: false,
    auditRequired: true,
    reviewRequired: true,
    signedAuthorityRequired: true,
    failClosed: true,
  );

  final String policyVersion;
  final Set<TrustedPipelineStage> allowedStages;
  final Set<TrustedPipelineVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool pipelineEnabled;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool auditRequired;
  final bool reviewRequired;
  final bool signedAuthorityRequired;
  final bool failClosed;
}
