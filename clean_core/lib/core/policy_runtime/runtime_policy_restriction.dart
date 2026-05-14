import 'runtime_policy_mode.dart';

class RuntimePolicyRestriction {
  const RuntimePolicyRestriction({
    required this.blockedProviders,
    required this.blockedRuntimeModes,
    required this.restrictedCapabilities,
    required this.providerRestrictionsEnabled,
  });

  static const RuntimePolicyRestriction safeDefault = RuntimePolicyRestriction(
    blockedProviders: <String>{'open_ai', 'gemini'},
    blockedRuntimeModes: <RuntimePolicyMode>{
      RuntimePolicyMode.restrictedProvider,
      RuntimePolicyMode.serverGoverned,
    },
    restrictedCapabilities: <String>{'live_inference', 'streaming_chat'},
    providerRestrictionsEnabled: true,
  );

  final Set<String> blockedProviders;
  final Set<RuntimePolicyMode> blockedRuntimeModes;
  final Set<String> restrictedCapabilities;
  final bool providerRestrictionsEnabled;

  bool blocksProvider(String providerId) {
    return providerRestrictionsEnabled && blockedProviders.contains(providerId);
  }

  bool blocksMode(RuntimePolicyMode mode) {
    return blockedRuntimeModes.contains(mode);
  }
}
