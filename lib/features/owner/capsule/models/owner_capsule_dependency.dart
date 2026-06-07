class OwnerCapsuleDependency {
  const OwnerCapsuleDependency({
    required this.dependencyId,
    required this.dependencyType,
    required this.description,
    required this.requiredBeforeLaunch,
  });

  final String dependencyId;
  final String dependencyType;
  final String description;
  final bool requiredBeforeLaunch;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'dependencyId': dependencyId,
      'dependencyType': dependencyType,
      'description': description,
      'requiredBeforeLaunch': requiredBeforeLaunch,
    };
  }
}
