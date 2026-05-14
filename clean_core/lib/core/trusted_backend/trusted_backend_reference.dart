class TrustedBackendReference {
  const TrustedBackendReference({
    required this.operationId,
    required this.governanceReferenceId,
    required this.hashPlaceholder,
  });

  final String operationId;
  final String governanceReferenceId;
  final String hashPlaceholder;

  bool get isLinked {
    return operationId.trim().isNotEmpty &&
        governanceReferenceId.trim().isNotEmpty;
  }

  Map<String, Object?> toMap() {
    return {
      'operationId': operationId,
      'governanceReferenceId': governanceReferenceId,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
