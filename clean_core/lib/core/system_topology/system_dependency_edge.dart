class SystemDependencyEdge {
  const SystemDependencyEdge({
    required this.edgeId,
    required this.fromNodeId,
    required this.toNodeId,
    required this.relationshipKey,
    required this.backendOwned,
  });

  final String edgeId;
  final String fromNodeId;
  final String toNodeId;
  final String relationshipKey;
  final bool backendOwned;

  bool get isValid {
    return edgeId.trim().isNotEmpty &&
        fromNodeId.trim().isNotEmpty &&
        toNodeId.trim().isNotEmpty &&
        relationshipKey.trim().isNotEmpty &&
        backendOwned;
  }
}
