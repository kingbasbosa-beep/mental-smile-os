class LaunchSurfaceRegistry {
  const LaunchSurfaceRegistry._();

  static const String app = 'app';
  static const String web = 'web';
  static const String monitoring = 'monitoring';
  static const String owner = 'owner';
  static const String archive = 'archive';
  static const String commercial = 'commercial';

  static const Set<String> values = <String>{
    app,
    web,
    monitoring,
    owner,
    archive,
    commercial,
  };
}
