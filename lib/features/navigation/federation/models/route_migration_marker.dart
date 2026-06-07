class RouteMigrationMarker {
  const RouteMigrationMarker({
    required this.legacySource,
    required this.federationReplacement,
    required this.migrationStatus,
  });

  final String legacySource;
  final String federationReplacement;
  final String migrationStatus;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'legacySource': legacySource,
      'federationReplacement': federationReplacement,
      'migrationStatus': migrationStatus,
    };
  }
}
