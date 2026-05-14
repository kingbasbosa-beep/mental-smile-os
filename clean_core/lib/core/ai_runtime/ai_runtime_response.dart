class AiRuntimeResponse {
  const AiRuntimeResponse({
    required this.validatedOutput,
    required this.providerId,
    required this.runtimeMode,
    required this.safetyFlags,
    required this.auditTracePlaceholder,
  });

  final String validatedOutput;
  final String providerId;
  final String runtimeMode;
  final Set<String> safetyFlags;
  final String auditTracePlaceholder;

  Map<String, Object?> toMap() {
    return {
      'validatedOutput': validatedOutput,
      'providerId': providerId,
      'runtimeMode': runtimeMode,
      'safetyFlags': safetyFlags.toList(growable: false),
      'auditTracePlaceholder': auditTracePlaceholder,
    };
  }
}
