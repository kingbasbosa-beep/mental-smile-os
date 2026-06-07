class MeteredAssetRegistry {
  const MeteredAssetRegistry._();

  static const String tool = 'tool';
  static const String service = 'service';
  static const String knowledgeResource = 'knowledge_resource';
  static const String libraryContent = 'library_content';
  static const String externalApp = 'external_app';
  static const String campaign = 'campaign';
  static const String providerResource = 'provider_resource';
  static const String centerResource = 'center_resource';

  static const Set<String> values = <String>{
    tool,
    service,
    knowledgeResource,
    libraryContent,
    externalApp,
    campaign,
    providerResource,
    centerResource,
  };
}
