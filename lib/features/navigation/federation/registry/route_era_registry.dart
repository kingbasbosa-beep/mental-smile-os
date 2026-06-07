class RouteEraRegistry {
  const RouteEraRegistry._();

  static const String legacyEra = 'legacy_era';
  static const String stabilizationEra = 'stabilization_era';
  static const String webFreezeEra = 'web_freeze_era';
  static const String appFreezeEra = 'app_freeze_era';
  static const String federationEra = 'federation_era';

  static const Set<String> values = <String>{
    legacyEra,
    stabilizationEra,
    webFreezeEra,
    appFreezeEra,
    federationEra,
  };
}
