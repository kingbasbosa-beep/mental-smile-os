class OwnerCapsulePackage {
  const OwnerCapsulePackage({
    required this.packageId,
    required this.packageType,
    required this.title,
    required this.classification,
    required this.archiveCode,
  });

  final String packageId;
  final String packageType;
  final String title;
  final String classification;
  final String archiveCode;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'packageId': packageId,
      'packageType': packageType,
      'title': title,
      'classification': classification,
      'archiveCode': archiveCode,
    };
  }
}
