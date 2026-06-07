class FederationReportHeader {
  const FederationReportHeader({
    required this.reportId,
    required this.reportCode,
    required this.reportType,
    required this.reportCategory,
    required this.departmentId,
    required this.departmentNameAr,
    required this.departmentNameEn,
    required this.reportPrefix,
    required this.createdAt,
    required this.period,
    required this.version,
  });

  final String reportId;
  final String reportCode;
  final String reportType;
  final String reportCategory;
  final String departmentId;
  final String departmentNameAr;
  final String departmentNameEn;
  final String reportPrefix;
  final DateTime createdAt;
  final String period;
  final String version;
}
