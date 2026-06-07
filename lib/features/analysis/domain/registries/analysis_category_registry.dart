class AnalysisCategoryRegistry {
  const AnalysisCategoryRegistry._();

  static const String goalAnalysis = 'goal_analysis';
  static const String interestAnalysis = 'interest_analysis';
  static const String accessibilityAnalysis = 'accessibility_analysis';
  static const String destinationAnalysis = 'destination_analysis';
  static const String libraryAnalysis = 'library_analysis';
  static const String providerDemandAnalysis = 'provider_demand_analysis';
  static const String centerDemandAnalysis = 'center_demand_analysis';

  static const List<String> values = <String>[
    goalAnalysis,
    interestAnalysis,
    accessibilityAnalysis,
    destinationAnalysis,
    libraryAnalysis,
    providerDemandAnalysis,
    centerDemandAnalysis,
  ];
}
