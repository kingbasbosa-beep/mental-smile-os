class ReportCodeConvention {
  const ReportCodeConvention({
    required this.prefix,
    required this.periodCode,
    required this.year,
    required this.sequence,
  });

  final String prefix;
  final String periodCode;
  final int year;
  final int sequence;

  String get code {
    return '$prefix-$periodCode-$year-${sequence.toString().padLeft(3, '0')}';
  }
}
