class UsageAggregate {
  const UsageAggregate({
    required this.views,
    required this.opens,
    required this.engagements,
    required this.completions,
  });

  final int views;
  final int opens;
  final int engagements;
  final int completions;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'views': views,
      'opens': opens,
      'engagements': engagements,
      'completions': completions,
    };
  }
}
