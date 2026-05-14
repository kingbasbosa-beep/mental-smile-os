import 'ai_provider_capabilities.dart';
import 'ai_runtime_capability.dart';

class AiProviderRegistry {
  const AiProviderRegistry({
    required this.providers,
  });

  final Map<String, AiProviderCapabilities> providers;

  AiProviderCapabilities? providerById(String providerId) {
    return providers[providerId.trim()];
  }

  List<AiProviderCapabilities> enabledProviders() {
    return providers.values
        .where((provider) => provider.enabled)
        .toList(growable: false);
  }

  List<AiProviderCapabilities> providersWithCapability(
    AiRuntimeCapability capability,
  ) {
    return enabledProviders()
        .where((provider) => provider.supports(capability))
        .toList(growable: false);
  }
}
