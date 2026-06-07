class ProviderCenterSignalRegistry {
  const ProviderCenterSignalRegistry._();

  static const String providerProfileObserved = 'provider_profile_observed';
  static const String centerProfileObserved = 'center_profile_observed';
  static const String contactOpened = 'contact_opened';
  static const String ratingSubmitted = 'rating_submitted';
  static const String commentViewExpanded = 'comment_view_expanded';
  static const String commentViewCollapsed = 'comment_view_collapsed';

  static const Set<String> values = <String>{
    providerProfileObserved,
    centerProfileObserved,
    contactOpened,
    ratingSubmitted,
    commentViewExpanded,
    commentViewCollapsed,
  };
}
