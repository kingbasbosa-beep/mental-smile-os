import '../models/archive_observatory_models.dart';
import '../models/observatory_dependency.dart';
import '../models/observatory_readiness_alignment.dart';
import '../models/observatory_surface.dart';
import '../models/storage_activation_models.dart';
import '../models/tool_meter_observatory_models.dart';

class OperationalObservatoryReport {
  const OperationalObservatoryReport({
    required this.surfaces,
    required this.dependencies,
    required this.storageReadiness,
    required this.toolMeterAlignment,
    required this.archiveAlignment,
    required this.readinessAlignment,
    required this.complianceStatus,
  });

  final List<ObservatorySurface> surfaces;
  final List<ObservatoryDependency> dependencies;
  final StorageActivationReadiness storageReadiness;
  final ToolMeterObservatoryAlignment toolMeterAlignment;
  final ArchiveObservatoryAlignment archiveAlignment;
  final ObservatoryReadinessAlignment readinessAlignment;
  final String complianceStatus;
}
