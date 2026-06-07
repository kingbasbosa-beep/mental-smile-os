import '../aggregates/operational_aggregates.dart';

class OperationalMonitoringSnapshot {
  const OperationalMonitoringSnapshot({
    required this.timestamp,
    required this.departmentSummaries,
    required this.workCardSummary,
    required this.issueSummary,
    required this.complaintSummary,
    required this.reportActivitySummary,
    required this.performanceSummary,
    required this.archiveCode,
    required this.reportPrefix,
    required this.departmentId,
    required this.period,
    required this.createdAt,
  });

  final DateTime timestamp;
  final List<DepartmentOperationalSummary> departmentSummaries;
  final WorkCardAggregate workCardSummary;
  final IssueAggregate issueSummary;
  final ComplaintAggregate complaintSummary;
  final ReportActivityAggregate reportActivitySummary;
  final DepartmentPerformanceAggregate performanceSummary;
  final String archiveCode;
  final String reportPrefix;
  final String departmentId;
  final String period;
  final DateTime createdAt;
}

class DepartmentOperationalSummary {
  const DepartmentOperationalSummary({
    required this.departmentId,
    required this.departmentNameAr,
    required this.departmentNameEn,
    required this.completedCount,
    required this.pendingCount,
    required this.blockedCount,
    required this.delayedCount,
  });

  final String departmentId;
  final String departmentNameAr;
  final String departmentNameEn;
  final int completedCount;
  final int pendingCount;
  final int blockedCount;
  final int delayedCount;
}
