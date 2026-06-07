import '../models/operational_work_card.dart';
import '../models/operational_monitoring_snapshot.dart';

class OperationalMonitoringReport {
  const OperationalMonitoringReport({
    required this.departmentSummaries,
    required this.issues,
    required this.complaints,
    required this.workCards,
    required this.delays,
    required this.risks,
    required this.recommendations,
    required this.archiveCode,
    required this.reportPrefix,
    required this.departmentId,
    required this.period,
    required this.createdAt,
  });

  final List<DepartmentOperationalSummary> departmentSummaries;
  final List<OperationalIssueSummary> issues;
  final List<OperationalComplaintSummary> complaints;
  final List<OperationalWorkCard> workCards;
  final List<OperationalDelaySummary> delays;
  final List<OperationalRiskSummary> risks;
  final List<OperationalRecommendationDraft> recommendations;
  final String archiveCode;
  final String reportPrefix;
  final String departmentId;
  final String period;
  final DateTime createdAt;
}

class OperationalIssueSummary {
  const OperationalIssueSummary({
    required this.issueId,
    required this.summary,
    required this.status,
  });

  final String issueId;
  final String summary;
  final String status;
}

class OperationalComplaintSummary {
  const OperationalComplaintSummary({
    required this.complaintId,
    required this.summary,
    required this.status,
  });

  final String complaintId;
  final String summary;
  final String status;
}

class OperationalDelaySummary {
  const OperationalDelaySummary({
    required this.delayId,
    required this.departmentId,
    required this.summary,
  });

  final String delayId;
  final String departmentId;
  final String summary;
}

class OperationalRiskSummary {
  const OperationalRiskSummary({
    required this.riskId,
    required this.departmentId,
    required this.summary,
  });

  final String riskId;
  final String departmentId;
  final String summary;
}

class OperationalRecommendationDraft {
  const OperationalRecommendationDraft({
    required this.recommendationId,
    required this.departmentId,
    required this.summary,
  });

  final String recommendationId;
  final String departmentId;
  final String summary;
}
