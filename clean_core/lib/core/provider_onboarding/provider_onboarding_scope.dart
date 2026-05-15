enum ProviderOnboardingScope {
  llmProvider,
  moderationProvider,
  embeddingsProvider,
  safetyProvider,
  backendProvider,
  orchestrationProvider,
  runtimeExecutionProvider,
  trustedBackendProvider,
}

extension ProviderOnboardingScopeKey on ProviderOnboardingScope {
  String get key {
    switch (this) {
      case ProviderOnboardingScope.llmProvider:
        return 'llm_provider';
      case ProviderOnboardingScope.moderationProvider:
        return 'moderation_provider';
      case ProviderOnboardingScope.embeddingsProvider:
        return 'embeddings_provider';
      case ProviderOnboardingScope.safetyProvider:
        return 'safety_provider';
      case ProviderOnboardingScope.backendProvider:
        return 'backend_provider';
      case ProviderOnboardingScope.orchestrationProvider:
        return 'orchestration_provider';
      case ProviderOnboardingScope.runtimeExecutionProvider:
        return 'runtime_execution_provider';
      case ProviderOnboardingScope.trustedBackendProvider:
        return 'trusted_backend_provider';
    }
  }
}
