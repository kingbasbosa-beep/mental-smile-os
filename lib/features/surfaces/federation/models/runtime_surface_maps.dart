class RuntimeSurfaceMap {
  const RuntimeSurfaceMap({
    required this.mapId,
    required this.surfaces,
    required this.notes,
  });

  final String mapId;
  final Set<String> surfaces;
  final String notes;
}

class SurfaceDependencyMap {
  const SurfaceDependencyMap({
    required this.surfaceId,
    required this.dependencies,
    required this.dependencyType,
  });

  final String surfaceId;
  final Set<String> dependencies;
  final String dependencyType;
}

class SurfaceRelationshipMap {
  const SurfaceRelationshipMap({
    required this.sourceSurface,
    required this.targetSurface,
    required this.relationshipType,
  });

  final String sourceSurface;
  final String targetSurface;
  final String relationshipType;
}
