enum AiRuntimeFallbackReason {
  runtimeDisabled,
  providerUnavailable,
  safetyBlocked,
  lowConfidence,
  backendUnavailable,
  fallbackOnlyMode,
}

extension AiRuntimeFallbackReasonKey on AiRuntimeFallbackReason {
  String get key {
    switch (this) {
      case AiRuntimeFallbackReason.runtimeDisabled:
        return 'runtime_disabled';
      case AiRuntimeFallbackReason.providerUnavailable:
        return 'provider_unavailable';
      case AiRuntimeFallbackReason.safetyBlocked:
        return 'safety_blocked';
      case AiRuntimeFallbackReason.lowConfidence:
        return 'low_confidence';
      case AiRuntimeFallbackReason.backendUnavailable:
        return 'backend_unavailable';
      case AiRuntimeFallbackReason.fallbackOnlyMode:
        return 'fallback_only_mode';
    }
  }
}

class AiRuntimeFallback {
  const AiRuntimeFallback({
    required this.reason,
    required this.messageKey,
  });

  static const AiRuntimeFallback runtimeDisabled = AiRuntimeFallback(
    reason: AiRuntimeFallbackReason.runtimeDisabled,
    messageKey: 'ai_runtime_disabled',
  );

  final AiRuntimeFallbackReason reason;
  final String messageKey;

  Map<String, Object?> toMap() {
    return {
      'reason': reason.key,
      'messageKey': messageKey,
    };
  }
}
