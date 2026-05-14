import 'ai_runtime_fallback.dart';
import 'ai_runtime_response.dart';

class AiRuntimeResult {
  const AiRuntimeResult._({
    required this.allowed,
    required this.response,
    required this.fallback,
  });

  factory AiRuntimeResult.success(AiRuntimeResponse response) {
    return AiRuntimeResult._(
      allowed: true,
      response: response,
      fallback: null,
    );
  }

  factory AiRuntimeResult.blocked(AiRuntimeFallback fallback) {
    return AiRuntimeResult._(
      allowed: false,
      response: null,
      fallback: fallback,
    );
  }

  final bool allowed;
  final AiRuntimeResponse? response;
  final AiRuntimeFallback? fallback;
}
