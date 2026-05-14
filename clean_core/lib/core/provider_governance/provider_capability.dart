enum ProviderCapability {
  textGeneration,
  safeSupport,
  translation,
  moderationAssist,
  crisisDetection,
  escalationAssist,
  auditTracing,
}

extension ProviderCapabilityKey on ProviderCapability {
  String get key {
    switch (this) {
      case ProviderCapability.textGeneration:
        return 'text_generation';
      case ProviderCapability.safeSupport:
        return 'safe_support';
      case ProviderCapability.translation:
        return 'translation';
      case ProviderCapability.moderationAssist:
        return 'moderation_assist';
      case ProviderCapability.crisisDetection:
        return 'crisis_detection';
      case ProviderCapability.escalationAssist:
        return 'escalation_assist';
      case ProviderCapability.auditTracing:
        return 'audit_tracing';
    }
  }
}
