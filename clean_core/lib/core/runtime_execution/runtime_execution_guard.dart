import 'runtime_execution_block_reason.dart';
import 'runtime_execution_boundary.dart';
import 'runtime_execution_request.dart';

class RuntimeExecutionGuard {
  const RuntimeExecutionGuard();

  RuntimeExecutionBlockReason? blockReason({
    required RuntimeExecutionBoundary boundary,
    required RuntimeExecutionRequest request,
  }) {
    if (!boundary.executionEnabled) {
      return RuntimeExecutionBlockReason.runtimeDisabled;
    }
    if (!boundary.policy.providerAllowed &&
        request.runtimeMarker.providerId.trim().isNotEmpty) {
      return RuntimeExecutionBlockReason.providerBlocked;
    }
    if (boundary.policy.policyRequired &&
        boundary.policy.policyVersion != request.policyVersion) {
      return RuntimeExecutionBlockReason.policyMismatch;
    }
    if (boundary.policy.auditRequired && !request.auditLink.isLinked) {
      return RuntimeExecutionBlockReason.auditMissing;
    }
    if (!boundary.policy.allowedScopes.contains(request.scope) ||
        !boundary.policy.allowedVisibilityScopes.contains(
          request.visibilityScope,
        )) {
      return RuntimeExecutionBlockReason.environmentRestricted;
    }
    if (request.escalationSuggested) {
      return RuntimeExecutionBlockReason.escalationRequired;
    }
    if (boundary.policy.backendGovernanceRequired &&
        !request.runtimeMarker.backendGoverned) {
      return RuntimeExecutionBlockReason.failClosed;
    }
    if (boundary.policy.failClosed) return RuntimeExecutionBlockReason.failClosed;
    return null;
  }
}
