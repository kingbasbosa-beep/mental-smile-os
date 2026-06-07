class ReputationTargetRegistry {
  const ReputationTargetRegistry._();

  static const String provider = 'provider';
  static const String center = 'center';
  static const String tool = 'tool';
  static const String libraryContent = 'library_content';
  static const String externalApp = 'external_app';
  static const String campaign = 'campaign';
  static const String knowledgeResource = 'knowledge_resource';

  static const Set<String> values = <String>{
    provider,
    center,
    tool,
    libraryContent,
    externalApp,
    campaign,
    knowledgeResource,
  };
}
