import 'execution_routing_block_reason.dart';
import 'execution_routing_lock.dart';
import 'execution_routing_map.dart';
import 'execution_routing_policy.dart';

class ExecutionRoutingGuard {
  const ExecutionRoutingGuard();

  ExecutionRoutingBlockReason? blockReason({
    required ExecutionRoutingMap map,
    ExecutionRoutingPolicy policy = ExecutionRoutingPolicy.safeDefault,
    ExecutionRoutingLock lock = ExecutionRoutingLock.safeDefault,
  }) {
    if (lock.locked || lock.sealed || lock.routingBlocked) {
      return ExecutionRoutingBlockReason.routingLocked;
    }
    if (!policy.routingAllowed) {
      return ExecutionRoutingBlockReason.routingBlocked;
    }
    if (map.requirement.policyLinkRequired &&
        (map.policyVersion != policy.policyVersion ||
            map.auditLink.policyVersion != policy.policyVersion)) {
      return ExecutionRoutingBlockReason.policyMismatch;
    }
    if (!policy.runtimeAllowed && map.runtimeMarker.runtimeMode != 'disabled') {
      return ExecutionRoutingBlockReason.runtimeDisabled;
    }
    if (!policy.providerAllowed &&
        map.runtimeMarker.providerId.trim().isNotEmpty) {
      return ExecutionRoutingBlockReason.providerBlocked;
    }
    if (map.reviewMarker.reviewRequired) {
      return ExecutionRoutingBlockReason.reviewRequired;
    }
    if (map.requirement.auditLinkRequired && !map.auditLink.isLinked) {
      return ExecutionRoutingBlockReason.missingAuditLink;
    }
    if (map.requirement.ownerRequired && !map.hasTrustedOwner) {
      return ExecutionRoutingBlockReason.missingOwner;
    }
    if (map.requirement.routeApprovalRequired &&
        !map.routes.every((route) => route.isApprovedPlaceholder)) {
      return ExecutionRoutingBlockReason.unapprovedRoute;
    }
    if (!policy.allowedVisibilityScopes.contains(map.visibilityScope) ||
        !map.references.every(
          (reference) =>
              reference.isLinked && policy.allowedScopes.contains(reference.scope),
        )) {
      return ExecutionRoutingBlockReason.unsafeRouting;
    }
    if (map.requirement.backendGovernanceRequired &&
        !map.runtimeMarker.backendGoverned) {
      return ExecutionRoutingBlockReason.unsafeRouting;
    }
    if (map.requirement.sealingRequired &&
        !map.routes.every((route) => route.sealed)) {
      return ExecutionRoutingBlockReason.unsafeRouting;
    }
    if (map.runtimeMarker.routingActive) {
      return ExecutionRoutingBlockReason.unsafeRouting;
    }
    if (policy.failClosed) {
      return ExecutionRoutingBlockReason.failClosed;
    }
    return null;
  }
}
