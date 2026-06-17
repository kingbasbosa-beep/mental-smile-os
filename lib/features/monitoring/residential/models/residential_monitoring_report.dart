import '../aggregates/residential_signal_aggregate.dart';

class ResidentialMonitoringReport {
  const ResidentialMonitoringReport({
    required this.aggregates,
    required this.trends,
    required this.opportunities,
    required this.recommendations,
    required this.createdAt,
  });

  final List<ResidentialSignalAggregate> aggregates;
  final List<ResidentialTrend> trends;
  final List<ResidentialOpportunity> opportunities;
  final List<ResidentialRecommendationDraft> recommendations;
  final DateTime createdAt;
}

class ResidentialTrend {
  const ResidentialTrend({
    required this.trendId,
    required this.aggregateKey,
    required this.summary,
  });

  final String trendId;
  final String aggregateKey;
  final String summary;
}

class ResidentialOpportunity {
  const ResidentialOpportunity({
    required this.opportunityId,
    required this.aggregateKey,
    required this.summary,
  });

  final String opportunityId;
  final String aggregateKey;
  final String summary;
}

class ResidentialRecommendationDraft {
  const ResidentialRecommendationDraft({
    required this.recommendationId,
    required this.aggregateKey,
    required this.summary,
  });

  final String recommendationId;
  final String aggregateKey;
  final String summary;
}
