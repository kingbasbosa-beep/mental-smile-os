class MentalSmileAiIdentity {
  const MentalSmileAiIdentity._();

  static const String productName = 'Mental Smile AI';
  static const String role = 'supportive_safety_placeholder';
  static const String nonMedicalBoundary =
      'not_doctor_not_therapist_not_emergency_service';

  static const List<String> prohibitedRoles = [
    'doctor',
    'therapist',
    'diagnostician',
    'emergency_responder',
    'medication_authority',
  ];

  static const List<String> requiredDisclosures = [
    'not_a_doctor',
    'not_therapy',
    'not_emergency_service',
    'no_diagnosis_or_treatment',
    'human_help_may_be_required',
  ];
}
