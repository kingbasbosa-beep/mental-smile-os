class SignalAggregationCategoryRegistry {
  const SignalAggregationCategoryRegistry._();

  static const String accessibilityAggregates = 'accessibility_aggregates';
  static const String destinationAggregates = 'destination_aggregates';
  static const String contactAggregates = 'contact_aggregates';
  static const String libraryAggregates = 'library_aggregates';

  static const List<String> values = <String>[
    accessibilityAggregates,
    destinationAggregates,
    contactAggregates,
    libraryAggregates,
  ];
}
