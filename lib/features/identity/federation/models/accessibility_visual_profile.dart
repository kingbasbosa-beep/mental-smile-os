class AccessibilityVisualProfile {
  const AccessibilityVisualProfile({
    required this.profileKey,
    required this.labelAr,
    required this.labelEn,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  final String profileKey;
  final String labelAr;
  final String labelEn;
  final String descriptionAr;
  final String descriptionEn;
}

class AccessibilityVisualProfileKey {
  const AccessibilityVisualProfileKey._();

  static const String standard = 'standard';
  static const String easyReading = 'easy_reading';
  static const String highVisibility = 'high_visibility';
  static const String audioAssisted = 'audio_assisted';
  static const String visualAssisted = 'visual_assisted';

  static const Set<String> values = <String>{
    standard,
    easyReading,
    highVisibility,
    audioAssisted,
    visualAssisted,
  };
}
