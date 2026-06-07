import '../analysis/opportunity_intelligence_models.dart';
import '../models/commercial_monitoring_snapshot.dart';
import '../reports/commercial_intelligence_report.dart';

abstract class SupplyAnalyzer {
  List<Object> analyzeSupply(CommercialMonitoringSnapshot snapshot);
}

abstract class DemandAnalyzer {
  List<Object> analyzeDemand(CommercialMonitoringSnapshot snapshot);
}

abstract class GapAnalyzer {
  List<DemandGap> analyzeGaps(CommercialMonitoringSnapshot snapshot);
}

abstract class OpportunityAnalyzer {
  List<MarketOpportunity> analyzeOpportunities(
    CommercialMonitoringSnapshot snapshot,
  );
}

abstract class TrendAnalyzer {
  List<EmergingNeed> analyzeTrends(CommercialMonitoringSnapshot snapshot);
}

abstract class CommercialRecommendationAnalyzer {
  List<CommercialRecommendationDraft> draftRecommendations(
    CommercialMonitoringSnapshot snapshot,
  );
}
