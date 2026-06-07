class FederationSurfaceProfile {
  const FederationSurfaceProfile({
    required this.surfaceId,
    required this.surfaceType,
    required this.displayName,
    required this.exists,
    required this.visible,
    required this.planned,
  });

  final String surfaceId;
  final String surfaceType;
  final String displayName;
  final bool exists;
  final bool visible;
  final bool planned;
}

class SurfaceSectionProfile {
  const SurfaceSectionProfile({
    required this.sectionId,
    required this.surfaceId,
    required this.title,
    required this.visible,
  });

  final String sectionId;
  final String surfaceId;
  final String title;
  final bool visible;
}

class SurfaceCapabilityProfile {
  const SurfaceCapabilityProfile({
    required this.capabilityId,
    required this.surfaceId,
    required this.capabilityType,
    required this.enabled,
  });

  final String capabilityId;
  final String surfaceId;
  final String capabilityType;
  final bool enabled;
}

class SurfaceVisibilityProfile {
  const SurfaceVisibilityProfile({
    required this.surfaceId,
    required this.visibilityStatus,
    required this.notes,
  });

  final String surfaceId;
  final String visibilityStatus;
  final String notes;
}

class SurfaceReadinessProfile {
  const SurfaceReadinessProfile({
    required this.surfaceId,
    required this.readinessStatus,
    required this.requiredActions,
  });

  final String surfaceId;
  final String readinessStatus;
  final List<String> requiredActions;
}
