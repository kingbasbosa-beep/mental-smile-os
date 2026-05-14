import 'ai_provider_registry.dart';
import 'ai_runtime_capability.dart';
import 'ai_runtime_fallback.dart';
import 'ai_runtime_guard.dart';
import 'ai_runtime_result.dart';
import 'ai_runtime_state.dart';

class AiRuntimeIsolation {
  const AiRuntimeIsolation({
    required this.state,
    required this.registry,
    this.guard = const AiRuntimeGuard(),
  });

  final AiRuntimeState state;
  final AiProviderRegistry registry;
  final AiRuntimeGuard guard;

  AiRuntimeResult checkBoundary({
    required String providerId,
    required AiRuntimeCapability requiredCapability,
  }) {
    final fallback = guard.blockReason(
      state: state,
      registry: registry,
      providerId: providerId,
      requiredCapability: requiredCapability,
    );
    if (fallback != null) return AiRuntimeResult.blocked(fallback);

    return AiRuntimeResult.blocked(
      const AiRuntimeFallback(
        reason: AiRuntimeFallbackReason.runtimeDisabled,
        messageKey: 'runtime_execution_not_implemented',
      ),
    );
  }
}
