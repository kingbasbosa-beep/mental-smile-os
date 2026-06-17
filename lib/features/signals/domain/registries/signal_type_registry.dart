class SignalTypeRegistry {
  const SignalTypeRegistry._();

  static const String goalSelected = 'goal_selected';
  static const String interestSelected = 'interest_selected';
  static const String accessibilityInterest = 'accessibility_interest';
  static const String communicationPreferenceSelected =
      'communication_preference_selected';
  static const String destinationSaved = 'destination_saved';
  static const String providerContactStarted = 'provider_contact_started';
  static const String centerContactStarted = 'center_contact_started';
  static const String supportStarted = 'support_started';
  static const String libraryCategoryOpened = 'library_category_opened';
  static const String providerProfileOpened = 'provider_profile_opened';
  static const String centerProfileOpened = 'center_profile_opened';

  static const List<String> values = <String>[
    goalSelected,
    interestSelected,
    accessibilityInterest,
    communicationPreferenceSelected,
    destinationSaved,
    providerContactStarted,
    centerContactStarted,
    supportStarted,
    libraryCategoryOpened,
    providerProfileOpened,
    centerProfileOpened,
  ];
}
