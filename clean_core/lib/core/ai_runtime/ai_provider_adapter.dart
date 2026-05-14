import 'ai_provider_capabilities.dart';
import 'ai_runtime_fallback.dart';
import 'ai_runtime_request.dart';
import 'ai_runtime_result.dart';

abstract class AiProviderAdapter {
  AiProviderCapabilities get capabilities;

  Future<AiRuntimeResult> complete(AiRuntimeRequest request);
}

class DisabledAiProviderAdapter implements AiProviderAdapter {
  const DisabledAiProviderAdapter(this.capabilities);

  @override
  final AiProviderCapabilities capabilities;

  @override
  Future<AiRuntimeResult> complete(AiRuntimeRequest request) async {
    return AiRuntimeResult.blocked(
      const AiRuntimeFallback(
        reason: AiRuntimeFallbackReason.runtimeDisabled,
        messageKey: 'provider_disabled',
      ),
    );
  }
}
