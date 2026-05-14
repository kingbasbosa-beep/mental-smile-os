enum AiProviderType {
  openAi,
  gemini,
  localOffline,
  mock,
}

extension AiProviderTypeKey on AiProviderType {
  String get key {
    switch (this) {
      case AiProviderType.openAi:
        return 'open_ai';
      case AiProviderType.gemini:
        return 'gemini';
      case AiProviderType.localOffline:
        return 'local_offline';
      case AiProviderType.mock:
        return 'mock';
    }
  }
}

AiProviderType aiProviderTypeFromKey(String value) {
  final key = value.trim();
  for (final type in AiProviderType.values) {
    if (type.key == key) return type;
  }
  return AiProviderType.mock;
}
