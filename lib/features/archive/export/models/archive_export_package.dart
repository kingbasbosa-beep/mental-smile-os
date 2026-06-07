import 'archive_export_metadata.dart';
import 'archive_export_object_reference.dart';

class ArchiveExportPackage {
  const ArchiveExportPackage({
    required this.packageId,
    required this.packageType,
    required this.packageCode,
    required this.createdAt,
    required this.version,
    required this.archiveEligibility,
    required this.retentionClass,
    required this.classification,
    required this.includedObjects,
    required this.metadata,
  });

  final String packageId;
  final String packageType;
  final String packageCode;
  final DateTime createdAt;
  final String version;
  final String archiveEligibility;
  final String retentionClass;
  final String classification;
  final List<ArchiveExportObjectReference> includedObjects;
  final ArchiveExportMetadata metadata;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'packageId': packageId,
      'packageType': packageType,
      'packageCode': packageCode,
      'createdAt': createdAt.toIso8601String(),
      'version': version,
      'archiveEligibility': archiveEligibility,
      'retentionClass': retentionClass,
      'classification': classification,
      'includedObjects':
          includedObjects.map((reference) => reference.toMap()).toList(),
      'metadata': metadata.toMap(),
    };
  }
}
