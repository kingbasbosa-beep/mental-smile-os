class ArchiveExportMetadata {
  const ArchiveExportMetadata({
    required this.title,
    required this.description,
    required this.department,
    required this.period,
    required this.createdBy,
    required this.localizationProfile,
    required this.identityProfile,
  });

  final String title;
  final String description;
  final String department;
  final String period;
  final String createdBy;
  final String localizationProfile;
  final String identityProfile;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'title': title,
      'description': description,
      'department': department,
      'period': period,
      'createdBy': createdBy,
      'localizationProfile': localizationProfile,
      'identityProfile': identityProfile,
    };
  }
}
