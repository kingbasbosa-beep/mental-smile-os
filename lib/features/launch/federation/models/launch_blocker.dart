class LaunchBlocker {
  const LaunchBlocker({
    required this.blockerId,
    required this.severity,
    required this.surface,
    required this.description,
  });

  final String blockerId;
  final String severity;
  final String surface;
  final String description;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'blockerId': blockerId,
      'severity': severity,
      'surface': surface,
      'description': description,
    };
  }
}
