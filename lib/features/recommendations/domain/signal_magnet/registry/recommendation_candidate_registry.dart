class RecommendationCandidateRegistry {
  const RecommendationCandidateRegistry._();

  static const String registryName = 'recommendation_candidate_registry';
  static const String registryVersion = 'recommendation_candidate_registry_v1';

  static const List<String> requiredFields = <String>[
    'candidateId',
    'candidateType',
    'matchedSignals',
    'matchScore',
    'attractionScore',
  ];
}
