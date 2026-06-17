class AccessibilityTextProfile {
  const AccessibilityTextProfile({
    required this.profileKey,
    required this.label,
    required this.description,
  });

  final String profileKey;
  final FederationAccessibilityLabel label;
  final FederationAccessibilityLabel description;
}

class FederationAccessibilityLabel {
  const FederationAccessibilityLabel({
    required this.ar,
    required this.en,
  });

  final String ar;
  final String en;
}

class AccessibilityTextProfileKey {
  const AccessibilityTextProfileKey._();

  static const String standard = 'standard';
  static const String easyReading = 'easy_reading';
  static const String screenReader = 'screen_reader';
  static const String audioAssisted = 'audio_assisted';
  static const String visualAssisted = 'visual_assisted';
}
