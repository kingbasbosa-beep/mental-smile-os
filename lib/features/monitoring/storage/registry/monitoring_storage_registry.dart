import '../models/archive_eligibility.dart';
import '../models/retention_class.dart';
import 'storage_object_type_registry.dart';

class MonitoringStorageRegistry {
  const MonitoringStorageRegistry._();

  static const Map<String, MonitoringStorageDescriptor> descriptors =
      <String, MonitoringStorageDescriptor>{
    StorageObjectTypeRegistry.residentialSnapshot: MonitoringStorageDescriptor(
      objectType: StorageObjectTypeRegistry.residentialSnapshot,
      retentionClass: RetentionClass.operational,
      archiveEligibility: ArchiveEligibility.eligible,
    ),
    StorageObjectTypeRegistry.commercialSnapshot: MonitoringStorageDescriptor(
      objectType: StorageObjectTypeRegistry.commercialSnapshot,
      retentionClass: RetentionClass.operational,
      archiveEligibility: ArchiveEligibility.eligible,
    ),
    StorageObjectTypeRegistry.operationalSnapshot: MonitoringStorageDescriptor(
      objectType: StorageObjectTypeRegistry.operationalSnapshot,
      retentionClass: RetentionClass.operational,
      archiveEligibility: ArchiveEligibility.eligible,
    ),
    StorageObjectTypeRegistry.residentialReport: MonitoringStorageDescriptor(
      objectType: StorageObjectTypeRegistry.residentialReport,
      retentionClass: RetentionClass.annual,
      archiveEligibility: ArchiveEligibility.restricted,
    ),
    StorageObjectTypeRegistry.commercialReport: MonitoringStorageDescriptor(
      objectType: StorageObjectTypeRegistry.commercialReport,
      retentionClass: RetentionClass.annual,
      archiveEligibility: ArchiveEligibility.restricted,
    ),
    StorageObjectTypeRegistry.operationalReport: MonitoringStorageDescriptor(
      objectType: StorageObjectTypeRegistry.operationalReport,
      retentionClass: RetentionClass.annual,
      archiveEligibility: ArchiveEligibility.restricted,
    ),
    StorageObjectTypeRegistry.strategicSummary: MonitoringStorageDescriptor(
      objectType: StorageObjectTypeRegistry.strategicSummary,
      retentionClass: RetentionClass.historical,
      archiveEligibility: ArchiveEligibility.ownerOnly,
    ),
    StorageObjectTypeRegistry.constitutionalReport:
        MonitoringStorageDescriptor(
      objectType: StorageObjectTypeRegistry.constitutionalReport,
      retentionClass: RetentionClass.constitutional,
      archiveEligibility: ArchiveEligibility.constitutionalOnly,
    ),
  };

  static MonitoringStorageDescriptor? descriptorFor(String objectType) {
    return descriptors[objectType.trim()];
  }
}

class MonitoringStorageDescriptor {
  const MonitoringStorageDescriptor({
    required this.objectType,
    required this.retentionClass,
    required this.archiveEligibility,
  });

  final String objectType;
  final String retentionClass;
  final String archiveEligibility;
}
