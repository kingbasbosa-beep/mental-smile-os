class GovernanceComplianceReviewMarker {
  const GovernanceComplianceReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.legalCounselRequired,
    required this.clientCanResolve,
  });

  static const GovernanceComplianceReviewMarker safeDefault =
      GovernanceComplianceReviewMarker(
    reviewRequired: true,
    reasonKey: 'compliance_review_required',
    legalCounselRequired: true,
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool legalCounselRequired;
  final bool clientCanResolve;
}
