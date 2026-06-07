class ReputationLocalizationLabel {
  const ReputationLocalizationLabel({
    required this.key,
    required this.labelAr,
    required this.labelEn,
  });

  final String key;
  final String labelAr;
  final String labelEn;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'key': key,
      'labelAr': labelAr,
      'labelEn': labelEn,
    };
  }
}
