class SponsoredGuidancePolicy {
  const SponsoredGuidancePolicy._();

  static const bool residentialAdsMustBeKnowledgeFirst = true;
  static const bool directSalesOrBookingForbidden = true;
  static const bool guidanceOrInfoCardRequiredFirst = true;
  static const bool commercialPressureLanguageForbidden = true;
  static const bool treatmentPromisesForbidden = true;
  static const bool diagnosisOrSensitiveTargetingForbidden = true;

  static const List<String> policyRules = <String>[
    'Sponsored residential content must appear as knowledge, opportunity, or guidance.',
    'Sponsored content must not go directly to sale or booking.',
    'Sponsored content must pass through guidance or an info card first.',
    'Commercial pressure language is forbidden.',
    'Treatment promises are forbidden.',
    'Diagnosis or sensitive targeting is forbidden.',
  ];
}
