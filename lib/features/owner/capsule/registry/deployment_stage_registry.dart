class DeploymentStageRegistry {
  const DeploymentStageRegistry._();

  static const String development = 'development';
  static const String staging = 'staging';
  static const String federationReady = 'federation_ready';
  static const String production = 'production';

  static const Set<String> values = <String>{
    development,
    staging,
    federationReady,
    production,
  };
}
