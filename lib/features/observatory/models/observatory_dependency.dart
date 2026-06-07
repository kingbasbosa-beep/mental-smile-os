class ObservatoryDependency {
  const ObservatoryDependency({
    required this.dependencyId,
    required this.source,
    required this.target,
    required this.dependencyType,
  });

  final String dependencyId;
  final String source;
  final String target;
  final String dependencyType;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'dependencyId': dependencyId,
      'source': source,
      'target': target,
      'dependencyType': dependencyType,
    };
  }
}
