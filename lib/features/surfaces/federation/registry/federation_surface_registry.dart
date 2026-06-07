class FederationSurfaceRegistry {
  const FederationSurfaceRegistry._();

  static const String client = 'client';
  static const String provider = 'provider';
  static const String center = 'center';
  static const String monitoring = 'monitoring';
  static const String archive = 'archive';
  static const String commercial = 'commercial';
  static const String owner = 'owner';

  static const Set<String> values = <String>{
    client,
    provider,
    center,
    monitoring,
    archive,
    commercial,
    owner,
  };
}
