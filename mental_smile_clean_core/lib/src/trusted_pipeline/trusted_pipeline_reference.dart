class TrustedPipelineReference {
  const TrustedPipelineReference({
    required this.pipelineId,
    required this.operationId,
    required this.hashPlaceholder,
  });

  final String pipelineId;
  final String operationId;
  final String hashPlaceholder;

  bool get isLinked {
    return pipelineId.trim().isNotEmpty && operationId.trim().isNotEmpty;
  }
}
