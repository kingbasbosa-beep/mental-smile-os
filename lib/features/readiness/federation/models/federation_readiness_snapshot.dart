import 'readiness_gap.dart';
import 'readiness_score.dart';
import 'surface_audit_snapshot.dart';

class FederationReadinessSnapshot {
  const FederationReadinessSnapshot({
    required this.overallScore,
    required this.surfaces,
    required this.criticalGaps,
    required this.launchStatus,
  });

  final ReadinessScore overallScore;
  final List<SurfaceAuditSnapshot> surfaces;
  final List<ReadinessGap> criticalGaps;
  final String launchStatus;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'overallScore': overallScore.toMap(),
      'surfaces': surfaces.map((surface) => surface.toMap()).toList(),
      'criticalGaps': criticalGaps.map((gap) => gap.toMap()).toList(),
      'launchStatus': launchStatus,
    };
  }
}
