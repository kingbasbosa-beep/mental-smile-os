import '../models/federation_route_metadata.dart';
import '../models/route_classification.dart';
import 'route_era_registry.dart';

class FederationRouteRegistry {
  const FederationRouteRegistry._();

  static const String monitoring = 'monitoring';
  static const String archive = 'archive';
  static const String commercial = 'commercial';
  static const String owner = 'owner';
  static const String guidance = 'guidance';
  static const String reputation = 'reputation';
  static const String toolMeter = 'tool_meter';

  static const Set<String> federationDepartments = <String>{
    monitoring,
    archive,
    commercial,
    owner,
    guidance,
    reputation,
    toolMeter,
  };

  static const List<FederationRouteMetadata> federationRoutes =
      <FederationRouteMetadata>[
    FederationRouteMetadata(
      routeId: 'signal_control_room',
      routeName: '/s/capital/signal-control-room',
      classification: RouteClassification.monitoring,
      department: monitoring,
      createdEra: RouteEraRegistry.federationEra,
      notes: 'Signal observability surface; no lifecycle authority.',
    ),
    FederationRouteMetadata(
      routeId: 'strategic_archive',
      routeName: '/s/owner/strategic-archive',
      classification: RouteClassification.archive,
      department: archive,
      createdEra: RouteEraRegistry.federationEra,
      notes: 'Strategic archive surface for sovereign memory.',
    ),
    FederationRouteMetadata(
      routeId: 'city_marketplace',
      routeName: '/s/city/marketplace',
      classification: RouteClassification.commercial,
      department: commercial,
      createdEra: RouteEraRegistry.federationEra,
      notes: 'Commercial discovery route without lifecycle ownership.',
    ),
    FederationRouteMetadata(
      routeId: 'owner_room',
      routeName: '/s/owner/room',
      classification: RouteClassification.owner,
      department: owner,
      createdEra: RouteEraRegistry.federationEra,
      notes: 'Sovereign owner route, not an operations control route.',
    ),
    FederationRouteMetadata(
      routeId: 'public_reputation_foundation',
      routeName: 'foundation:public_reputation',
      classification: RouteClassification.federation,
      department: reputation,
      createdEra: RouteEraRegistry.federationEra,
      notes: 'Foundation classification for future public reputation routes.',
    ),
    FederationRouteMetadata(
      routeId: 'tool_meter_foundation',
      routeName: 'foundation:tool_meter',
      classification: RouteClassification.federation,
      department: toolMeter,
      createdEra: RouteEraRegistry.federationEra,
      notes: 'Foundation classification for future tool meter routes.',
    ),
    FederationRouteMetadata(
      routeId: 'guidance_foundation',
      routeName: 'foundation:guidance',
      classification: RouteClassification.federation,
      department: guidance,
      createdEra: RouteEraRegistry.federationEra,
      notes: 'Foundation classification for future guidance routes.',
    ),
  ];
}
