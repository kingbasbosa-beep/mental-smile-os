class ConversationRuntimeMarker {
  const ConversationRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.policyVersion,
    required this.backendGoverned,
  });

  static const ConversationRuntimeMarker disabled = ConversationRuntimeMarker(
    runtimeMode: 'ai_disabled',
    providerId: '',
    policyVersion: '2026-05-os4c',
    backendGoverned: true,
  );

  final String runtimeMode;
  final String providerId;
  final String policyVersion;
  final bool backendGoverned;

  Map<String, Object?> toMap() {
    return {
      'runtimeMode': runtimeMode,
      'providerId': providerId,
      'policyVersion': policyVersion,
      'backendGoverned': backendGoverned,
    };
  }
}
