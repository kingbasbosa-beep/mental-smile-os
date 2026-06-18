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
  static const String accessibleContactRequested =
      'accessible_contact_requested';
  static const String accessibleContactCompleted =
      'accessible_contact_completed';
  static const String accessibleProviderSelected =
      'accessible_provider_selected';
  static const String accessibleCenterSelected = 'accessible_center_selected';
  static const String supportStarted = 'support_started';
  static const String libraryCategoryOpened = 'library_category_opened';
  static const String providerProfileOpened = 'provider_profile_opened';
  static const String centerProfileOpened = 'center_profile_opened';
  static const String accessibilityHubOpened = 'accessibility_hub_opened';
  static const String accessibilityCategoryOpened =
      'accessibility_category_opened';
  static const String accessibilityResourceOpened =
      'accessibility_resource_opened';
  static const String accessibilityResourceSaved =
      'accessibility_resource_saved';
  static const String accessibilityResourceBrokenLinkReported =
      'accessibility_resource_broken_link_reported';
  static const String accessibilityModeSelected = 'accessibility_mode_selected';

  static const List<String> values = <String>[
    goalSelected,
    interestSelected,
    accessibilityInterest,
    communicationPreferenceSelected,
    destinationSaved,
    providerContactStarted,
    centerContactStarted,
    accessibleContactRequested,
    accessibleContactCompleted,
    accessibleProviderSelected,
    accessibleCenterSelected,
    supportStarted,
    libraryCategoryOpened,
    providerProfileOpened,
    centerProfileOpened,
    accessibilityHubOpened,
    accessibilityCategoryOpened,
    accessibilityResourceOpened,
    accessibilityResourceSaved,
    accessibilityResourceBrokenLinkReported,
    accessibilityModeSelected,
  ];
}
