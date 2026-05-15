import 'system_topology_reference.dart';
import 'system_topology_scope.dart';

class SystemDependencyNode {
  const SystemDependencyNode({
    required this.nodeId,
    required this.scope,
    required this.ownerKey,
    required this.reference,
    required this.sealed,
  });

  final String nodeId;
  final SystemTopologyScope scope;
  final String ownerKey;
  final SystemTopologyReference reference;
  final bool sealed;

  bool get isValid {
    return nodeId.trim().isNotEmpty &&
        ownerKey.trim().isNotEmpty &&
        reference.isLinked &&
        sealed;
  }
}
