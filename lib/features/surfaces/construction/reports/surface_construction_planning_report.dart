import '../models/archive_room_blueprint.dart';
import '../models/client_room_blueprint.dart';
import '../models/cross_surface_function_models.dart';
import '../models/federation_visual_readiness.dart';
import '../models/missing_visual_models.dart';
import '../models/monitoring_room_blueprint.dart';
import '../models/replacement_visual_models.dart';
import '../models/visual_asset_models.dart';
import '../models/visual_legacy_models.dart';

class SurfaceConstructionPlanningReport {
  const SurfaceConstructionPlanningReport({
    required this.clientRoom,
    required this.monitoringRoom,
    required this.archiveRoom,
    required this.crossSurfaceFunctions,
    required this.visualAssets,
    required this.visualLegacyProfiles,
    required this.replacementVisuals,
    required this.missingVisuals,
    required this.visualReadiness,
    required this.complianceStatus,
  });

  final ClientRoomBlueprint clientRoom;
  final MonitoringRoomBlueprint monitoringRoom;
  final ArchiveRoomBlueprint archiveRoom;
  final List<CrossSurfaceFunctionProfile> crossSurfaceFunctions;
  final List<VisualAssetProfile> visualAssets;
  final List<VisualLegacyProfile> visualLegacyProfiles;
  final List<ReplacementVisualProfile> replacementVisuals;
  final List<MissingVisualMarker> missingVisuals;
  final FederationVisualReadiness visualReadiness;
  final String complianceStatus;
}
