import 'system_topology_scope.dart';

class SystemTopologyReference {
  const SystemTopologyReference({
    required this.referenceId,
    required this.scope,
    required this.hashPlaceholder,
  });

  final String referenceId;
  final SystemTopologyScope scope;
  final String hashPlaceholder;

  bool get isLinked {
    return referenceId.trim().isNotEmpty && hashPlaceholder.trim().isNotEmpty;
  }
}
