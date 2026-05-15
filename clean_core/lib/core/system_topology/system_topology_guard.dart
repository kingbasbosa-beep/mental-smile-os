import 'system_topology.dart';
import 'system_topology_block_reason.dart';

class SystemTopologyGuard {
  const SystemTopologyGuard();

  SystemTopologyBlockReason? blockReason(SystemTopology topology) {
    if (topology.lock.locked || topology.lock.sealed) {
      return SystemTopologyBlockReason.topologyLocked;
    }
    if (topology.requirement.signedAuthorityRequired &&
        !topology.hasSignedAuthority) {
      return SystemTopologyBlockReason.missingAuthority;
    }
    if (topology.requirement.policyLinkRequired &&
        topology.policy.policyVersion != topology.auditLink.policyVersion) {
      return SystemTopologyBlockReason.policyMismatch;
    }
    if (!topology.policy.runtimeAllowed &&
        topology.runtimeMarker.runtimeMode != 'disabled') {
      return SystemTopologyBlockReason.runtimeDisabled;
    }
    if (!topology.policy.providerAllowed &&
        topology.runtimeMarker.providerId.trim().isNotEmpty) {
      return SystemTopologyBlockReason.unsafeDependency;
    }
    if (topology.reviewMarker.reviewRequired) {
      return SystemTopologyBlockReason.reviewRequired;
    }
    if (topology.policy.restrictedEnvironments.contains(
      topology.runtimeMarker.environment,
    )) {
      return SystemTopologyBlockReason.restrictedEnvironment;
    }
    if (topology.requirement.auditLinkRequired && !topology.auditLink.isLinked) {
      return SystemTopologyBlockReason.missingAuditLink;
    }
    if (!topology.reference.isLinked ||
        !topology.policy.allowedScopes.contains(topology.reference.scope) ||
        !topology.policy.allowedVisibilityScopes.contains(
          topology.visibilityScope,
        ) ||
        !topology.nodes.every((node) => node.isValid) ||
        !topology.edges.every((edge) => edge.isValid) ||
        (topology.policy.backendGovernanceRequired &&
            !topology.runtimeMarker.backendGoverned)) {
      return SystemTopologyBlockReason.unsafeDependency;
    }
    if (topology.policy.failClosed) return SystemTopologyBlockReason.failClosed;
    return null;
  }
}
