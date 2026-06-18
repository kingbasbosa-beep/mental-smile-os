enum AccessibilityCategory {
  deafHardOfHearing('deaf_hard_of_hearing'),
  blindLowVision('blind_low_vision'),
  mobilityDisability('mobility_disability'),
  intellectualDisability('intellectual_disability'),
  autismNeurodiversity('autism_neurodiversity'),
  mentalHealthAddiction('mental_health_addiction'),
  rightsComplaints('rights_complaints'),
  globalLibraries('global_libraries');

  const AccessibilityCategory(this.value);

  final String value;

  static AccessibilityCategory fromValue(String value) {
    return AccessibilityCategory.values.firstWhere(
      (category) => category.value == value,
      orElse: () => AccessibilityCategory.globalLibraries,
    );
  }
}
