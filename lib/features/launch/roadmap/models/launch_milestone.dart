class LaunchMilestone {
  const LaunchMilestone({
    required this.milestoneId,
    required this.title,
    required this.surface,
    required this.successCriteria,
  });

  final String milestoneId;
  final String title;
  final String surface;
  final List<String> successCriteria;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'milestoneId': milestoneId,
      'title': title,
      'surface': surface,
      'successCriteria': successCriteria,
    };
  }
}
