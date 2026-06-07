import '../models/archive_observatory_models.dart';
import '../models/monitoring_room_models.dart';
import '../models/observatory_dependency.dart';
import '../models/observatory_health.dart';
import '../models/observatory_readiness.dart';
import '../models/observatory_readiness_alignment.dart';
import '../models/observatory_snapshot.dart';
import '../models/observatory_surface.dart';
import '../models/storage_activation_models.dart';
import '../models/tool_meter_observatory_models.dart';
import '../reports/operational_observatory_report.dart';

class OperationalObservatoryFoundationBuilder {
  const OperationalObservatoryFoundationBuilder._();

  static ObservatorySnapshot snapshot({required DateTime createdAt}) {
    return ObservatorySnapshot(
      snapshotId: 'operational_observatory_foundation',
      createdAt: createdAt,
      surfaces: const <String>[
        'residential_monitoring',
        'commercial_monitoring',
        'operational_monitoring',
        'tool_meter',
        'archive',
        'readiness',
      ],
      healthStatus: 'foundation_ready',
      readinessStatus: 'ready_for_monitoring_room_foundation',
    );
  }

  static ObservatoryHealth health() {
    return const ObservatoryHealth(
      healthId: 'observatory_health_foundation',
      status: 'foundation_ready',
      warnings: <String>[
        'storage_activation_is_map_only',
        'monitoring_room_has_no_ui',
      ],
      blockers: <String>[],
    );
  }

  static ObservatoryReadiness readiness() {
    return const ObservatoryReadiness(
      readinessId: 'observatory_readiness_foundation',
      status: 'ready_for_bundle_c',
      requiredBeforeUi: true,
      requiredActions: <String>[
        'keep_consumption_snapshot_based',
        'avoid_raw_legacy_data',
      ],
    );
  }

  static StorageActivationReadiness storageReadiness() {
    return const StorageActivationReadiness(
      status: 'activation_map_ready_no_storage_runtime',
      dependencies: <StorageActivationDependency>[
        StorageActivationDependency(
          dependencyId: 'snapshot_storage_contracts',
          description: 'Snapshot storage contracts exist before activation.',
          required: true,
        ),
        StorageActivationDependency(
          dependencyId: 'archive_export_foundation',
          description: 'Archive export packages define what can be retained.',
          required: true,
        ),
      ],
      notes: 'Storage activation is a map, not implementation.',
    );
  }

  static MonitoringRoomProfile monitoringRoomProfile() {
    return const MonitoringRoomProfile(
      roomId: 'monitoring_room_foundation',
      purpose: 'Observe aggregate federation health without controlling users.',
      sections: <String>[
        'residential',
        'commercial',
        'operational',
        'tool_meter',
        'archive',
        'readiness',
      ],
      readinessStatus: 'foundation_ready_no_ui',
    );
  }

  static OperationalObservatoryReport report() {
    return OperationalObservatoryReport(
      surfaces: const <ObservatorySurface>[
        ObservatorySurface(
          surfaceId: 'residential_monitoring',
          surfaceType: 'monitoring',
          department: 'residential',
          observable: true,
          notes: 'Aggregate residential observation only.',
        ),
        ObservatorySurface(
          surfaceId: 'commercial_monitoring',
          surfaceType: 'monitoring',
          department: 'commercial',
          observable: true,
          notes: 'Demand, supply, gap, and opportunity observation.',
        ),
        ObservatorySurface(
          surfaceId: 'tool_meter',
          surfaceType: 'value_layer',
          department: 'commercial',
          observable: true,
          notes: 'Usage, adoption, trust, and impact language.',
        ),
        ObservatorySurface(
          surfaceId: 'archive',
          surfaceType: 'memory',
          department: 'archive',
          observable: true,
          notes: 'Archive packages and retention visibility.',
        ),
        ObservatorySurface(
          surfaceId: 'readiness',
          surfaceType: 'governance',
          department: 'readiness',
          observable: true,
          notes: 'Launch readiness and roadmap status.',
        ),
      ],
      dependencies: const <ObservatoryDependency>[
        ObservatoryDependency(
          dependencyId: 'monitoring_to_storage',
          source: 'monitoring',
          target: 'storage',
          dependencyType: 'federation_dependency',
        ),
        ObservatoryDependency(
          dependencyId: 'tool_meter_to_reports',
          source: 'tool_meter',
          target: 'reports',
          dependencyType: 'federation_dependency',
        ),
        ObservatoryDependency(
          dependencyId: 'archive_to_observatory',
          source: 'archive',
          target: 'observatory',
          dependencyType: 'archive_alignment',
        ),
      ],
      storageReadiness: storageReadiness(),
      toolMeterAlignment: const ToolMeterObservatoryAlignment(
        toolMeterReference: 'tool_meter_foundation',
        monitoringReference: 'commercial_monitoring',
        reportReference: 'tool_meter_report',
        readinessReference: 'tool_meter_ready_for_observatory',
      ),
      archiveAlignment: const ArchiveObservatoryAlignment(
        archiveReference: 'archive_export_foundation',
        monitoringReference: 'monitoring_storage_foundation',
        reportReference: 'federation_report_schema',
        observatoryReference: 'operational_observatory_foundation',
      ),
      readinessAlignment: const ObservatoryReadinessAlignment(
        readinessReference: 'operational_readiness_audit',
        roadmapReference: 'launch_roadmap_foundation',
        monitoringReference: 'monitoring_foundations',
        toolMeterReference: 'tool_meter_foundation',
        archiveReference: 'archive_export_foundation',
      ),
      complianceStatus: 'observatory_foundation_ready_no_runtime',
    );
  }
}
