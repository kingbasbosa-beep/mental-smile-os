class SignalScore {
  const SignalScore({
    required this.matchedSignals,
    required this.totalSignals,
  });

  final int matchedSignals;
  final int totalSignals;

  double get ratio => totalSignals == 0 ? 0 : matchedSignals / totalSignals;
}

class SignalRecommendationDraft {
  const SignalRecommendationDraft({
    required this.targetId,
    required this.targetType,
    required this.score,
    required this.matchedSignals,
  });

  final String targetId;
  final String targetType;
  final SignalScore score;
  final List<String> matchedSignals;
}

class SignalMatcher {
  const SignalMatcher();

  SignalScore score({
    required Iterable<String> sourceSignals,
    required Iterable<String> targetSignals,
  }) {
    final source = sourceSignals.map((signal) => signal.trim()).toSet()
      ..remove('');
    final target = targetSignals.map((signal) => signal.trim()).toSet()
      ..remove('');
    final matched = source.intersection(target);
    return SignalScore(
      matchedSignals: matched.length,
      totalSignals: target.length,
    );
  }

  SignalRecommendationDraft draft({
    required String targetId,
    required String targetType,
    required Iterable<String> sourceSignals,
    required Iterable<String> targetSignals,
  }) {
    final source = sourceSignals.map((signal) => signal.trim()).toSet()
      ..remove('');
    final target = targetSignals.map((signal) => signal.trim()).toSet()
      ..remove('');
    final matched = source.intersection(target).toList(growable: false);
    return SignalRecommendationDraft(
      targetId: targetId,
      targetType: targetType,
      score: SignalScore(
        matchedSignals: matched.length,
        totalSignals: target.length,
      ),
      matchedSignals: matched,
    );
  }
}
