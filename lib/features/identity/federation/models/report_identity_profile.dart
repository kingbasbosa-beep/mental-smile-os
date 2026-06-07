class ReportIdentityProfile {
  const ReportIdentityProfile({
    required this.departmentId,
    required this.reportPrefix,
    required this.stripeColor,
    required this.labelStyle,
    required this.archiveStamp,
  });

  final String departmentId;
  final String reportPrefix;
  final String stripeColor;
  final String labelStyle;
  final String archiveStamp;
}
