class AuditRuntimeMarker {
  const AuditRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.policyVersion,
    required this.fallbackReason,
  });

  final String runtimeMode;
  final String providerId;
  final String policyVersion;
  final String fallbackReason;

  Map<String, Object?> toMap() {
    return {
      'runtimeMode': runtimeMode,
      'providerId': providerId,
      'policyVersion': policyVersion,
      'fallbackReason': fallbackReason,
    };
  }
}
