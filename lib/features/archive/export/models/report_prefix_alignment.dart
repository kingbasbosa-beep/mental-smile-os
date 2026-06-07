class ReportPrefixAlignment {
  const ReportPrefixAlignment({
    required this.department,
    required this.prefix,
    required this.reportCodeConvention,
  });

  final String department;
  final String prefix;
  final String reportCodeConvention;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'department': department,
      'prefix': prefix,
      'reportCodeConvention': reportCodeConvention,
    };
  }
}
