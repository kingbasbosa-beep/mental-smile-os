import '../domain/archive_packaging_policy.dart';
import '../models/archive_export_readiness_snapshot.dart';
import '../registry/archive_export_registry.dart';

class ArchiveExportReadinessBuilder {
  const ArchiveExportReadinessBuilder._();

  static ArchiveExportReadinessSnapshot currentFoundationSnapshot() {
    final supportedObjects = ArchiveExportRegistry.supportedObjectTypes
        .where(ArchivePackagingPolicy.canPackageObjectType)
        .toSet();

    return ArchiveExportReadinessSnapshot(
      supportedPackages: ArchiveExportRegistry.packageTypes,
      supportedObjects: supportedObjects,
      unsupportedObjects: ArchivePackagingPolicy.forbiddenObjectTypes,
      complianceStatus: 'foundation_ready_no_runtime_export',
    );
  }
}
