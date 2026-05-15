import 'system_dependency_edge.dart';
import 'system_dependency_node.dart';
import 'system_topology_audit_link.dart';
import 'system_topology_lock.dart';
import 'system_topology_policy.dart';
import 'system_topology_reference.dart';
import 'system_topology_requirement.dart';
import 'system_topology_review_marker.dart';
import 'system_topology_runtime_marker.dart';
import 'system_topology_scope.dart';
import 'system_topology_state.dart';
import 'system_topology_visibility_scope.dart';

class SystemTopology {
  const SystemTopology({
    required this.topologyId,
    required this.state,
    required this.visibilityScope,
    required this.policy,
    required this.requirement,
    required this.reference,
    required this.nodes,
    required this.edges,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.lock,
    required this.signedAuthorityPlaceholder,
  });

  static const SystemTopology lockedDefault = SystemTopology(
    topologyId: 'locked_system_topology_default',
    state: SystemTopologyState.locked,
    visibilityScope: SystemTopologyVisibilityScope.governanceInternal,
    policy: SystemTopologyPolicy.safeDefault,
    requirement: SystemTopologyRequirement.safeDefault,
    reference: SystemTopologyReference(
      referenceId: 'system_topology_reference',
      scope: SystemTopologyScope.governanceFederation,
      hashPlaceholder: 'system_topology_hash_placeholder',
    ),
    nodes: <SystemDependencyNode>[],
    edges: <SystemDependencyEdge>[],
    runtimeMarker: SystemTopologyRuntimeMarker.disabled,
    auditLink: SystemTopologyAuditLink(
      auditId: '',
      traceHash: '',
      policyVersion: '2026-05-os6f',
    ),
    reviewMarker: SystemTopologyReviewMarker.safeDefault,
    lock: SystemTopologyLock.safeDefault,
    signedAuthorityPlaceholder: '',
  );

  final String topologyId;
  final SystemTopologyState state;
  final SystemTopologyVisibilityScope visibilityScope;
  final SystemTopologyPolicy policy;
  final SystemTopologyRequirement requirement;
  final SystemTopologyReference reference;
  final List<SystemDependencyNode> nodes;
  final List<SystemDependencyEdge> edges;
  final SystemTopologyRuntimeMarker runtimeMarker;
  final SystemTopologyAuditLink auditLink;
  final SystemTopologyReviewMarker reviewMarker;
  final SystemTopologyLock lock;
  final String signedAuthorityPlaceholder;

  bool get hasSignedAuthority {
    return signedAuthorityPlaceholder.trim().isNotEmpty;
  }
}
