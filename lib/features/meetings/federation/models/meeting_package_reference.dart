class MeetingPackageReference {
  const MeetingPackageReference({
    required this.packageCode,
    required this.packageType,
    required this.archiveCode,
    required this.classification,
  });

  final String packageCode;
  final String packageType;
  final String archiveCode;
  final String classification;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'packageCode': packageCode,
      'packageType': packageType,
      'archiveCode': archiveCode,
      'classification': classification,
    };
  }
}
