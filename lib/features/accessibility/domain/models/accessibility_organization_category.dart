enum AccessibilityOrganizationCategory {
  deaf('deaf', 'Deaf'),
  blind('blind', 'Blind'),
  autism('autism', 'Autism'),
  learningDifficulties('learning_difficulties', 'Learning Difficulties'),
  literacy('literacy', 'Literacy'),
  familySupport('family_support', 'Family Support'),
  recovery('recovery', 'Recovery'),
  mentalHealth('mental_health', 'Mental Health');

  const AccessibilityOrganizationCategory(this.value, this.label);

  final String value;
  final String label;

  static AccessibilityOrganizationCategory fromValue(String value) {
    return AccessibilityOrganizationCategory.values.firstWhere(
      (category) => category.value == value,
      orElse: () => AccessibilityOrganizationCategory.familySupport,
    );
  }
}
