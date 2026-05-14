import 'ai_provider_type.dart';
import 'ai_runtime_capability.dart';

class AiProviderCapabilities {
  const AiProviderCapabilities({
    required this.providerId,
    required this.providerType,
    required this.enabled,
    required this.capabilities,
  });

  final String providerId;
  final AiProviderType providerType;
  final bool enabled;
  final Set<AiRuntimeCapability> capabilities;

  bool supports(AiRuntimeCapability capability) {
    return enabled && capabilities.contains(capability);
  }
}
