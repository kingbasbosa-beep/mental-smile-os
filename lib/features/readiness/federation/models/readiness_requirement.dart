class ReadinessRequirement {
  const ReadinessRequirement({
    required this.requirementId,
    required this.surface,
    required this.description,
    required this.priority,
  });

  final String requirementId;
  final String surface;
  final String description;
  final String priority;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'requirementId': requirementId,
      'surface': surface,
      'description': description,
      'priority': priority,
    };
  }
}
