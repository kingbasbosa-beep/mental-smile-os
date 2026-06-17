class SignalAggregationCategoryRegistry {
  const SignalAggregationCategoryRegistry._();

  static const String goalAggregates = 'goal_aggregates';
  static const String interestAggregates = 'interest_aggregates';
  static const String accessibilityAggregates = 'accessibility_aggregates';
  static const String destinationAggregates = 'destination_aggregates';
  static const String contactAggregates = 'contact_aggregates';
  static const String libraryAggregates = 'library_aggregates';

  static const List<String> values = <String>[
    goalAggregates,
    interestAggregates,
    accessibilityAggregates,
    destinationAggregates,
    contactAggregates,
    libraryAggregates,
  ];
}
