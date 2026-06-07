class FederationReportMetadata {
  const FederationReportMetadata({
    required this.generatedBy,
    required this.reviewedBy,
    required this.approvedBy,
    required this.retentionClass,
    required this.archiveEligibility,
    required this.classification,
  });

  final String generatedBy;
  final String reviewedBy;
  final String approvedBy;
  final String retentionClass;
  final String archiveEligibility;
  final String classification;
}
