class RegistrationSignalRegistry {
  const RegistrationSignalRegistry._();

  static const String registrationFieldRegistered =
      'registration_field_registered';
  static const String fieldParityValidated = 'field_parity_validated';
  static const String profileAlignmentDefined = 'profile_alignment_defined';
  static const String accessibilityProfileDefined =
      'accessibility_profile_defined';
  static const String registrationGuidanceDefined =
      'registration_guidance_defined';

  static const Set<String> values = <String>{
    registrationFieldRegistered,
    fieldParityValidated,
    profileAlignmentDefined,
    accessibilityProfileDefined,
    registrationGuidanceDefined,
  };
}
