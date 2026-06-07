import '../models/federation_readiness_snapshot.dart';
import '../models/readiness_gap.dart';
import '../models/readiness_recommendation.dart';
import '../models/readiness_requirement.dart';
import '../models/readiness_score.dart';
import '../models/surface_audit_snapshot.dart';
import '../registry/launch_status.dart';
import '../registry/readiness_audit_registry.dart';
import '../registry/readiness_classification.dart';
import '../registry/readiness_gap_type_registry.dart';
import '../reports/operational_readiness_audit_report.dart';

class ReadinessAuditFoundationBuilder {
  const ReadinessAuditFoundationBuilder._();

  static FederationReadinessSnapshot currentFoundationSnapshot({
    required DateTime assessedAt,
  }) {
    final surfaces = _surfaceSnapshots(assessedAt);
    final criticalGaps = <ReadinessGap>[
      const ReadinessGap(
        gapId: ReadinessGapTypeRegistry.legacyGap,
        surface: ReadinessAuditRegistry.app,
        severity: ReadinessClassification.legacyDependent,
        description: 'App launch still requires legacy route containment.',
      ),
      const ReadinessGap(
        gapId: ReadinessGapTypeRegistry.federationGap,
        surface: ReadinessAuditRegistry.owner,
        severity: ReadinessClassification.partial,
        description: 'Owner launch requires capsule foundation.',
      ),
    ];

    return FederationReadinessSnapshot(
      overallScore: ReadinessScore(
        score: 64,
        classification: ReadinessClassification.partial,
        assessedAt: assessedAt,
      ),
      surfaces: surfaces,
      criticalGaps: criticalGaps,
      launchStatus: LaunchStatus.conditional,
    );
  }

  static OperationalReadinessAuditReport currentFoundationReport({
    required DateTime assessedAt,
  }) {
    final snapshot = currentFoundationSnapshot(assessedAt: assessedAt);
    return OperationalReadinessAuditReport(
      surfaceResults: snapshot.surfaces,
      criticalGaps: snapshot.criticalGaps,
      recommendations: <ReadinessRecommendation>[
        const ReadinessRecommendation(
          recommendationId: 'complete_owner_capsule',
          surface: ReadinessAuditRegistry.owner,
          description: 'Complete Owner Capsule Foundation before owner launch.',
          priority: 'high',
        ),
        const ReadinessRecommendation(
          recommendationId: 'isolate_legacy_routes',
          surface: ReadinessAuditRegistry.app,
          description: 'Keep ghost routes isolated before navigation rebuild.',
          priority: 'high',
        ),
        const ReadinessRecommendation(
          recommendationId: 'activate_snapshot_based_monitoring',
          surface: ReadinessAuditRegistry.monitoring,
          description: 'Launch monitoring from snapshots, not raw records.',
          priority: 'medium',
        ),
      ],
      launchStatus: snapshot.launchStatus,
    );
  }

