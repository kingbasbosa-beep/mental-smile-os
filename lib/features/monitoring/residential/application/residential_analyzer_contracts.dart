import '../aggregates/residential_signal_aggregate.dart';
import '../models/residential_monitoring_report.dart';
import '../models/residential_monitoring_snapshot.dart';

abstract class ResidentialSignalAnalyzer {
  ResidentialMonitoringSnapshot buildSnapshot(
    Iterable<ResidentialSignalAggregate> aggregates,
  );
}

abstract class ResidentialTrendAnalyzer {
  List<ResidentialTrend> analyzeTrends(
    ResidentialMonitoringSnapshot snapshot,
  );
}

abstract class ResidentialGapAnalyzer {
  List<ResidentialOpportunity> analyzeGaps(
    ResidentialMonitoringSnapshot snapshot,
  );
}

abstract class ResidentialRecommendationAnalyzer {
  List<ResidentialRecommendationDraft> draftRecommendations(
    ResidentialMonitoringSnapshot snapshot,
  );
}
