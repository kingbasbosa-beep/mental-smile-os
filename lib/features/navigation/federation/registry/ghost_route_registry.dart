import '../models/federation_route_metadata.dart';

class GhostRouteRegistry {
  const GhostRouteRegistry._();

  static const String legacyAdmin = 'legacy_admin';

  static const Set<String> legacyCategories = <String>{
    legacyAdmin,
  };

  static const List<FederationRouteMetadata> ghostRoutes =
      <FederationRouteMetadata>[
  ];
}
