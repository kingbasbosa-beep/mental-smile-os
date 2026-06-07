import 'adoption_aggregate.dart';
import 'impact_aggregate.dart';
import 'trust_aggregate.dart';
import 'usage_aggregate.dart';

class ToolMeterScorecard {
  const ToolMeterScorecard({
    required this.usage,
    required this.adoption,
    required this.trust,
    required this.impact,
    required this.overallScore,
  });

  final UsageAggregate usage;
  final AdoptionAggregate adoption;
  final TrustAggregate trust;
  final ImpactAggregate impact;
  final num overallScore;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'usage': usage.toMap(),
      'adoption': adoption.toMap(),
      'trust': trust.toMap(),
      'impact': impact.toMap(),
      'overallScore': overallScore,
    };
  }
}
