import '../models/archive_room_blueprint.dart';
import '../models/client_room_blueprint.dart';
import '../models/cross_surface_function_models.dart';
import '../models/monitoring_room_blueprint.dart';
import '../models/replacement_visual_models.dart';
import '../models/visual_legacy_models.dart';

abstract class RoomConstructionBlueprintBuilder {
  ClientRoomBlueprint buildClientRoomBlueprint();

  MonitoringRoomBlueprint buildMonitoringRoomBlueprint();

  ArchiveRoomBlueprint buildArchiveRoomBlueprint();
}

abstract class CrossSurfaceFunctionSweep {
  CrossSurfaceFunctionAudit buildFunctionAudit();
}

abstract class VisualLegacySweep {
  VisualLegacyAudit buildVisualLegacyAudit();

  ReplacementVisualPlan buildReplacementPlan();
}
