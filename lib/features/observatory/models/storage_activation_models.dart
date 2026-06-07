class StorageActivationProfile {
  const StorageActivationProfile({
    required this.profileId,
    required this.storageObjects,
    required this.activationStage,
  });

  final String profileId;
  final Set<String> storageObjects;
  final String activationStage;
}

class StorageActivationDependency {
  const StorageActivationDependency({
    required this.dependencyId,
    required this.description,
    required this.required,
  });

  final String dependencyId;
  final String description;
  final bool required;
}

class StorageActivationReadiness {
  const StorageActivationReadiness({
    required this.status,
    required this.dependencies,
    required this.notes,
  });

  final String status;
  final List<StorageActivationDependency> dependencies;
  final String notes;
}
