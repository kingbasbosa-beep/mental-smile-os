class OperationalAreaRegistry {
  const OperationalAreaRegistry._();

  static const String residential = 'residential';
  static const String commercial = 'commercial';
  static const String monitoring = 'monitoring';
  static const String archive = 'archive';
  static const String owner = 'owner';
  static const String ecosystem = 'ecosystem';

  static const Set<String> values = <String>{
    residential,
    commercial,
    monitoring,
    archive,
    owner,
    ecosystem,
  };
}
