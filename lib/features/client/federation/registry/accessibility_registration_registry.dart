class AccessibilityRegistrationRegistry {
  const AccessibilityRegistrationRegistry._();

  static const String standard = 'standard';
  static const String easyReading = 'easy_reading';
  static const String audioAssisted = 'audio_assisted';
  static const String visualAssisted = 'visual_assisted';

  static const Set<String> values = <String>{
    standard,
    easyReading,
    audioAssisted,
    visualAssisted,
  };
}
