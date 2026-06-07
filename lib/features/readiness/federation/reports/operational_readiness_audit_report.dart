import '../models/readiness_gap.dart';
import '../models/readiness_recommendation.dart';
import '../models/surface_audit_snapshot.dart';

class OperationalReadinessAuditReport {
  const OperationalReadinessAuditReport({
    required this.surfaceResults,
    required this.criticalGaps,
    required this.recommendations,
    required this.launchStatus,
  });

  final List<SurfaceAuditSnapshot> surfaceResults;
  final List<ReadinessGap> criticalGaps;
  final List<ReadinessRecommendation> recommendations;
  final String launchStatus;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'surfaceResults':
          surfaceResults.map((surface) => surface.toMap()).toList(),
      'criticalGaps': criticalGaps.map((gap) => gap.toMap()).toList(),
      'recommendations':
          recommendations.map((recommendation) => recommendation.toMap()).toList(),
      'launchStatus': launchStatus,
    };
  }
}
