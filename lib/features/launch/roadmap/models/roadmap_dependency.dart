class RoadmapDependency {
  const RoadmapDependency({
    required this.dependencyId,
    required this.dependencyType,
    required this.description,
  });

  final String dependencyId;
  final String dependencyType;
  final String description;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'dependencyId': dependencyId,
      'dependencyType': dependencyType,
      'description': description,
    };
  }
}
