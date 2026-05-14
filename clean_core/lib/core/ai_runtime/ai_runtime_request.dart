class AiRuntimeRequest {
  const AiRuntimeRequest({
    required this.uid,
    required this.sanitizedInput,
    required this.runtimeMode,
    required this.providerId,
    required this.safetyFlags,
    required this.auditTracePlaceholder,
  });

  final String uid;
  final String sanitizedInput;
  final String runtimeMode;
  final String providerId;
  final Set<String> safetyFlags;
  final String auditTracePlaceholder;

  Map<String, Object?> toMap() {
    return {
      'uid': uid,
      'sanitizedInput': sanitizedInput,
      'runtimeMode': runtimeMode,
      'providerId': providerId,
      'safetyFlags': safetyFlags.toList(growable: false),
      'auditTracePlaceholder': auditTracePlaceholder,
    };
  }
}
