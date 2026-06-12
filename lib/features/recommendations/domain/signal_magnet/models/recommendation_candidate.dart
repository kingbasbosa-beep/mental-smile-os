class RecommendationCandidate {
  const RecommendationCandidate({
    required this.candidateId,
    required this.candidateType,
    required this.matchedSignals,
    required this.matchScore,
    required this.attractionScore,
  });

  final String candidateId;
  final String candidateType;
  final List<String> matchedSignals;
  final double matchScore;
  final double attractionScore;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'candidateId': candidateId,
      'candidateType': candidateType,
      'matchedSignals': matchedSignals,
      'matchScore': matchScore,
      'attractionScore': attractionScore,
    };
  }

  factory RecommendationCandidate.fromMap(Map<String, dynamic> map) {
    return RecommendationCandidate(
      candidateId: (map['candidateId'] ?? '').toString(),
      candidateType: (map['candidateType'] ?? '').toString(),
      matchedSignals: _stringList(map['matchedSignals']),
      matchScore: _doubleValue(map['matchScore']),
      attractionScore: _doubleValue(map['attractionScore']),
    );
  }

  static double _doubleValue(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse((value ?? '').toString()) ?? 0;
  }

  static List<String> _stringList(Object? value) {
    if (value is Iterable) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList(growable: false);
    }
    return const <String>[];
  }
}
