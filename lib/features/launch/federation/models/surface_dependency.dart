class SurfaceDependency {
  const SurfaceDependency({
    required this.surface,
    required this.dependency,
    required this.dependencyType,
  });

  final String surface;
  final String dependency;
  final String dependencyType;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'surface': surface,
      'dependency': dependency,
      'dependencyType': dependencyType,
    };
  }
}