  static List<SurfaceAuditSnapshot> _surfaceSnapshots(DateTime assessedAt) {
    return <SurfaceAuditSnapshot>[
      SurfaceAuditSnapshot(
        surfaceId: ReadinessAuditRegistry.app,
        score: ReadinessScore(
          score: 60,
          classification: ReadinessClassification.legacyDependent,
          assessedAt: assessedAt,
        ),
        requirements: const <ReadinessRequirement>[
          ReadinessRequirement(
            requirementId: 'app_contact_runtime_ready',
            surface: ReadinessAuditRegistry.app,
            description: 'Modern client contact runtime remains available.',
            priority: 'high',
          ),
        ],
        gaps: const <ReadinessGap>[
          ReadinessGap(
            gapId: ReadinessGapTypeRegistry.legacyGap,
            surface: ReadinessAuditRegistry.app,
            severity: ReadinessClassification.legacyDependent,
            description: 'Legacy route remnants still require containment.',
          ),
        ],
        recommendations: const <ReadinessRecommendation>[
          ReadinessRecommendation(
            recommendationId: 'app_ghost_route_followup',
            surface: ReadinessAuditRegistry.app,
            description: 'Use ghost route isolation before navigation rebuild.',
            priority: 'high',
          ),
        ],
      ),
      SurfaceAuditSnapshot(
        surfaceId: ReadinessAuditRegistry.web,
        score: ReadinessScore(
          score: 66,
          classification: ReadinessClassification.partial,
          assessedAt: assessedAt,
        ),
        requirements: const <ReadinessRequirement>[
          ReadinessRequirement(
            requirementId: 'web_signal_first_surfaces',
            surface: ReadinessAuditRegistry.web,
            description: 'Public web surfaces stay signal-first.',
            priority: 'medium',
          ),
        ],
        gaps: const <ReadinessGap>[],
        recommendations: const <ReadinessRecommendation>[
          ReadinessRecommendation(
            recommendationId: 'web_public_alignment',
            surface: ReadinessAuditRegistry.web,
            description: 'Audit public wording before launch.',
            priority: 'medium',
          ),
        ],
      ),
      SurfaceAuditSnapshot(
        surfaceId: ReadinessAuditRegistry.monitoring,
        score: ReadinessScore(
          score: 72,
          classification: ReadinessClassification.mostlyReady,
          assessedAt: assessedAt,
        ),
        requirements: const <ReadinessRequirement>[
          ReadinessRequirement(
            requirementId: 'monitoring_snapshot_source',
            surface: ReadinessAuditRegistry.monitoring,
            description: 'Monitoring reads snapshots and aggregates only.',
            priority: 'high',
          ),
        ],
        gaps: const <ReadinessGap>[],
        recommendations: const <ReadinessRecommendation>[
          ReadinessRecommendation(
            recommendationId: 'monitoring_storage_activation',
            surface: ReadinessAuditRegistry.monitoring,
            description: 'Prepare storage activation before UI work.',
            priority: 'medium',
          ),
        ],
      ),
      SurfaceAuditSnapshot(
        surfaceId: ReadinessAuditRegistry.owner,
        score: ReadinessScore(
          score: 54,
          classification: ReadinessClassification.partial,
          assessedAt: assessedAt,
        ),
        requirements: const <ReadinessRequirement>[
          ReadinessRequirement(
            requirementId: 'owner_capsule_required',
            surface: ReadinessAuditRegistry.owner,
            description: 'Owner launch requires sovereign capsule foundation.',
            priority: 'high',
          ),
        ],
        gaps: const <ReadinessGap>[
          ReadinessGap(
            gapId: ReadinessGapTypeRegistry.federationGap,
            surface: ReadinessAuditRegistry.owner,
            severity: ReadinessClassification.partial,
            description: 'Owner Capsule Foundation is not present yet.',
          ),
        ],
        recommendations: const <ReadinessRecommendation>[
          ReadinessRecommendation(
            recommendationId: 'owner_capsule_next',
            surface: ReadinessAuditRegistry.owner,
            description: 'Build Owner Capsule Foundation next.',
            priority: 'high',
          ),
        ],
      ),
      SurfaceAuditSnapshot(
        surfaceId: ReadinessAuditRegistry.archive,
        score: ReadinessScore(
          score: 74,
          classification: ReadinessClassification.mostlyReady,
          assessedAt: assessedAt,
        ),
        requirements: const <ReadinessRequirement>[
          ReadinessRequirement(
            requirementId: 'archive_export_packages',
            surface: ReadinessAuditRegistry.archive,
            description: 'Archive export packages remain payload-free.',
            priority: 'high',
          ),
        ],
        gaps: const <ReadinessGap>[],
        recommendations: const <ReadinessRecommendation>[
          ReadinessRecommendation(
            recommendationId: 'archive_runtime_later',
            surface: ReadinessAuditRegistry.archive,
            description: 'Keep archive runtime behind launch roadmap.',
            priority: 'medium',
          ),
        ],
      ),
      SurfaceAuditSnapshot(
        surfaceId: ReadinessAuditRegistry.commercial,
        score: ReadinessScore(
          score: 68,
          classification: ReadinessClassification.partial,
          assessedAt: assessedAt,
        ),
        requirements: const <ReadinessRequirement>[
          ReadinessRequirement(
            requirementId: 'commercial_value_layer',
            surface: ReadinessAuditRegistry.commercial,
            description: 'Commercial value layer uses reputation and tool meter.',
            priority: 'medium',
          ),
        ],
        gaps: const <ReadinessGap>[],
        recommendations: const <ReadinessRecommendation>[
          ReadinessRecommendation(
            recommendationId: 'commercial_room_after_owner',
            surface: ReadinessAuditRegistry.commercial,
            description: 'Delay commercial room UI until owner capsule exists.',
            priority: 'medium',
          ),
        ],
      ),
      SurfaceAuditSnapshot(
        surfaceId: ReadinessAuditRegistry.ecosystem,
        score: ReadinessScore(
          score: 58,
          classification: ReadinessClassification.partial,
          assessedAt: assessedAt,
        ),
        requirements: const <ReadinessRequirement>[
          ReadinessRequirement(
            requirementId: 'ecosystem_registry_alignment',
            surface: ReadinessAuditRegistry.ecosystem,
            description: 'Ecosystem launch needs registry alignment.',
            priority: 'medium',
          ),
        ],
        gaps: const <ReadinessGap>[
          ReadinessGap(
            gapId: ReadinessGapTypeRegistry.federationGap,
            surface: ReadinessAuditRegistry.ecosystem,
            severity: ReadinessClassification.partial,
            description: 'Ecosystem launch map is still foundation-only.',
          ),
        ],
        recommendations: const <ReadinessRecommendation>[
          ReadinessRecommendation(
            recommendationId: 'ecosystem_defer_launch',
            surface: ReadinessAuditRegistry.ecosystem,
            description: 'Defer ecosystem launch until core surfaces stabilize.',
            priority: 'low',
          ),
        ],
      ),
    ];
  }
}
