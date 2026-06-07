class OwnerCapsuleManifest {
  const OwnerCapsuleManifest({
    required this.capsuleId,
    required this.title,
    required this.purpose,
    required this.version,
    required this.packageIds,
    required this.dependencyIds,
    required this.readinessStatus,
  });

  final String capsuleId;
  final String title;
  final String purpose;
  final String version;
  final List<String> packageIds;
  final List<String> dependencyIds;
  final String readinessStatus;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'capsuleId': capsuleId,
      'title': title,
      'purpose': purpose,
      'version': version,
      'packageIds': packageIds,
      'dependencyIds': dependencyIds,
      'readinessStatus': readinessStatus,
    };
  }
}
