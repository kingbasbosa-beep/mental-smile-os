import 'governance_kernel_block_reason.dart';
import 'governance_kernel_boundary.dart';
import 'governance_kernel_request.dart';

class GovernanceKernelGuard {
  const GovernanceKernelGuard();

  GovernanceKernelBlockReason? blockReason({
    required GovernanceKernelBoundary boundary,
    required GovernanceKernelRequest request,
  }) {
    if (!boundary.coordinationEnabled) {
      return GovernanceKernelBlockReason.runtimeDisabled;
    }
    if (boundary.policy.policyVersion != request.policyVersion) {
      return GovernanceKernelBlockReason.policyMismatch;
    }
    if (!boundary.policy.providerAllowed &&
        request.runtimeMarker.providerId.trim().isNotEmpty) {
      return GovernanceKernelBlockReason.providerBlocked;
    }
    if (boundary.policy.auditRequired && !request.auditLink.isLinked) {
      return GovernanceKernelBlockReason.missingAuditLink;
    }
    if (!boundary.policy.allowedScopes.contains(request.scope) ||
        !boundary.policy.allowedVisibilityScopes.contains(
          request.visibilityScope,
        )) {
      return GovernanceKernelBlockReason.restrictedEnvironment;
    }
    if (request.reviewMarker.reviewRequired) {
      return GovernanceKernelBlockReason.reviewRequired;
    }
    if (!boundary.policy.memoryAllowed && request.memoryReference != null) {
      return GovernanceKernelBlockReason.memoryBoundaryBlocked;
    }
    if (!boundary.policy.conversationAllowed &&
        request.conversationReference != null) {
      return GovernanceKernelBlockReason.conversationBoundaryBlocked;
    }
    if (boundary.policy.backendGovernanceRequired &&
        !request.runtimeMarker.backendGoverned) {
      return GovernanceKernelBlockReason.unsafeCoordination;
    }
    if (boundary.policy.failClosed) {
      return GovernanceKernelBlockReason.failClosed;
    }
    return null;
  }
}
