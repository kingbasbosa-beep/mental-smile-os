class MeetingTypeRegistry {
  const MeetingTypeRegistry._();

  static const String weeklyReview = 'weekly_review';
  static const String monthlyReview = 'monthly_review';
  static const String quarterlyReview = 'quarterly_review';
  static const String annualReview = 'annual_review';
  static const String operationalReview = 'operational_review';
  static const String commercialReview = 'commercial_review';
  static const String residentialReview = 'residential_review';
  static const String strategicReview = 'strategic_review';
  static const String constitutionalReview = 'constitutional_review';
  static const String ownerReview = 'owner_review';
  static const String monitoringReview = 'monitoring_review';

  static const Set<String> values = <String>{
    weeklyReview,
    monthlyReview,
    quarterlyReview,
    annualReview,
    operationalReview,
    commercialReview,
    residentialReview,
    strategicReview,
    constitutionalReview,
    ownerReview,
    monitoringReview,
  };
}
