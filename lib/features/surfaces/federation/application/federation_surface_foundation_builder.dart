import '../models/federation_surface_profile.dart';
import '../models/runtime_surface_maps.dart';
import '../registry/control_room_legacy_registry.dart';
import '../registry/cross_surface_reference_registry.dart';
import '../registry/federation_surface_registry.dart';
import '../registry/ghost_route_classification_registry.dart';
import '../registry/legacy_navigation_registry.dart';
import '../reports/federation_surface_audit_report.dart';

class FederationSurfaceFoundationBuilder {
  const FederationSurfaceFoundationBuilder._();

  static List<FederationSurfaceProfile> surfaces() {
    return const <FederationSurfaceProfile>[
      FederationSurfaceProfile(
        surfaceId: FederationSurfaceRegistry.client,
        surfaceType: 'runtime_surface',
        displayName: 'Client Surface',
        exists: true,
        visible: true,
        planned: true,
      ),
      FederationSurfaceProfile(
        surfaceId: FederationSurfaceRegistry.provider,
        surfaceType: 'runtime_surface',
        displayName: 'Provider Surface',
        exists: true,
        visible: true,
        planned: true,
      ),
      FederationSurfaceProfile(
        surfaceId: FederationSurfaceRegistry.center,
        surfaceType: 'runtime_surface',
        displayName: 'Center Surface',
        exists: true,
        visible: true,
        planned: true,
      ),
      FederationSurfaceProfile(
        surfaceId: FederationSurfaceRegistry.monitoring,
        surfaceType: 'observatory_surface',
        displayName: 'Monitoring Surface',
        exists: true,
        visible: false,
        planned: true,
      ),
      FederationSurfaceProfile(
        surfaceId: FederationSurfaceRegistry.archive,
        surfaceType: 'memory_surface',
        displayName: 'Archive Surface',
        exists: true,
        visible: false,
        planned: true,
      ),
    ];
  }

  static RuntimeSurfaceMap surfaceMap() {
    return const RuntimeSurfaceMap(
      mapId: 'federation_runtime_surface_map',
      surfaces: FederationSurfaceRegistry.values,
      notes: 'Foundation map only; no runtime route mutation.',
    );
  }

  static FederationSurfaceAuditReport auditReport() {
    return const FederationSurfaceAuditReport(
      legacyNavigationEntries: LegacyNavigationRegistry.knownEntries,
      controlRoomReferences: ControlRoomLegacyRegistry.references,
      crossSurfaceReferences: CrossSurfaceReferenceRegistry.references,
      ghostRoutes: GhostRouteRegistry.routes,
      complianceStatus: 'surface_foundation_ready_observe_before_remove',
    );
  }
}
