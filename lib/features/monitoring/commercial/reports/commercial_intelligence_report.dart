import '../aggregates/commercial_signal_aggregate.dart';
import '../analysis/opportunity_intelligence_models.dart';

class CommercialIntelligenceReport {
  const CommercialIntelligenceReport({
    required this.demand,
    required this.supply,
    required this.gaps,
    required this.opportunities,
    required this.recommendations,
    required this.createdAt,
  });

  final List<CommercialSignalAggregate> demand;
  final List<CommercialSignalAggregate> supply;
  final List<DemandGap> gaps;
  final List<MarketOpportunity> opportunities;
  final List<CommercialRecommendationDraft> recommendations;
  final DateTime createdAt;
}

class CommercialRecommendationDraft {
  const CommercialRecommendationDraft({
    required this.recommendationId,
    required this.sourceOpportunity,
    required this.summary,
  });

  final String recommendationId;
  final String sourceOpportunity;
  final String summary;
}
