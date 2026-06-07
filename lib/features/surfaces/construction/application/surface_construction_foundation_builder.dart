import '../domain/federation_visual_boundary.dart';
import '../registry/cross_surface_function_registry.dart';
import '../registry/missing_visual_registry.dart';
import '../registry/replacement_visual_registry.dart';
import '../registry/room_blueprint_registry.dart';
import '../registry/visual_asset_registry.dart';
import '../registry/visual_legacy_registry.dart';
import '../registry/visual_readiness_registry.dart';
import '../reports/surface_construction_planning_report.dart';

class SurfaceConstructionFoundationBuilder {
  const SurfaceConstructionFoundationBuilder._();

  static SurfaceConstructionPlanningReport currentFoundationReport() {
    final names = <String>[
      RoomBlueprintRegistry.client.roomId,
      RoomBlueprintRegistry.monitoring.roomId,
      RoomBlueprintRegistry.archive.roomId,
      ...VisualAssetRegistry.assets.map((asset) => asset.assetId),
      ...VisualLegacyRegistry.legacyProfiles.map((profile) => profile.assetId),
      ...ReplacementVisualRegistry.replacements.map(
        (replacement) => replacement.linkedVisual,
      ),
    ];

    final compliant = names.every(FederationVisualBoundary.allowsName);

    return SurfaceConstructionPlanningReport(
      clientRoom: RoomBlueprintRegistry.client,
      monitoringRoom: RoomBlueprintRegistry.monitoring,
      archiveRoom: RoomBlueprintRegistry.archive,
      crossSurfaceFunctions: CrossSurfaceFunctionRegistry.functions,
      visualAssets: VisualAssetRegistry.assets,
      visualLegacyProfiles: VisualLegacyRegistry.legacyProfiles,
      replacementVisuals: ReplacementVisualRegistry.replacements,
      missingVisuals: MissingVisualRegistry.markers,
      visualReadiness: VisualReadinessRegistry.current,
      complianceStatus: compliant ? 'compliant' : 'needs_review',
    );
  }
}
