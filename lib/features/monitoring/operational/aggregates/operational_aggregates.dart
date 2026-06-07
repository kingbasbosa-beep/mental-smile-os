class WorkCardAggregate {
  const WorkCardAggregate({
    required this.totalCreated,
    required this.totalReceived,
    required this.totalAcknowledged,
    required this.totalStarted,
    required this.totalResolved,
    required this.totalVerified,
    required this.totalArchived,
    required this.totalBlocked,
    required this.archiveCode,
    required this.reportPrefix,
    required this.departmentId,
    required this.period,
    required this.createdAt,
  });

  final int totalCreated;
  final int totalReceived;
  final int totalAcknowledged;
  final int totalStarted;
  final int totalResolved;
  final int totalVerified;
  final int totalArchived;
  final int totalBlocked;
  final String archiveCode;
  final String reportPrefix;
  final String departmentId;
  final String period;
  final DateTime createdAt;
}

class IssueAggregate {
  const IssueAggregate({
    required this.detected,
    required this.resolved,
    required this.reopened,
    required this.averageResolutionTime,
    required this.archiveCode,
    required this.reportPrefix,
    required this.departmentId,
    required this.period,
    required this.createdAt,
  });

  final int detected;
  final int resolved;
  final int reopened;
  final Duration averageResolutionTime;
  final String archiveCode;
  final String reportPrefix;
  final String departmentId;
  final String period;
  final DateTime createdAt;
}

class ComplaintAggregate {
  const ComplaintAggregate({
    required this.received,
    required this.resolved,
    required this.escalated,
    required this.pending,
    required this.archiveCode,
    required this.reportPrefix,
    required this.departmentId,
    required this.period,
    required this.createdAt,
  });

  final int received;
  final int resolved;
  final int escalated;
  final int pending;
  final String archiveCode;
  final String reportPrefix;
  final String departmentId;
  final String period;
  final DateTime createdAt;
}

class ReportActivityAggregate {
  const ReportActivityAggregate({
    required this.created,
    required this.reviewed,
    required this.archived,
    required this.archiveCode,
    required this.reportPrefix,
    required this.departmentId,
    required this.period,
    required this.createdAt,
  });

  final int created;
  final int reviewed;
  final int archived;
  final String archiveCode;
  final String reportPrefix;
  final String departmentId;
  final String period;
  final DateTime createdAt;
}

class DepartmentPerformanceAggregate {
  const DepartmentPerformanceAggregate({
    required this.departmentId,
    required this.period,
    required this.completedCount,
    required this.pendingCount,
    required this.blockedCount,
    required this.delayedCount,
    required this.verificationRate,
    required this.archiveCode,
    required this.reportPrefix,
    required this.createdAt,
  });

  final String departmentId;
  final String period;
  final int completedCount;
  final int pendingCount;
  final int blockedCount;
  final int delayedCount;
  final double verificationRate;
  final String archiveCode;
  final String reportPrefix;
  final DateTime createdAt;
}
