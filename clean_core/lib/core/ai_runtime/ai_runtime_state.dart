class AiRuntimeState {
  const AiRuntimeState({
    required this.aiEnabled,
    required this.fallbackOnlyMode,
    required this.runtimeMode,
    required this.allowedProviderIds,
    required this.blockedProviderIds,
    required this.backendGoverned,
  });

  static const AiRuntimeState disabled = AiRuntimeState(
    aiEnabled: false,
    fallbackOnlyMode: true,
    runtimeMode: 'disabled_placeholder',
    allowedProviderIds: <String>{},
    blockedProviderIds: <String>{},
    backendGoverned: true,
  );

  final bool aiEnabled;
  final bool fallbackOnlyMode;
  final String runtimeMode;
  final Set<String> allowedProviderIds;
  final Set<String> blockedProviderIds;
  final bool backendGoverned;

  bool isProviderAllowed(String providerId) {
    final id = providerId.trim();
    if (id.isEmpty) return false;
    if (blockedProviderIds.contains(id)) return false;
    return allowedProviderIds.contains(id);
  }
}
