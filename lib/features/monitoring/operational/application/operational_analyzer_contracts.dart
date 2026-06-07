import '../models/operational_monitoring_snapshot.dart';
import '../reports/operational_monitoring_report.dart';

abstract class DepartmentPerformanceAnalyzer {
  List<DepartmentOperationalSummary> analyzeDepartmentPerformance(
    OperationalMonitoringSnapshot snapshot,
  );
}

abstract class OperationalDelayAnalyzer {
  List<OperationalDelaySummary> analyzeDelays(
    OperationalMonitoringSnapshot snapshot,
  );
}

abstract class OperationalBottleneckAnalyzer {
  List<OperationalRiskSummary> analyzeBottlenecks(
    OperationalMonitoringSnapshot snapshot,
  );
}

abstract class OperationalRiskAnalyzer {
  List<OperationalRiskSummary> analyzeRisks(
    OperationalMonitoringSnapshot snapshot,
  );
}

abstract class OperationalRecommendationAnalyzer {
  List<OperationalRecommendationDraft> draftRecommendations(
    OperationalMonitoringSnapshot snapshot,
  );
}
