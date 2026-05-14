import 'ai_provider_registry.dart';
import 'ai_runtime_capability.dart';
import 'ai_runtime_fallback.dart';
import 'ai_runtime_state.dart';

class AiRuntimeGuard {
  const AiRuntimeGuard();

  AiRuntimeFallback? blockReason({
    required AiRuntimeState state,
    required AiProviderRegistry registry,
    required String providerId,
    required AiRuntimeCapability requiredCapability,
  }) {
    if (!state.aiEnabled) return AiRuntimeFallback.runtimeDisabled;
    if (state.fallbackOnlyMode) {
      return const AiRuntimeFallback(
        reason: AiRuntimeFallbackReason.fallbackOnlyMode,
        messageKey: 'fallback_only_mode',
      );
    }
    if (!state.backendGoverned) {
      return const AiRuntimeFallback(
        reason: AiRuntimeFallbackReason.safetyBlocked,
        messageKey: 'backend_governance_required',
      );
    }
    if (!state.isProviderAllowed(providerId)) {
      return const AiRuntimeFallback(
        reason: AiRuntimeFallbackReason.providerUnavailable,
        messageKey: 'provider_not_allowed',
      );
    }

    final provider = registry.providerById(providerId);
    if (provider == null || !provider.supports(requiredCapability)) {
      return const AiRuntimeFallback(
        reason: AiRuntimeFallbackReason.providerUnavailable,
        messageKey: 'provider_capability_unavailable',
      );
    }

    return null;
  }
}
