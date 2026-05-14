class ResponseDisclaimer {
  const ResponseDisclaimer({
    required this.notDoctor,
    required this.notTherapy,
    required this.notEmergencyService,
    required this.humanSupportMayBeNeeded,
  });

  static const ResponseDisclaimer safeDefault = ResponseDisclaimer(
    notDoctor: true,
    notTherapy: true,
    notEmergencyService: true,
    humanSupportMayBeNeeded: true,
  );

  final bool notDoctor;
  final bool notTherapy;
  final bool notEmergencyService;
  final bool humanSupportMayBeNeeded;

  List<String> keys() {
    return [
      if (notDoctor) 'not_doctor',
      if (notTherapy) 'not_therapy',
      if (notEmergencyService) 'not_emergency_service',
      if (humanSupportMayBeNeeded) 'human_support_may_be_needed',
    ];
  }
}
