class OwnerLocalizationProfile {
  const OwnerLocalizationProfile({
    required this.labelAr,
    required this.labelEn,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  final String labelAr;
  final String labelEn;
  final String descriptionAr;
  final String descriptionEn;
}

class OwnerGuidanceProfile {
  const OwnerGuidanceProfile({
    required this.guidanceAr,
    required this.guidanceEn,
    required this.warningAr,
    required this.warningEn,
  });

  final String guidanceAr;
  final String guidanceEn;
  final String warningAr;
  final String warningEn;
}

class OwnerEasyReadingProfile {
  const OwnerEasyReadingProfile({
    required this.easyAr,
    required this.easyEn,
  });

  final String easyAr;
  final String easyEn;
}
