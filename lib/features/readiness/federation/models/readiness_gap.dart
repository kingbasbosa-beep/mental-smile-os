class ReadinessGap {
  const ReadinessGap({
    required this.gapId,
    required this.surface,
    required this.severity,
    required this.description,
  });

  final String gapId;
  final String surface;
  final String severity;
  final String description;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'gapId': gapId,
      'surface': surface,
      'severity': severity,
      'description': description,
    };
  }
}
