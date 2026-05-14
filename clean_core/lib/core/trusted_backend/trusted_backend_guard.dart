import 'trusted_backend_block_reason.dart';
import 'trusted_backend_boundary.dart';
import 'trusted_backend_request.dart';

class TrustedBackendGuard {
  const TrustedBackendGuard();

  TrustedBackendBlockReason? blockReason({
    required TrustedBackendBoundary boundary,
    required TrustedBackendRequest request,
  }) {
    if (!boundary.policy.backendEnabled || !boundary.backendRuntimeImplemented) {
      return TrustedBackendBlockReason.backendBlocked;
    }
    if (boundary.policy.restrictedEnvironments.contains(
      request.runtimeMarker.environment,
    )) {
      return TrustedBackendBlockReason.restrictedEnvironment;
    }
    if (!boundary.policy.runtimeAllowed &&
        request.runtimeMarker.runtimeMode != 'disabled') {
      return TrustedBackendBlockReason.runtimeDisabled;
    }
    if (!boundary.policy.providerAllowed &&
        request.runtimeMarker.providerId.trim().isNotEmpty) {
      return TrustedBackendBlockReason.unsafeExecution;
    }
    if (request.requirement.signedAuthorityRequired &&
        !request.hasSignedAuthority) {
      return TrustedBackendBlockReason.missingAuthority;
    }
    if (request.policyVersion != boundary.policy.policyVersion ||
        request.auditLink.policyVersion != boundary.policy.policyVersion) {
      return TrustedBackendBlockReason.policyMismatch;
    }
    if (request.reviewRequired) return TrustedBackendBlockReason.reviewRequired;
    if (request.requirement.auditLinkRequired && !request.auditLink.isLinked) {
      return TrustedBackendBlockReason.missingAuditLink;
    }
    if (request.requirement.governanceReferenceRequired &&
        !request.reference.isLinked) {
      return TrustedBackendBlockReason.unsafeExecution;
    }
    if (!boundary.policy.allowedVisibilityScopes.contains(
      request.visibilityScope,
    )) {
      return TrustedBackendBlockReason.unsafeExecution;
    }
    if (boundary.policy.failClosed) return TrustedBackendBlockReason.failClosed;
    return null;
  }
}
