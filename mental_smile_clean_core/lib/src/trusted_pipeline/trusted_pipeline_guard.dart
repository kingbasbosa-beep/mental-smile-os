import 'trusted_pipeline_block_reason.dart';
import 'trusted_pipeline_policy.dart';
import 'trusted_pipeline_request.dart';

class TrustedPipelineGuard {
  const TrustedPipelineGuard();

  TrustedPipelineBlockReason? blockReason({
    required TrustedPipelinePolicy policy,
    required TrustedPipelineRequest request,
  }) {
    if (!policy.pipelineEnabled) return TrustedPipelineBlockReason.pipelineBlocked;
    if (!policy.allowedStages.contains(request.stage)) {
      return TrustedPipelineBlockReason.unsafeExecution;
    }
    if (!policy.runtimeAllowed &&
        request.runtimeMarker.runtimeMode != 'disabled') {
      return TrustedPipelineBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        request.runtimeMarker.providerId.trim().isNotEmpty) {
      return TrustedPipelineBlockReason.unsafeExecution;
    }
    if (policy.signedAuthorityRequired && !request.hasSignedAuthority) {
      return TrustedPipelineBlockReason.missingAuthority;
    }
    if (policy.policyVersion != request.policyVersion ||
        policy.policyVersion != request.auditLink.policyVersion) {
      return TrustedPipelineBlockReason.policyMismatch;
    }
    if (policy.reviewRequired || request.reviewMarker.reviewRequired) {
      return TrustedPipelineBlockReason.reviewRequired;
    }
    if (policy.restrictedEnvironments.contains(
      request.runtimeMarker.environment,
    )) {
      return TrustedPipelineBlockReason.restrictedEnvironment;
    }
    if (policy.auditRequired && !request.auditLink.isLinked) {
      return TrustedPipelineBlockReason.missingAuditLink;
    }
    if (!request.reference.isLinked ||
        !policy.allowedVisibilityScopes.contains(request.visibilityScope) ||
        !request.runtimeMarker.backendGoverned) {
      return TrustedPipelineBlockReason.unsafeExecution;
    }
    if (policy.failClosed) return TrustedPipelineBlockReason.failClosed;
    return null;
  }
}
