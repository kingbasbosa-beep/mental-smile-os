class OwnerCapsuleVersion {
  const OwnerCapsuleVersion({
    required this.versionId,
    required this.versionLabel,
    required this.createdAt,
    required this.notes,
  });

  final String versionId;
  final String versionLabel;
  final DateTime createdAt;
  final String notes;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'versionId': versionId,
      'versionLabel': versionLabel,
      'createdAt': createdAt.toIso8601String(),
      'notes': notes,
    };
  }
}
