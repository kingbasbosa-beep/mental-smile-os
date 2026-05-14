enum AiRuntimeCapability {
  textSupport,
  safetyClassification,
  fallbackResponse,
  auditTrace,
}

extension AiRuntimeCapabilityKey on AiRuntimeCapability {
  String get key {
    switch (this) {
      case AiRuntimeCapability.textSupport:
        return 'text_support';
      case AiRuntimeCapability.safetyClassification:
        return 'safety_classification';
      case AiRuntimeCapability.fallbackResponse:
        return 'fallback_response';
      case AiRuntimeCapability.auditTrace:
        return 'audit_trace';
    }
  }
}
