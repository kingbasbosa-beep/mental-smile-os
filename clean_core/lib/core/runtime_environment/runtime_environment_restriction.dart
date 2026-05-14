class RuntimeEnvironmentRestriction {
  const RuntimeEnvironmentRestriction({
    required this.blockedRuntimeModes,
    required this.blockedProviders,
    required this.restrictedCapabilities,
    required this.escalationEnabled,
    required this.aiRuntimeEnabled,
    required this.providerEnabled,
    required this.backendGovernanceRequired,
  });

  static const RuntimeEnvironmentRestriction safeDefault =
      RuntimeEnvironmentRestriction(
    blockedRuntimeModes: <String>{'server_governed', 'restricted_provider'},
    blockedProviders: <String>{'open_ai', 'gemini'},
    restrictedCapabilities: <String>{
      'live_inference',
      'streaming_chat',
      'automated_escalation',
    },
    escalationEnabled: false,
    aiRuntimeEnabled: false,
    providerEnabled: false,
    backendGovernanceRequired: true,
  );

  final Set<String> blockedRuntimeModes;
  final Set<String> blockedProviders;
  final Set<String> restrictedCapabilities;
  final bool escalationEnabled;
  final bool aiRuntimeEnabled;
  final bool providerEnabled;
  final bool backendGovernanceRequired;

  bool blocksProvider(String providerId) {
    return !providerEnabled || blockedProviders.contains(providerId.trim());
  }

  bool blocksRuntimeMode(String runtimeMode) {
    return blockedRuntimeModes.contains(runtimeMode.trim());
  }
}
