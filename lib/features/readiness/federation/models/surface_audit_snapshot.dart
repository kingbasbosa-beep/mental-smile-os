import 'readiness_gap.dart';
import 'readiness_recommendation.dart';
import 'readiness_requirement.dart';
import 'readiness_score.dart';

class SurfaceAuditSnapshot {
  const SurfaceAuditSnapshot({
    required this.surfaceId,
    required this.score,
    required this.requirements,
    required this.gaps,
    required this.recommendations,
  });

  final String surfaceId;
  final ReadinessScore score;
  final List<ReadinessRequirement> requirements;
  final List<ReadinessGap> gaps;
  final List<ReadinessRecommendation> recommendations;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'surfaceId': surfaceId,
      'score': score.toMap(),
      'requirements':
          requirements.map((requirement) => requirement.toMap()).toList(),
      'gaps': gaps.map((gap) => gap.toMap()).toList(),
      'recommendations':
          recommendations.map((recommendation) => recommendation.toMap()).toList(),
    };
  }
}
