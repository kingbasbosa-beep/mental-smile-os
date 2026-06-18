enum AccessibilityDisabilityType {
  deafHardOfHearing('deaf_hard_of_hearing'),
  blindLowVision('blind_low_vision'),
  mobilityDisability('mobility_disability'),
  intellectualDisability('intellectual_disability'),
  autismNeurodiversity('autism_neurodiversity'),
  mentalHealthAddiction('mental_health_addiction'),
  rightsComplaints('rights_complaints'),
  generalAccessibility('general_accessibility');

  const AccessibilityDisabilityType(this.value);

  final String value;

  static AccessibilityDisabilityType fromValue(String value) {
    return AccessibilityDisabilityType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => AccessibilityDisabilityType.generalAccessibility,
    );
  }
}
