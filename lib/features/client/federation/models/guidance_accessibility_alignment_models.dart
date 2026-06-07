class RegistrationGuidanceProfile {
  const RegistrationGuidanceProfile({
    required this.profileId,
    required this.easyReadingEnabled,
    required this.screenReaderEnabled,
    required this.audioLabelsEnabled,
    required this.learnMoreEnabled,
  });

  final String profileId;
  final bool easyReadingEnabled;
  final bool screenReaderEnabled;
  final bool audioLabelsEnabled;
  final bool learnMoreEnabled;
}

class FieldGuidanceProfile {
  const FieldGuidanceProfile({
    required this.fieldId,
    required this.easyReadingLabel,
    required this.screenReaderLabel,
    required this.audioLabel,
    required this.learnMoreReference,
  });

  final String fieldId;
  final String easyReadingLabel;
  final String screenReaderLabel;
  final String audioLabel;
  final String learnMoreReference;
}

class AccessibilityGuidanceAlignment {
  const AccessibilityGuidanceAlignment({
    required this.accessibilityMode,
    required this.guidanceProfileId,
    required this.alignmentStatus,
  });

  final String accessibilityMode;
  final String guidanceProfileId;
  final String alignmentStatus;
}

class AccessibilityRegistrationProfile {
  const AccessibilityRegistrationProfile({
    required this.profileId,
    required this.supportedModes,
    required this.defaultMode,
  });

  final String profileId;
  final Set<String> supportedModes;
  final String defaultMode;
}

class AccessibilityFieldProfile {
  const AccessibilityFieldProfile({
    required this.fieldId,
    required this.supportedModes,
    required this.requiredForRegistration,
  });

  final String fieldId;
  final Set<String> supportedModes;
  final bool requiredForRegistration;
}

class AccessibilityRegistrationAlignment {
  const AccessibilityRegistrationAlignment({
    required this.profileId,
    required this.registrationReference,
    required this.guidanceReference,
  });

  final String profileId;
  final String registrationReference;
  final String guidanceReference;
}
