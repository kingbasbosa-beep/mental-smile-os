import '../models/control_room_legacy_models.dart';
import '../models/cross_surface_reference_models.dart';
import '../models/ghost_route_models.dart';
import '../models/legacy_navigation_models.dart';

class FederationSurfaceAuditReport {
  const FederationSurfaceAuditReport({
    required this.legacyNavigationEntries,
    required this.controlRoomReferences,
    required this.crossSurfaceReferences,
    required this.ghostRoutes,
    required this.complianceStatus,
  });

  final List<LegacyNavigationEntry> legacyNavigationEntries;
  final List<ControlRoomLegacyReference> controlRoomReferences;
  final List<CrossSurfaceReference> crossSurfaceReferences;
  final List<GhostRouteAuditProfile> ghostRoutes;
  final String complianceStatus;
}
